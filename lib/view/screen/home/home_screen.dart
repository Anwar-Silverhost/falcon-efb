import 'dart:convert';
import 'dart:io';
import 'package:device_apps/device_apps.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:falcon_aviation/utils/app_color.dart';
import 'package:falcon_aviation/view/screen/file_manager/file_manager.dart';
import 'package:falcon_aviation/view/screen/forms/forms.dart';
import 'package:falcon_aviation/view/screen/profile/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/app_font.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:iconly/iconly.dart';
import 'package:http/http.dart' as http;
import '../../../utils/app_functions.dart';
import '../../../utils/app_sp.dart';
import '../../../utils/app_urls.dart';
import '../file_manager/view_pdf.dart';

enum _SelectedTab { home, folder, document, person }

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _selectedTab = _SelectedTab.home;
  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
      if (_selectedTab == _SelectedTab.person) {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => ProfileScreen(),
          ),
        );
      } else if (_selectedTab == _SelectedTab.folder) {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => FileManager(),
          ),
        );
      }
      else if (_selectedTab == _SelectedTab.document) {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => Forms(),
          ),
        );
      }
    });
  }

  Map<String, dynamic> userDetails = {};
  String userToken = '';
  String fullName = '';
  String selectedGroupName = '';
  List<dynamic> apps = [];
  String profilePic = '';
  String UserID = '';

  var profile = dummyProfile;

  List<dynamic> items = [];

  @override
  void initState() {
    super.initState();
    getUserToken();
  }

  Future<void> getUserToken() async {
    AppSp appSp = AppSp();
    userDetails = await appSp.getUserDetails();
    userToken = await appSp.getToken();
    fullName = await appSp.getFullname();
    selectedGroupName = await appSp.getSelectedgroup();
    UserID = await appSp.getUserID();
    profile = await appSp.getUserprofilepic();
    items = await appSp.getFavourites();

    // print(items);

    var appsList = await appSp.getAppslist();

    if (appsList.isNotEmpty) {
      try {
        fetchApps();
      } catch (e) {
        setState(() {
          apps = appsList;
        });
      }
    } else {
      fetchApps();
    }

    setState(() {
      apps = appsList;
      function_FetchUserDetails(UserID, userToken);
      items = items;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void fetchApps() async {
    try {
      var response = await http.Client().get(
        Uri.parse(AppUrls.apps),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $userToken"
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        List<Map<String, dynamic>> appsWithPaths = [];

        for (var app in responseData['data']) {
          String localIconPath =
              await downloadAppIcon(app['app_icon'], app['app_name']);
          appsWithPaths.add({
            'app_name': app['app_name'],
            'app_url': app['app_url'],
            'app_icon': app['app_icon'],
            'color': app['color'],
            'created_at': app['created_at'],
            'status': app['status'],
            'app_asset_icon': localIconPath
          });
        }
        String appsList = jsonEncode(appsWithPaths);
        await AppSp().setAppslist(appsList);
        setState(() {
          apps = appsWithPaths;
        });

        // EasyLoading.showSuccess("Apps loaded successfully");
      } else {
        EasyLoading.showError("Failed to load apps");
      }
    } catch (e) {
      print("$e");
      // EasyLoading.showError("Errorxxxxxxx in API $e");
    }
  }

  Future<String> downloadAppIcon(String iconUrl, String appName) async {
    try {
      var response = await http.get(Uri.parse(iconUrl));

      if (response.statusCode == 200) {
        final directory = await getApplicationDocumentsDirectory();
        String path = '${directory.path}/app_icons';

        // Replace spaces with underscores in the appName
        String formattedAppName = appName.replaceAll(' ', '_');

        final dir = Directory(path);
        if (!await dir.exists()) {
          await dir.create(recursive: true);
        }

        File file = File('$path/${formattedAppName}_icon.png');
        await file.writeAsBytes(response.bodyBytes);

        return file.path;
      } else {
        print('Failed to download icon');
        return '';
      }
    } catch (e) {
      print('Error downloading icon: $e');
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              'Are you sure...?',
            ),
            content: const Text(
              'Do you want to exit from the App',
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                  SystemNavigator.pop();
                  Future.delayed(const Duration(milliseconds: 1000), () {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  });
                },
                child: const Text(
                  "YES",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text(
                  "NO",
                  style: TextStyle(
                    color: Color(0xFF301C93),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      child: Scaffold(
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
                constraints: const BoxConstraints(maxWidth: 1200.0),
                child: Column(
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
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
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
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 10.0),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0.0),
                              child: Wrap(
                                spacing: 25.0,
                                runSpacing: 25.0,
                                children: [
                                  for (var app in apps)
                                    SizedBox(
                                      width:
                                          (MediaQuery.of(context).size.width -
                                                  30) /
                                              4,
                                      child: appCard(
                                        label: app['app_name'] as String,
                                        color: Color(int.parse(
                                                app['color'].substring(1, 7),
                                                radix: 16) +
                                            0xFF000000),
                                        iconAsset: app['app_asset_icon'],
                                        redirectUrl: app['app_url'],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30.0),
                            const Divider(
                              height: 20,
                              thickness: 0.3,
                              indent: 35,
                              endIndent: 35,
                              color: Colors.black,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40.0, vertical: 0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'favorites',
                                        style: TextStyle(
                                          fontFamily: AppFont.OutfitFont,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.028,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                              builder: (context) =>
                                                  FileManager(),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          'View all',
                                          style: TextStyle(
                                              fontFamily: AppFont.OutfitFont,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.024,
                                              fontWeight: FontWeight.w500,
                                              color: AppColor.primaryColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.width *
                                        0.45,
                                    child: GridView.builder(
                                      padding: const EdgeInsets.all(0),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        childAspectRatio:
                                            3, // Adjust this ratio for card aspect ratio
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                      ),
                                      itemCount: items.length,
                                      itemBuilder: (context, index) {
                                        final item = items[index];
                                        return InkWell(
                                          hoverColor: Colors.transparent,
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              CupertinoPageRoute(
                                                builder: (context) => ViewPdf(
                                                    pdfPath: item["url"],
                                                    pdfName: item["title"]),
                                              ),
                                            );
                                          },
                                          child: Card(
                                            elevation: 0.15,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            color: Colors
                                                .white, // Background color
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: Row(
                                                children: [
                                                  item["type"] == "file"
                                                      ? Image.asset(
                                                          pdficon,
                                                          width: 35.0,
                                                          height: 35.0,
                                                        )
                                                      : Image.asset(
                                                          foldericon,
                                                          width: 35.0,
                                                          height: 35.0,
                                                        ),
                                                  SizedBox(width: 10),
                                                  Expanded(
                                                    child: Text(
                                                      item["title"]!,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.024,
                                                        fontFamily:
                                                            AppFont.OutfitFont,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        color: Colors
                                                            .black, // Text color
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
            left:
                MediaQuery.of(context).size.width * 0.18, // 10% of screen width
          ),
          child: CrystalNavigationBar(
            currentIndex: _SelectedTab.values.indexOf(_selectedTab),
            indicatorColor: AppColor.primaryColor,
            borderRadius: 10,
            paddingR: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            itemPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
      ),
    );
  }

  Widget appCard({
    required String label,
    required Color color,
    required String iconAsset,
    required String redirectUrl,
  }) {
    return GestureDetector(
      onTap: () => _openApp(redirectUrl),
      child: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              iconAsset,
              height: 90.0,
            ),
            const SizedBox(height: 30.0),
            Text(
              label,
              style: TextStyle(
                fontFamily: AppFont.OutfitFont,
                fontSize: MediaQuery.of(context).size.width * 0.018,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openApp(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      print('Could not launch $url');
    }
  }
}
