import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/app_constant.dart';
import '../../../../utils/app_font.dart';
import '../../../../utils/app_sp.dart';
import '../../../../utils/app_urls.dart';
import '../../profile/profile_screen.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class SignatureFile extends StatefulWidget {
  const SignatureFile({super.key});

  @override
  State<SignatureFile> createState() => _SignatureFileState();
}

class _SignatureFileState extends State<SignatureFile> {
  late PDFViewController _pdfViewController;
  String userToken = '';
  String fullName = '';
  String selectedGroupName = '';
  List<dynamic> apps = [];
  String profilePic = '';
  String UserID = '';
  String selectedGroupId_id = '';

  String selectMaingroup = '';

  String selectMaingroupId = '';

  String _signForm = '';

  String _signFormUrl = '';
  String _signFormName = '';
  String _signFormId = '';



  var profile = dummyProfile;

  bool isChecked = false;
  var currentDate = "${DateTime.now().day.toString().padLeft(2, '0')}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().year}";

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
    selectMaingroup = await appSp.getSelected_Maingroup();
    selectMaingroupId = await appSp.getSelected_MaingroupID();
    await signformdata_pass_backend(UserID, userToken);
    setState(() {
      selectedGroupId_id = selectedGroupId_id;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }








  Future<void> signformdata_pass_backend(String userID, String userToken) async {
    print( "${AppUrls.signform}&userid=$userID&date=$currentDate&aircrafttype=$selectMaingroupId&aircraftreg=$selectedGroupId_id");

    EasyLoading.show();
    try {
      var response = await http.Client().get(
        Uri.parse(
            "${AppUrls.signform}?userid=$userID&date=$currentDate&aircrafttype=$selectMaingroupId&aircraftreg=$selectedGroupId_id"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $userToken"
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print(responseData);

        if ((responseData['data']['isSigned']) == false ){
          setState(() {
            _signFormUrl = responseData['data']['file_url'];
            _signFormName = responseData['data']['file_name'];
            _signFormId = responseData['data']['file_id'];
          });
        }
        else{
          setState(() {
            _signForm = 'yes';
            _signFormUrl = responseData['data']['file_url'];
            _signFormName = responseData['data']['file_name'];
            _signFormId = responseData['data']['file_id'];
          });
        }

        await downloadAndDisplayPDF(_signFormUrl);
        EasyLoading.dismiss();
      } else {
        EasyLoading.dismiss();
        final responseData = json.decode(response.body);

        EasyLoading.showToast( responseData['message']);
      }
    } catch (e) {
      EasyLoading.dismiss();
      log("Error in API $e");
      EasyLoading.showToast("$e");
    }
  }




  Future<void> downloadAndDisplayPDF(String url) async {
    try {
      final pdfPath = await downloadAndSavePdf(url, "signature_form.pdf");
      setState(() {
        _signFormUrl = pdfPath;
      });
    } catch (e) {
      EasyLoading.showToast("Failed to load PDF: $e");
    }
  }

  Future<String> downloadAndSavePdf(String url, String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = "${directory.path}/$fileName";
    final response = await http.get(Uri.parse(url));
    final file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
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
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Card(
                                    color: AppColor.primaryColor,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                context,
                                                "/forms",
                                              );
                                            },
                                            child: const Icon(
                                              Icons.arrow_back,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            _signFormName
                                                .toUpperCase(),
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),


                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),

                            SizedBox(height: 15),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.65,
                              child: _signFormUrl.isNotEmpty
                                  ? PDFView(
                                key: ValueKey(_signFormUrl),
                                filePath: _signFormUrl,
                                enableSwipe: true,
                                swipeHorizontal: false,
                                autoSpacing: true,
                                pageFling: true,
                                onViewCreated: (PDFViewController controller) {
                                  _pdfViewController = controller;
                                },
                              )
                                  : const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),

                            SizedBox(height: 15),

                      if (_signForm != 'yes') ...[
                            Row(
                              children: [
                                Expanded(
                                  child: Card(
                                    color: Colors.white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: const BorderSide(
                                        color: AppColor.primaryColor, // Red border
                                        width: 2,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Checkbox(
                                                value: isChecked,
                                                activeColor:
                                                AppColor.primaryColor,
                                                checkColor: Colors.white,
                                                shape:
                                                RoundedRectangleBorder(
                                                  side: BorderSide(
                                                    color: Colors.grey,
                                                    width: 5.0,
                                                  ),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      4.0),
                                                ),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    isChecked =
                                                        value ?? false;
                                                  });
                                                },
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                'Sign And Accept Terms',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              if (!isChecked) {
                                                EasyLoading.showInfo('Please Sign in to continue');
                                              } else {
                                                saveSignformdata();
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: AppColor.primaryColor,
                                              foregroundColor: Colors.white,
                                              shape:
                                              RoundedRectangleBorder(
                                                side: BorderSide(
                                                  width: 0,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(
                                                    5.0),
                                              ),
                                            ),
                                            child: const Text('Save'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )

],

                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> saveSignformdata() async {
    print(  "${AppUrls.signform}?userid=$UserID&signFormId=$_signFormId");

    EasyLoading.show();
    try {
      var response = await http.Client().post(
        Uri.parse(
            "${AppUrls.signform}?userid=$UserID&signFormId=$_signFormId"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $userToken"
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        EasyLoading.dismiss();
        print(responseData);
        setState(() {
          _signFormUrl = responseData['data']['signed_pdf_url'];
          _signForm = 'yes' ;

          // _signFormName = responseData['data']['file_name'];
          //{status: success, message: Form signed successfully., data: {isSigned: true, signed_pdf_url: http://192.168.1.41:8000/media/signed/signed_18clCv0MF0.pdf}}
        });
        await downloadAndDisplayPDF(_signFormUrl);
        // await downloadAndDisplayPDF(_signFormUrl);


        EasyLoading.showToast('Signed Successfully');
      } else {
        EasyLoading.dismiss();
        final responseData = json.decode(response.body);

        EasyLoading.showToast( responseData['message']);
      }
    } catch (e) {
      EasyLoading.dismiss();
      log("Error in API $e");
      EasyLoading.showToast("$e");
    }
  }

}
