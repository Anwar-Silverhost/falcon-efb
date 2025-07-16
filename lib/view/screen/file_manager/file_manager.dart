import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:dio/dio.dart';
import 'package:falcon_aviation/view/screen/file_manager/view_pdf.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:iconly/iconly.dart';
import 'package:path_provider/path_provider.dart';

import '../../../utils/app_color.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/app_font.dart';
import '../../../utils/app_sp.dart';
import '../../../utils/app_urls.dart';

import 'package:http/http.dart' as http;

import '../profile/profile_screen.dart';

enum _SelectedTab { home, folder, document, person }

class FileManager extends StatefulWidget {
  const FileManager({Key? key}) : super(key: key);

  @override
  State<FileManager> createState() => _FileManagerState();
}

class _FileManagerState extends State<FileManager> {
  var _selectedTab = _SelectedTab.folder;

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
      if (_selectedTab == _SelectedTab.person) {
        Navigator.pushNamed(
          context,
          "/profile",
        );
      } else if (_selectedTab == _SelectedTab.home) {
        Navigator.pushNamed(
          context,
          "/home",
        );
      } else if (_selectedTab == _SelectedTab.folder) {
        Navigator.pushNamed(
          context,
          "/file_manager",
        );
      }else if (_selectedTab == _SelectedTab.document) {
        Navigator.pushNamed(
          context,
          "/forms",
        );
      }
    });
  }

  double _downloadProgress = 0.0;

  List<dynamic> data = [];

  List<dynamic> datafromDevice = [];

  String userToken = '';
  String fullName = '';
  String selectedGroupName = '';
  List<dynamic> apps = [];
  String profilePic = '';
  String UserID = '';

  String selectedGroupId_id = '';

  var profile = dummyProfile;

  int totalFiles = 0;
  int downloadedFilesCount = 0;
  String _downloadedpdfName = '';

  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  String _pdfPath = '';
  bool _showPdf = false;

  String _pdfName = '';

  bool isDownloading = false;

  bool isFileshow = false;


  @override
  void initState() {
    super.initState();
    getUserToken();
  }

  Future<void> getUserToken() async {
    AppSp appSp = AppSp();
    userToken = await appSp.getToken();
    fullName = await appSp.getFullname();
    selectedGroupName = await appSp.getSelectedgroup();
    UserID = await appSp.getUserID();
    profile = await appSp.getUserprofilepic();
    selectedGroupId_id = await appSp.getSelectedgroupID();

    var pdfDocuments = await appSp.getPdfdocuments();
    if (pdfDocuments.isNotEmpty) {
      try {
        getFilesbyGroup();
      } catch (e) {
        setState(() {
          datafromDevice = pdfDocuments;
        });
      }
    } else {
      getFilesbyGroup();

    }

    setState(() {
      selectedGroupId_id = selectedGroupId_id;
      datafromDevice = pdfDocuments;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getFilesbyGroup() async {
    print("${AppUrls.documents}?group=$selectedGroupId_id");

    setState(() {
      isDownloading = true;
    });


    try {
      var response = await http.Client().get(
        Uri.parse("${AppUrls.documents}?group=$selectedGroupId_id"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $userToken"
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print(responseData);

        List<dynamic> fetchedData = responseData['data'];
        List<Map<String, dynamic>> appsWithPaths = [];

        for (var element in fetchedData) {
          appsWithPaths.add({
            "name": element['name'],
            "type": element['type'],
            "id": element['id'],
            "children": element['children']
          });
        }

        String appsList = jsonEncode(appsWithPaths);
        await AppSp().setPdfdocuments(appsList);
        setState(() {
          datafromDevice = fetchedData;
        });

        await extractDocuments(fetchedData);
        setState(() {
          EasyLoading.showToast('Updating Completed');
          isDownloading = false;
        });
      } else {
        setState(() {
          EasyLoading.showToast('Something went wrong!\n Please check again later.');
          isDownloading = false;
        });
        EasyLoading.showToast('Something went wrong!\n Please check again later.');

        // EasyLoading.showError("Failed to get data");
      }
    } catch (e) {
      setState(() {
        if (e.toString().contains('Connection refused')) {
          EasyLoading.showToast('You are in offline mode!\nPlease check your network connection.');
        } else {
          EasyLoading.showToast('Something went wrong!\nPlease check again later.');
        }
        isDownloading = false;
      });
      print("$e");
    }

  }

  Future<void> extractDocuments(List<dynamic> data) async {
    EasyLoading.showToast('Updating...');
    for (var element in data) {
      if (element['type'] == 'document') {
        totalFiles++;

        final String fileUrl = element['url'];
        final String fileName = fileUrl.split('/').last;

        FileDownloadManager downloadManager = FileDownloadManager();
        await downloadManager.downloadFile(
          fileUrl,
          fileName,
          context,
              (progress) {
            setState(() {
              _downloadProgress = progress;
            });
          },
        );

        setState(() {
          downloadedFilesCount++;
          _downloadedpdfName = element['name'];
          _downloadProgress = downloadedFilesCount / totalFiles;
        });
      } else if (element['type'] == 'folder' && element['children'] != null) {
        await extractDocuments(element['children']); // Process nested folders
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FB),
      extendBody: true,
      body: Stack(
        children: [
          Image.asset(
            WhiteBackground,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 1200.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5.0),
                  Container(
                    padding: const EdgeInsets.all(35.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Logo
                        Image.asset(
                          RedBlackLogo,
                          height: 90.0,
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  fullName,
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontFamily: AppFont.OutfitFont,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  selectedGroupName,
                                  style: TextStyle(
                                    color: const Color(0xFF969492),
                                    fontSize: 14,
                                    fontFamily: AppFont.OutfitFont,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 10.0),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => ProfileScreen(),
                                  ),
                                );
                              },
                              child: CircleAvatar(
                                backgroundImage: FileImage(File(profile)),
                                radius: 30.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Expanded(
                        //   flex: 45,
                        //   child: Container(
                        //     height: MediaQuery.of(context).size.height * 0.65,
                        //     padding: EdgeInsets.all(10.0),
                        //     decoration: BoxDecoration(
                        //       color: Colors.white,
                        //       borderRadius: BorderRadius.circular(25),
                        //     ),
                        //     child: SingleChildScrollView(
                        //       child: Column(
                        //         children: [
                        //           // Conditionally show the progress bar and download count if downloading is in progress
                        //           if (isDownloading) ...[
                        //             Row(
                        //               mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //               children: [
                        //                 Text(''),
                        //                 SizedBox(width: 50),
                        //                 Text(
                        //                   '${downloadedFilesCount.toString()} / ${totalFiles.toString()}',
                        //                 ),
                        //               ],
                        //             ),
                        //             Container(
                        //               padding: EdgeInsets.all(15.0),
                        //               child: GradientProgressBar(
                        //                 progress: _downloadProgress / 100, // Ensure progress is between 0 and 1
                        //               ),
                        //             ),
                        //           ],
                        //
                        //
                        //           // ListView with data from the device
                        //           ListView(
                        //             shrinkWrap: true,
                        //             children: datafromDevice.map((item) => buildList(item)).toList(),
                        //           ),
                        //         ],
                        //
                        //
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        Expanded(
                          flex: 45,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.65,
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Column(
                              children: [
                                // Conditionally show the progress bar and download count if downloading is in progress
                                if (isDownloading) ...[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(''),
                                      SizedBox(width: 50),
                                      Text(
                                        '${downloadedFilesCount.toString()} / ${totalFiles.toString()}',
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(15.0),
                                    child: GradientProgressBar(
                                      progress: _downloadProgress / 100, // Ensure progress is between 0 and 1
                                    ),
                                  ),
                                ],

                                // ListView with data from the device
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: datafromDevice.length,
                                    itemBuilder: (context, index) {
                                      return buildList(datafromDevice[index]);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),



                        if (isFileshow) ...[
                        SizedBox( width: MediaQuery.of(context).size.width * 0.04),
                        Expanded(
                          flex: 65,
                          child: Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 3,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height * 0.55,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: AppColor.primaryColor,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Text(
                                          _pdfName,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.012,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Expanded(
                                      child: Center(
                                        child: _showPdf && _pdfPath.isNotEmpty
                                            ? PDFView(
                                                key: ValueKey(_pdfPath),
                                                filePath: _pdfPath,
                                              )
                                            : Center(
                                                child: Text('No PDF loaded')),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: 23,
                                right: 23,
                                child: _showPdf && _pdfPath.isNotEmpty
                                    ? ElevatedButton(
                                        onPressed: () {
                                          print(_pdfPath);
                                          Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                              builder: (context) => ViewPdf(
                                                  pdfPath: _pdfPath,
                                                  pdfName: _pdfName),
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.all(
                                              15), // Make the button square
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                5), // Square with small rounded corners
                                          ),
                                          backgroundColor: Colors.black54,
                                        ),
                                        child: Container(
                                          width:
                                              20, // Set button width and height to create square shape
                                          height: 20,
                                          alignment: Alignment.center,
                                          child: Icon(
                                            Icons
                                                .zoom_out_map, // Use any icon you prefer
                                            color: Colors.white, // Icon color
                                          ),
                                        ),
                                      )
                                    : Text(''),
                              ),
                            ],
                          ),
                        ),
            ]
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: 5,
          right:
              MediaQuery.of(context).size.width * 0.18, // 10% of screen width
          left: MediaQuery.of(context).size.width * 0.18, // 10% of screen width
        ),
        child: CrystalNavigationBar(
          currentIndex: _SelectedTab.values.indexOf(_selectedTab),
          indicatorColor: AppColor.primaryColor,
          borderRadius: 10,
          paddingR: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          itemPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          height: 110,
          unselectedItemColor: Colors.white70,
          backgroundColor: AppColor.primaryColor,
          splashBorderRadius: 10,
          outlineBorderColor: Colors.black.withOpacity(0.1),
          onTap: _handleIndexChanged,
          enableFloatingNavBar: true,
          enablePaddingAnimation: true,
          items: [
            CrystalNavigationBarItem(
              icon: IconlyBold.home,
              unselectedIcon: IconlyLight.home,
              selectedColor: Colors.white,
            ),
            CrystalNavigationBarItem(
              icon: IconlyBold.folder,
              unselectedIcon: IconlyLight.folder,
              selectedColor: Colors.white,
            ),
            CrystalNavigationBarItem(
              icon: IconlyBold.document,
              unselectedIcon: IconlyLight.document,
              selectedColor: Colors.white,
            ),
            CrystalNavigationBarItem(
              icon: IconlyBold.user_3,
              unselectedIcon: IconlyLight.user_1,
              selectedColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildList(Map<String, dynamic> item, [double padding = 0.0]) {
    if (item['type'] == 'folder') {
      return InkWell(
        hoverColor: Colors.transparent, // Remove hover color
        onTap: () {
          setState(() {
            _pdfPath = '';
            _showPdf = false;
          });
        },
        child: ExpansionTile(
          collapsedShape: RoundedRectangleBorder(
            side: BorderSide.none,
          ),
          shape: RoundedRectangleBorder(
            side: BorderSide.none,
          ),
          tilePadding:
              EdgeInsets.only(left: padding + 10.0), // Add padding for folder
          title: Text(item['name']),
          leading: Image.asset(
            foldericon,
            width: 30.0,
            height: 30.0,
          ),
          children: item['children']
              .map<Widget>((child) => buildList(
                  child, padding + 20.0)) // Increase padding for child items
              .toList(),
        ),
      );
    } else if (item['type'] == 'document' && item.containsKey('children')) {
      return InkWell(
        hoverColor: Colors.transparent, // Remove hover color
        onTap: () {
          setState(() {
            _pdfPath = '';
            _showPdf = false;
          });
        },
        child: ExpansionTile(
          collapsedShape: RoundedRectangleBorder(
            side: BorderSide.none,
          ),
          shape: RoundedRectangleBorder(
            side: BorderSide.none,
          ),
          tilePadding: EdgeInsets.only(
              left: padding + 10.0), // Add padding for document with children
          trailing: const SizedBox.shrink(), // No trailing icon
          leading: const Icon(
              Icons.keyboard_arrow_right_outlined), // Icon for document
          title: Container(
            padding: EdgeInsets.only(
                left: 20.0,
                top: 20,
                bottom: 20), // Adjust inner padding for document
            child: Row(
              children: [
                Image.asset(
                  pdficon,
                  width: 30.0,
                  height: 30.0,
                ),
                const SizedBox(
                    width: 12.0), // Increase spacing between icon and text
                Expanded(
                  child: Text(item['name'], overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),
          children: item['children']
              .map<Widget>((child) => buildList(
                  child, padding + 20.0)) // Increase padding for sub-items
              .toList(),
        ),
      );
    } else {
      return InkWell(
        hoverColor: Colors.transparent, // Remove hover effect
        onTap: () async {
          setState(() {
            _pdfPath = '';
            _showPdf = false;
          });


          print(_pdfPath);

          String fileUrl = item['url'];
          String fileName = fileUrl.split('/').last;

          // You can download the file here if it's not locally available
          Directory appDocDir = await getApplicationDocumentsDirectory();
          String filePath = "${appDocDir.path}/$fileName";

          setState(() {
            print('stated');
            _pdfPath = filePath;
            _showPdf = true;
            _pdfName = item['name'];
            isFileshow = true;
          });
          print(_pdfPath);
        },
        child: Container(
          padding: EdgeInsets.only(
              left: padding + 10.0,
              top: 10.0,
              bottom: 10.0), // Add more padding for documents
          child: Row(
            children: [
              Image.asset(
                pdficon,
                width: 30.0,
                height: 30.0,
              ),
              const SizedBox(
                  width: 12.0), // Increase spacing between icon and text
              Expanded(
                child: Text(item['name'], overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
        ),
      );
    }
  }
}

class GradientProgressBar extends StatelessWidget {
  final double progress;
  final double width;
  final double height;

  GradientProgressBar({
    required this.progress,
    this.width = 500,
    this.height = 20.0,
  }) : assert(
            progress >= 0 && progress <= 1, 'Progress must be between 0 and 1');

  @override
  Widget build(BuildContext context) {
    final double validWidth = width.isFinite && width > 0 ? width : 100.0;

    return Container(
      width: 500,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[300], // Background color
      ),
      child: Stack(
        children: [
          Container(
            width: validWidth * progress, // Fill based on progress
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                colors: [
                  Colors.lightGreen, // Start color
                  Colors.green, // End color
                ],
                stops: [
                  0.0, // Position of start color
                  1.0, // Position of end color
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          Center(
            child: Text(
              "${(progress * 100).toStringAsFixed(1)}%",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

class FileDownloadManager {
  final Dio dio = Dio();

  Future<void> downloadFile(
    String url,
    String fileName,
    BuildContext context,
    void Function(double) onProgress,
  ) async {
    try {
      // Get the directory to save the file
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String savePath = "${appDocDir.path}/$fileName";

      // Check if the file already exists
      File file = File(savePath);
      if (await file.exists()) {
        print("File already exists at: $savePath");
        return;
      }

      await dio.download(
        url,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            // Show download progress as a percentage
            double progress = (received / total * 100);
            print("Progress: $progress%");

            // Invoke the callback to update UI
            onProgress(progress);
          }
        },
      );

      print("File downloaded and saved at: $savePath");
    } catch (e) {
      if (e.toString().contains('Connection refused')) {
        EasyLoading.showToast('You are in offline mode!\nPlease check your network connection.');
      } else {
        EasyLoading.showToast('Something went wrong!\nPlease check again later.');
      }
      print("$e");
    }
  }
}







// void getFilesbyGroup() async {
//   print("${AppUrls.documents}?group=$selectedGroupId_id");
//
//   try {
//     var response = await http.Client().get(
//       Uri.parse("${AppUrls.documents}?group=$selectedGroupId_id"),
//       headers: {
//         "Content-Type": "application/json",
//         "Accept": "application/json",
//         "Authorization": "Bearer $userToken"
//       },
//     );
//
//     if (response.statusCode == 200) {
//       final responseData = json.decode(response.body);
//       print(responseData);
//
//       List<dynamic> fetchedData = responseData['data'];
//
//       void extractDocuments(List<dynamic> data) {
//         data.forEach((element) async {
//           if (element['type'] == 'document') {
//             totalFiles++;
//
//             final String fileUrl = element['url'];
//             final String fileName = fileUrl.split('/').last;
//
//             FileDownloadManager downloadManager = FileDownloadManager();
//             await downloadManager.downloadFile(
//               fileUrl,
//               fileName,
//               context,
//               (progress) {
//                 setState(() {
//                   _downloadProgress = progress;
//                 });
//               },
//             );
//
//             setState(() {
//               downloadedFilesCount++;
//               _downloadedpdfName = element['name'];
//               _downloadProgress = downloadedFilesCount / totalFiles;
//             });
//           } else if (element['type'] == 'folder' &&
//               element['children'] != null) {
//             extractDocuments(element['children']);
//           }
//         });
//       }
//
//       setState(() {
//         fetchedData.forEach((element) {
//           data.add({
//             "name": element['name'],
//             "type": element['type'],
//             "id": element['id'],
//             "children": element['children']
//           });
//         });
//       });
//
//       // print("Data saved: $data");
//       // setState(() {
//       //   datafromDevice = data;
//       // });
//
//       List<Map<String, dynamic>> appsWithPaths = [];
//       for (var element in responseData['data']) {
//         appsWithPaths.add({
//           "name": element['name'],
//           "type": element['type'],
//           "id": element['id'],
//           "children": element['children']
//         });
//       }
//       String appsList = jsonEncode(appsWithPaths);
//       await AppSp().setPdfdocuments(appsList);
//       setState(() {
//         datafromDevice = data;
//       });
//
//       extractDocuments(fetchedData);
//     } else {
//       EasyLoading.showError("Failed to datas");
//     }
//   } catch (e) {
//     print("$e");
//     // EasyLoading.showError("Errorxxxxxxx in API $e");
//   }
// }







//
// Error: FileSystemException: writeFrom failed, path = '/Users/macair/Library/Developer/CoreSimulator/Devices/B91C7C9C-412C-4D04-835E-D73BF62A0C48/data/Containers/Data/Application/1898B254-23A3-4DF6-A7CA-F5D05D32DA73/Documents/21nnvfUEPODc.pdf' (OS Error: No space left on device, errno = 28)
//

// Widget buildList(Map<String, dynamic> item, [double padding = 0.0]) {
//   if (item['type'] == 'folder') {
//     return InkWell(
//       hoverColor: Colors.grey[300], // Background color when hovered
//       child: ExpansionTile(
//         collapsedShape: RoundedRectangleBorder(
//           side: BorderSide.none,
//         ),
//         shape: RoundedRectangleBorder(
//           side: BorderSide.none,
//         ),
//         tilePadding:
//             EdgeInsets.only(left: padding + 10.0), // Add padding for folder
//         title: Text(item['name']),
//         leading: Image.asset(
//           foldericon,
//           width: 30.0,
//           height: 30.0,
//         ),
//         children: item['children']
//             .map<Widget>((child) => buildList(
//                 child, padding + 20.0)) // Increase padding for child items
//             .toList(),
//       ),
//     );
//   } else if (item['type'] == 'document' && item.containsKey('children')) {
//     return InkWell(
//       hoverColor: Colors.grey[300], // Background color when hovered
//       child: ExpansionTile(
//         collapsedShape: RoundedRectangleBorder(
//           side: BorderSide.none,
//         ),
//         shape: RoundedRectangleBorder(
//           side: BorderSide.none,
//         ),
//         tilePadding: EdgeInsets.only(
//             left: padding + 10.0), // Add padding for document with children
//         trailing: const SizedBox.shrink(), // No trailing icon
//         leading: const Icon(
//             Icons.keyboard_arrow_right_outlined), // Icon for document
//         title: Container(
//           padding: EdgeInsets.only(
//               left: 20.0,
//               top: 20,
//               bottom: 20), // Adjust inner padding for document
//           child: Row(
//             children: [
//               Image.asset(
//                 pdficon,
//                 width: 30.0,
//                 height: 30.0,
//               ),
//               const SizedBox(
//                   width: 12.0), // Increase spacing between icon and text
//               Expanded(
//                 child: Text(item['name'], overflow: TextOverflow.ellipsis),
//               ),
//             ],
//           ),
//         ),
//         children: item['children']
//             .map<Widget>((child) => buildList(
//                 child, padding + 20.0)) // Increase padding for sub-items
//             .toList(),
//       ),
//     );
//   } else {
//     return InkWell(
//       hoverColor: Colors.grey[300], // Background color when hovered
//       child: Container(
//         padding: EdgeInsets.only(
//             left: padding + 10.0,
//             top: 10.0,
//             bottom: 10.0), // Add more padding for documents
//         child: Row(
//           children: [
//             Image.asset(
//               pdficon,
//               width: 30.0,
//               height: 30.0,
//             ),
//             const SizedBox(
//                 width: 12.0), // Increase spacing between icon and text
//             Expanded(
//               child: Text(item['name'], overflow: TextOverflow.ellipsis),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:iconly/iconly.dart';
//
// import '../../../utils/app_color.dart';
// import '../../../utils/app_constant.dart';
// import '../../../utils/app_font.dart';
//
// enum _SelectedTab { home, folder, person }
//
// class FileManager extends StatefulWidget {
//   const FileManager({Key? key}) : super(key: key);
//
//   @override
//   State<FileManager> createState() => _FileManagerState();
// }
//
// class _FileManagerState extends State<FileManager> {
//   var _selectedTab = _SelectedTab.folder;
//
//   void _handleIndexChanged(int i) {
//     setState(() {
//       _selectedTab = _SelectedTab.values[i];
//       if (_selectedTab == _SelectedTab.person) {
//         Navigator.pushNamed(
//           context,
//           "/profile",
//         );
//       } else if (_selectedTab == _SelectedTab.home) {
//         Navigator.pushNamed(
//           context,
//           "/home",
//         );
//       } else if (_selectedTab == _SelectedTab.folder) {
//         Navigator.pushNamed(
//           context,
//           "/file_manager",
//         );
//       }
//     });
//   }
//
//   final List<Map<String, dynamic>> fileData = [
//     {
//       "id": 1,
//       "pdf_name": "Flight Managment",
//       "pdf_file": "/media/pdf/flight_and_airport_management_names.pdf",
//       "created_at": "2024-08-15 11:00:51",
//       "status": "1",
//       "group": {"id": 13, "name": "SubGroup A1"},
//       "group_path": [
//         {"id": 10, "name": "Group A"},
//         {"id": 13, "name": "SubGroup A1"}
//       ],
//       "category": {"id": 40, "name": "Chapter 1 Maths"},
//       "category_path": [
//         {"id": 31, "name": "OPS Document"},
//         {"id": 33, "name": "Delay Doc"},
//         {"id": 36, "name": "Section 1"},
//         // {"id": 40, "name": "Chapter 1 Maths"}
//       ]
//     },
//     {
//       "id": 6,
//       "pdf_name": "Helicopter Management",
//       "pdf_file": "/media/pdf/Text-Weather_report.pdf",
//       "created_at": "2024-08-20 04:38:54",
//       "status": "1",
//       "group": {"id": 13, "name": "SubGroup A1"},
//       "group_path": [
//         {"id": 10, "name": "Group A"},
//         {"id": 13, "name": "SubGroup A1"}
//       ],
//       "category": {"id": 39, "name": "COMPUTER ELEMENT"},
//       "category_path": [
//         {"id": 32, "name": "Aircraft Document"},
//         {"id": 35, "name": "AS-G10 AirCraft"},
//         {"id": 39, "name": "AirCraft Path"}
//       ]
//     },
//     {
//       "id": 8,
//       "pdf_name": "Crew Management",
//       "pdf_file": "/media/pdf/API_Service_Documentation_aZwzf9b.pdf",
//       "created_at": "2024-08-23 08:44:49",
//       "status": "1",
//       "group": {"id": 13, "name": "SubGroup A1"},
//       "group_path": [
//         {"id": 10, "name": "Group A"},
//         {"id": 13, "name": "SubGroup A1"}
//       ],
//       "category": {"id": 36, "name": "Maths 10A"},
//       "category_path": [
//         {"id": 31, "name": "General Documents"},
//         {"id": 33, "name": "Aviation Reports"},
//         {"id": 36, "name": "DRB Document"}
//       ]
//     },
//     {
//       "id": 9,
//       "pdf_name": "Maths File",
//       "pdf_file": "/media/pdf/Main-Weather_report_2ASFnyu.pdf",
//       "created_at": "2024-08-23 08:45:54",
//       "status": "1",
//       "group": {"id": 13, "name": "SubGroup A1"},
//       "group_path": [
//         {"id": 10, "name": "Group A"},
//         {"id": 13, "name": "SubGroup A1"}
//       ],
//       "category": {"id": 36, "name": "Maths 10A"},
//       "category_path": [
//         {"id": 32, "name": "Aircraft Document"},
//         {"id": 35, "name": "AS-G10 AirCraft"},
//         {"id": 39, "name": "AirCraft Path"}
//       ]
//     }
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFF8F9FB),
//       extendBody: true,
//       body: Stack(
//         children: [
//           Image.asset(
//             WhiteBackground,
//             fit: BoxFit.cover,
//             width: double.infinity,
//             height: double.infinity,
//           ),
//           Center(
//             child: ConstrainedBox(
//               constraints: BoxConstraints(maxWidth: 1200.0),
//               child: Column(
//                 children: [
//                   SizedBox(height: 20.0),
//                   Container(
//                     padding: EdgeInsets.all(35.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         // Logo
//                         Image.asset(
//                           RedBlackLogo,
//                           height: 90.0,
//                         ),
//                         Row(
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: [
//                                 Text(
//                                   'Capt. Alpha',
//                                   style: TextStyle(
//                                     fontSize: 22,
//                                     fontFamily: AppFont.OutfitFont,
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                                 Text(
//                                   'A6-FHD',
//                                   style: TextStyle(
//                                     color: Color(0xFF969492),
//                                     fontSize: 14,
//                                     fontFamily: AppFont.OutfitFont,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(width: 10.0),
//                             CircleAvatar(
//                               backgroundImage: AssetImage(dummyProfile),
//                               radius: 30.0,
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 10.0),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 40.0),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           flex: 4, // 40% of the screen
//                           child: Container(
//                             padding: EdgeInsets.all(5.0),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(25),
//                             ),
//                             child: ListView(
//                               shrinkWrap: true,
//                               children: _buildExpansionTiles(fileData, 0),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                             width: MediaQuery.of(context).size.width * 0.04),
//                         Expanded(
//                           flex: 6, // 50% of the screen
//                           child: Container(
//                             color: Colors.grey[200],
//                             child: Center(
//                               child: Text('Document Viewer',
//                                   style: TextStyle(fontSize: 24)),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: Padding(
//         padding: EdgeInsets.only(
//           bottom: 5,
//           right: MediaQuery.of(context).size.width * 0.18, // 10% of screen width
//           left: MediaQuery.of(context).size.width * 0.18, // 10% of screen width
//         ),
//         child: CrystalNavigationBar(
//           currentIndex: _SelectedTab.values.indexOf(_selectedTab),
//           indicatorColor: AppColor.primaryColor,
//           borderRadius: 10,
//           paddingR: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//           itemPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//           height: 110,
//           unselectedItemColor: Colors.white70,
//           backgroundColor: AppColor.primaryColor,
//           splashBorderRadius: 10,
//           outlineBorderColor: Colors.black.withOpacity(0.1),
//           onTap: _handleIndexChanged,
//           enableFloatingNavBar: true,
//           enablePaddingAnimation: true,
//
//           items: [
//             CrystalNavigationBarItem(
//               icon: IconlyBold.home,
//               unselectedIcon: IconlyLight.home,
//               selectedColor: Colors.white,
//
//             ),
//
//             CrystalNavigationBarItem(
//               icon: IconlyBold.folder,
//               unselectedIcon: IconlyLight.folder,
//               selectedColor: Colors.white,
//             ),
//
//             CrystalNavigationBarItem(
//               icon: IconlyBold.user_3,
//               unselectedIcon: IconlyLight.user_1,
//               selectedColor: Colors.white,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   List<Widget> _buildExpansionTiles(
//       List<Map<String, dynamic>> fileData, int level) {
//     final Map<String, Map<String, dynamic>> pathMap = {};
//     final Set<String> displayedPaths = {};
//
//     // Organize files by category path
//     for (var file in fileData) {
//       final List<Map<String, dynamic>> categoryPath =
//       List<Map<String, dynamic>>.from(file['category_path']);
//       final String pdfName = file['pdf_name'];
//       final String pdfFile = file['pdf_file'];
//
//       String pathKey = categoryPath.map((e) => e['name']).join('/');
//       if (!pathMap.containsKey(pathKey)) {
//         pathMap[pathKey] = {'path': categoryPath, 'files': []};
//       }
//       pathMap[pathKey]!['files']
//           .add({'pdf_name': pdfName, 'pdf_file': pdfFile});
//     }
//
//     // Generate the ExpansionTiles
//     return pathMap.entries.map((entry) {
//       final categoryPath = List<Map<String, dynamic>>.from(entry.value['path']);
//       final files = List<Map<String, dynamic>>.from(entry.value['files']);
//
//       return _buildPathExpansionTile(categoryPath, files, level, displayedPaths);
//     }).toList();
//   }
//
//   Widget _buildPathExpansionTile(
//       List<Map<String, dynamic>> path,
//       List<Map<String, dynamic>> files,
//       int level,
//       Set<String> displayedPaths) {
//     if (path.isEmpty) {
//       return SizedBox.shrink();
//     }
//
//     final current = path.first;
//     final remainingPath = path.sublist(1);
//
//     final currentPathKey = path.map((e) => e['name']).join('/');
//
//     if (displayedPaths.contains(currentPathKey)) {
//       return SizedBox.shrink();
//     }
//
//     displayedPaths.add(currentPathKey);
//
//     return ExpansionTile(
//       collapsedShape: RoundedRectangleBorder(
//         side: BorderSide.none,
//       ),
//       shape: RoundedRectangleBorder(
//         side: BorderSide.none,
//       ),
//       leading: Padding(
//         padding: EdgeInsets.only(left: 20.0 * (level + 1)),
//         child: Image.asset(
//           foldericon,
//           width: 30.0,
//           height: 30.0,
//         ),
//       ),
//       title: Padding(
//         padding: EdgeInsets.only(left: 10.0),
//         child: Text(
//           current['name'],
//           style: TextStyle(
//             fontSize: MediaQuery.of(context).size.width * 0.020,
//             fontFamily: AppFont.OutfitFont,
//             color: Colors.black,
//             fontWeight: FontWeight.w500,
//           ),
//           maxLines: 1,
//           overflow: TextOverflow.ellipsis,
//         ),
//       ),
//       children: [
//         if (remainingPath.isEmpty && files.isNotEmpty)
//           ...files.map((file) {
//             return ListTile(
//               contentPadding: EdgeInsets.only(left: 22.0),
//               leading: Padding(
//                 padding: EdgeInsets.only(left: 22.0 * (level + 1)),
//                 child: Image.asset(
//                   pdficon,
//                   width: 30.0,
//                   height: 30.0,
//                 ),
//               ),
//               title: Text(
//                 file['pdf_name'],
//                 style: TextStyle(
//                   fontSize: MediaQuery.of(context).size.width * 0.019,
//                   fontFamily: AppFont.OutfitFont,
//                   color: Colors.black,
//                   fontWeight: FontWeight.w500,
//                 ),
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//               ),
//               dense: true,
//               tileColor: Colors.transparent,
//               onTap: () {
//                 // Handle file tap
//                 print('Opening ${file['pdf_file']}');
//               },
//             );
//           }).toList()
//         else
//           _buildPathExpansionTile(remainingPath, files, level + 1, displayedPaths),
//       ],
//     );
//   }
//
// }
//
