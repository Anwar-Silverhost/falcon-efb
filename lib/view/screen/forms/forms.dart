import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:iconly/iconly.dart';
import 'package:http/http.dart' as http;
import '../../../utils/app_color.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/app_font.dart';
import '../../../utils/app_sp.dart';
import '../../../utils/app_urls.dart';
import '../profile/profile_screen.dart';

enum _SelectedTab { home, folder, document, person }

class Forms extends StatefulWidget {
  const Forms({super.key});
  @override
  State<Forms> createState() => _FormsState();
}

class _FormsState extends State<Forms> {
  var _selectedTab = _SelectedTab.document;
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
      } else if (_selectedTab == _SelectedTab.document) {
        Navigator.pushNamed(
          context,
          "/forms",
        );
      }
    });
  }

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


  var profile = dummyProfile;

  bool isSigned = false;
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
        EasyLoading.dismiss();

        final responseData = json.decode(response.body);
        print(responseData);


        setState(() {
          _signForm = responseData['data']['file'];
          if ((responseData['data']['file']) == 'yes'){

            print('its an yes');
            if ((responseData['data']['isSigned']) == false ){
              isSigned = false;
              print('object');
            }else{
              isSigned = true;
            }
          }
        });
        EasyLoading.showToast( responseData['message']);
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
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          children: [


                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  "/rotarywingflightplanenvelope",
                                );
                              },
                              child: Card(
                                color: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: ListTile(
                                    leading: Image.asset(
                                      fileicon,
                                      width: 80,
                                      height: 80,
                                    ),
                                    title: Text("ROTARY WING FLIGHT PLAN ENVELOPE".toUpperCase(),
                                      style: TextStyle(
                                        fontFamily: AppFont.OutfitFont,
                                        fontSize: MediaQuery.of(context)
                                            .size
                                            .width *
                                            0.028,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    trailing: Icon(Icons.arrow_forward_ios),
                                  ),
                                ),
                              ),
                            ),


                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  "/aircraftsearchchecklist",
                                );
                              },
                              child: Card(
                                color: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: ListTile(
                                    leading: Image.asset(
                                      fileicon,
                                      width: 80,
                                      height: 80,
                                    ),
                                    title: Text('Aircraft Search Checklist'.toUpperCase(),
                                      style: TextStyle(
                                        fontFamily: AppFont.OutfitFont,
                                        fontSize: MediaQuery.of(context)
                                            .size
                                            .width *
                                            0.028,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    trailing: Icon(Icons.arrow_forward_ios),
                                  ),
                                ),
                              ),
                            ),


                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  "/rotarywingjourneylog",
                                );
                              },
                              child: Card(
                                color: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: ListTile(
                                    leading: Image.asset(
                                      fileicon,
                                      width: 80,
                                      height: 80,
                                    ),
                                    title: Text('Rotary Wing Journey Log'.toUpperCase(),
                                      style: TextStyle(
                                        fontFamily: AppFont.OutfitFont,
                                        fontSize: MediaQuery.of(context)
                                            .size
                                            .width *
                                            0.028,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    trailing: Icon(Icons.arrow_forward_ios),
                                  ),
                                ),
                              ),
                            ),

                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  "/operationalflightplan",
                                );
                              },
                              child: Card(
                                color: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: ListTile(
                                    leading: Image.asset(
                                      fileicon,
                                      width: 80,
                                      height: 80,
                                    ),
                                    title: Text('Operational Flight Plan (OFP)'.toUpperCase(),
                                      style: TextStyle(
                                        fontFamily: AppFont.OutfitFont,
                                        fontSize: MediaQuery.of(context)
                                            .size
                                            .width *
                                            0.028,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    trailing: Icon(Icons.arrow_forward_ios),
                                  ),
                                ),
                              ),
                            ),


                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  "/commercialflightrecord",
                                );
                              },
                              child: Card(
                                color: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: ListTile(
                                    leading: Image.asset(
                                      fileicon,
                                      width: 80,
                                      height: 80,
                                    ),
                                    title: Text('Commercial Flight Record (CFR)'.toUpperCase(),
                                      style: TextStyle(
                                        fontFamily: AppFont.OutfitFont,
                                        fontSize: MediaQuery.of(context)
                                            .size
                                            .width *
                                            0.028,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    trailing: Icon(Icons.arrow_forward_ios),
                                  ),
                                ),
                              ),
                            ),




                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  "/discretionreport",
                                );
                              },
                              child: Card(
                                color: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: ListTile(
                                    leading: Image.asset(
                                      fileicon,
                                      width: 80,
                                      height: 80,
                                    ),
                                    title: Text("COMMANDER'S DISCRETION REPORT - RW".toUpperCase(),
                                      style: TextStyle(
                                        fontFamily: AppFont.OutfitFont,
                                        fontSize: MediaQuery.of(context)
                                            .size
                                            .width *
                                            0.028,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    trailing: Icon(Icons.arrow_forward_ios),
                                  ),
                                ),
                              ),
                            ),









                          if (_signForm == 'yes') ...[



                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, "/signaturefile");
                              },
                              child: Card(
                                color: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: ListTile(
                                    leading: Image.asset(
                                      fileicon,
                                      width: 80,
                                      height: 80,
                                    ),
                                    title: Text(
                                      "Loading & Trim".toUpperCase(),
                                      style: TextStyle(
                                        fontFamily: AppFont.OutfitFont,
                                        fontSize: MediaQuery.of(context).size.width * 0.028,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                          decoration: BoxDecoration(
                                            color: isSigned ? Colors.green : Colors.red, // Conditional color
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Text(
                                            isSigned ? "Signed" : "Not Signed", // Conditional text
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        const Icon(Icons.arrow_forward_ios),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),



],









                            SizedBox(height: 100),
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
}
