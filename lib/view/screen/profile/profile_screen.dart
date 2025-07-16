import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:falcon_aviation/view/screen/login/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:iconly/iconly.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/app_font.dart';
import '../../../utils/app_functions.dart';
import '../../../utils/app_sp.dart';
import '../../../utils/app_urls.dart';


enum _SelectedTab { home, folder, document, person }

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  var _selectedTab = _SelectedTab.person;

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

  final TextEditingController _currentpassword = TextEditingController();
  final TextEditingController _newpassword = TextEditingController();
  final TextEditingController _confirmpassword = TextEditingController();

  bool _isPasswordVisible = false;
  Map<String, dynamic> userDetails = {};
  String userToken = '';
  String fullName = '';
  String selectedGroupName = '';
  List<dynamic> apps = [];
  String profilePic = '';

  String UserID = '';

  var profile = dummyProfile;

  @override
  void initState() {
    super.initState();
    loadInitialUserDetails(); // Load old details first
    getUserToken();           // Then fetch new details
    print("-this is first $profile");
  }

  void loadInitialUserDetails() async {
    // Load the old user details before fetching the new ones
    AppSp appSp = AppSp();

    userDetails = await appSp.getUserDetails();
    fullName = await appSp.getFullname();
    selectedGroupName = await appSp.getSelectedgroup();
    var profilexx = await appSp.getUserprofilepic();

    setState(() {
      profile = profilexx; // Set old profile first
    });
  }

  Future<void> getUserToken() async {
    AppSp appSp = AppSp();

    userToken = await appSp.getToken();
    UserID = await appSp.getUserID();

    await profilefunction_FetchUserDetails(UserID, userToken);

    // Now fetch new user details
    userDetails = await appSp.getUserDetails();
    fullName = await appSp.getFullname();
    selectedGroupName = await appSp.getSelectedgroup();
    var profilexx = await appSp.getUserprofilepic();

    print("--this is the profile pic ------ | $profilexx");

    setState(() {
      profile = profilexx; // Update with new profile details
    });

    print("This is profile page: $userDetails");
  }

  Future<void> profilefunction_FetchUserDetails(String userID, String userToken) async {

    print("${AppUrls.userdetails}$userID/");
    try {
      var response = await http.Client().get(
        Uri.parse("${AppUrls.userdetails}$userID/"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $userToken"
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        AppSp().setUserDetails(jsonEncode(responseData['data']));

        AppSp().setFirstname(responseData['data']['firstname']);
        AppSp().setLastname(responseData['data']['lastname']);
        AppSp().setFullname( "${responseData['data']['firstname']} ${responseData['data']['lastname']}");
        AppSp().setUserID(responseData['data']['id']);

        String localIconPath = await downloadAppProfile( responseData['data']['profile_pic'], "${responseData['data']['firstname']}_${responseData['data']['lastname']}");

        AppSp().setUserprofilepic(localIconPath);
        setState(() {
          profile = localIconPath;
          print("New profile path: $profile");
        });

      } else {
        final responseData = json.decode(response.body);
        print(responseData['message']);
      }
    } catch (e) {
      log("Error in API $e");
    }
  }


  Future<String> downloadAppProfile(String iconUrl, String appName) async {
    try {
      var response = await http.get(Uri.parse(iconUrl));

      if (response.statusCode == 200) {
        final directory = await getApplicationDocumentsDirectory();
        String path = '${directory.path}/app_profiles';

        final dir = Directory(path);
        if (!await dir.exists()) {
          await dir.create(recursive: true);
        }

        File file = File('$path/${appName}_profilepic.png');
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    FileImage(File(profile)).evict();
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      // extendBody: true,
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 5.0),
                    Container(
                      padding: const EdgeInsets.only(left: 35,right: 35,top: 35),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Logo
                          Image.asset(
                            RedBlackLogo,
                            height: MediaQuery.of(context).size.width * 0.1,
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                key: ValueKey('${profile}_${DateTime.now().millisecondsSinceEpoch}'),
                                backgroundImage: FileImage(File(profile)),
                                radius: 40.0,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 25.0,
                        right: 25.0,
                        top: 10,
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                profileBack), // Replace with your image asset
                            fit: BoxFit.contain,
                          ),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(
                                16.0), // Adjust padding as needed
                            child: Text(
                              'PROFILE',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.025,
                                fontFamily: AppFont.OutfitFont,
                                letterSpacing:
                                    13.0, // Adjust letter spacing as needed
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: SizedBox(
                        width: double.infinity, // Use available width
                        height: 90.0, // Set a fixed height, adjust as needed
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            // Positioned Image
                            Positioned(
                              top: -115,
                              left: 20,

                              child: CircleAvatar(
                                key: ValueKey('${profile}_${DateTime.now().millisecondsSinceEpoch}'),
                                // backgroundImage: AssetImage(profile),
                                backgroundImage:  FileImage(File(profile)),
                                radius: MediaQuery.of(context).size.width *
                                    0.1, // 10% of screen width
                              ),
                            ),
                            // Main Row
                            Positioned(
                              top: -100,
                              left: MediaQuery.of(context).size.width * 0.25,
                              right: 0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 100),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Left side: Text
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            fullName,
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.025,
                                              fontFamily: AppFont.OutfitFont,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            selectedGroupName,
                                            style: TextStyle(
                                              color: const Color(0xFF969492),
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.015,
                                              fontFamily: AppFont.OutfitFont,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),

                                      Row(
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.17, // 17% of screen width
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03, // 3% of screen height
                                            child: ElevatedButton(
                                              onPressed: () {
                                                _showLogoutDialog(context);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                foregroundColor: const Color(0xFF2D2A26),
                                                backgroundColor: Colors.white,


                                                side: const BorderSide(
                                                    color: Colors.black,
                                                    width: 1),
                                                elevation: 0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              child: Text(
                                                'Log Out',
                                                style: TextStyle(
                                                  fontSize: MediaQuery.of(
                                                              context)
                                                          .size
                                                          .width *
                                                      0.018, // 1.8% of screen width
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  fontWeight: FontWeight.w500,
                                                  color: const Color(0xFF2D2A26),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),

                                          //edit profile hide for uploading
                                          // SizedBox(
                                          //   width: MediaQuery.of(context)
                                          //           .size
                                          //           .width *
                                          //       0.17, // 17% of screen width
                                          //   height: MediaQuery.of(context)
                                          //           .size
                                          //           .height *
                                          //       0.03, // 3% of screen height
                                          //   child: ElevatedButton(
                                          //     onPressed: () {
                                          //       Navigator.pushNamed(
                                          //         context,
                                          //         "/edit_profile",
                                          //       );
                                          //     },
                                          //     style: ElevatedButton.styleFrom(
                                          //       foregroundColor:
                                          //       const Color(0xFF2D2A26),
                                          //       backgroundColor: Colors.white,
                                          //       side: const BorderSide(
                                          //           color: Colors.black,
                                          //           width: 1),
                                          //       elevation: 0,
                                          //       shape: RoundedRectangleBorder(
                                          //         borderRadius:
                                          //             BorderRadius.circular(10),
                                          //       ),
                                          //     ),
                                          //     child: Text(
                                          //       'Edit Profile',
                                          //       style: TextStyle(
                                          //         fontSize: MediaQuery.of(
                                          //                     context)
                                          //                 .size
                                          //                 .width *
                                          //             0.018, // 1.8% of screen width
                                          //         fontFamily:
                                          //             AppFont.OutfitFont,
                                          //         fontWeight: FontWeight.w500,
                                          //         color: const Color(0xFF2D2A26),
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Padding(
                        padding:
                        const EdgeInsets.only(left: 35.0, right: 35.0, top: 0),
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 50.0, right: 50.0, top: 30, bottom: 30),
                          decoration: BoxDecoration(
                            color: Colors.white, // Background color
                            borderRadius:
                                BorderRadius.circular(14), // Border radius
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Left Side: First Name
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'First Name',
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.019,
                                            fontFamily: AppFont.OutfitFont,
                                            fontWeight: FontWeight.w400,
                                            color: const Color(0xFF999999),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          userDetails['firstname'] ?? '',
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.022,
                                            fontFamily: AppFont.OutfitFont,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const Divider(
                                          height: 20,
                                          color: Color(0xFFF2F2F2),
                                          thickness: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Last Name',
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.019,
                                            fontFamily: AppFont.OutfitFont,
                                            fontWeight: FontWeight.w400,
                                            color: const Color(0xFF999999),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          userDetails['lastname'] ?? '',
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.022,
                                            fontFamily: AppFont.OutfitFont,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const Divider(
                                          height: 20,
                                          color: Color(0xFFF2F2F2),
                                          thickness: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10), // Space between rows
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Email
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Email',
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.019,
                                            fontFamily: AppFont.OutfitFont,
                                            fontWeight: FontWeight.w400,
                                            color: const Color(0xFF999999),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          userDetails['email'] ?? '',
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.022,
                                            fontFamily: AppFont.OutfitFont,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const Divider(
                                          height: 20,
                                          color: Color(0xFFF2F2F2),
                                          thickness: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  // Phone
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Phone',
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.019,
                                            fontFamily: AppFont.OutfitFont,
                                            fontWeight: FontWeight.w400,
                                            color: const Color(0xFF999999),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          userDetails['phone'] ?? '',
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.022,
                                            fontFamily: AppFont.OutfitFont,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const Divider(
                                          height: 20,
                                          color: Color(0xFFF2F2F2),
                                          thickness: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 10), // Space between rows
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Email
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Username',
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.019,
                                            fontFamily: AppFont.OutfitFont,
                                            fontWeight: FontWeight.w400,
                                            color: const Color(0xFF999999),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          userDetails['username'] ?? '',
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.022,
                                            fontFamily: AppFont.OutfitFont,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const Divider(
                                          height: 20,
                                          color: Color(0xFFF2F2F2),
                                          thickness: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 10), // Space between rows
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Password',
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.019,
                                            fontFamily: AppFont.OutfitFont,
                                            fontWeight: FontWeight.w400,
                                            color: const Color(0xFF999999),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            // Display password or masked characters
                                            Text(
                                              _isPasswordVisible
                                                  ? userDetails['password'] ??
                                                      ''
                                                  : '•••••••••••',
                                              style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.022,
                                                fontFamily: AppFont.OutfitFont,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),

                                            Row(
                                              children: [
                                                IconButton(
                                                  icon: Icon(
                                                    _isPasswordVisible
                                                        ? Icons.visibility
                                                        : Icons.visibility_off,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      _isPasswordVisible =
                                                          !_isPasswordVisible; // Toggle visibility
                                                    });
                                                  },
                                                ),
                                                const SizedBox(width: 10.0),
                                                GestureDetector(
                                                  onTap: () {
                                                    _showChangePasswordDialog(
                                                        context);
                                                  },
                                                  child: Text(
                                                    'Change password',
                                                    style: TextStyle(
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.022,
                                                        fontFamily:
                                                            AppFont.OutfitFont,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: AppColor
                                                            .primaryColor),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const Divider(
                                          height: 20,
                                          color: Color(0xFFF2F2F2),
                                          thickness: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10), // Space between rows
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Email
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Gender',
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.019,
                                            fontFamily: AppFont.OutfitFont,
                                            fontWeight: FontWeight.w400,
                                            color: const Color(0xFF999999),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          userDetails['gender'] ?? '',
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.022,
                                            fontFamily: AppFont.OutfitFont,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const Divider(
                                          height: 20,
                                          color: Color(0xFFF2F2F2),
                                          thickness: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 10), // Space between rows
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Email
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Place',
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.019,
                                            fontFamily: AppFont.OutfitFont,
                                            fontWeight: FontWeight.w400,
                                            color: const Color(0xFF999999),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          userDetails['location'] ?? '',
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.022,
                                            fontFamily: AppFont.OutfitFont,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const Divider(
                                          height: 20,
                                          color: Color(0xFFF2F2F2),
                                          thickness: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Stack(children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              color: Colors.black.withOpacity(0.05), // Transparent background
            ),
          ),
          Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              width: 500,
              // height: MediaQuery.of(context).size.height * 0.20,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(35),
              child: ListView(
                shrinkWrap: true,
                children: [Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Log Out?',
                          style: TextStyle(
                            fontSize: 22,
                            fontFamily: AppFont.OutfitFont,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Are you sure to logout?',
                      style: TextStyle(
                        fontSize: 19,
                        fontFamily: AppFont.OutfitFont,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: const Color(0xFF2D2A26),
                              backgroundColor: const Color(0xFFFFFFFF),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 13.0, horizontal: 9),
                              side: const BorderSide(color: Colors.black, width: 1),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                fontFamily: AppFont.OutfitFont,
                                fontSize: 23,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {

                                AppSp().setIsLogged(false);
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ),
                                );

                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: const Color(0xFF2D2A26),
                              backgroundColor: const Color(0xFFFFFFFF),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 10),
                              side: const BorderSide(color: Colors.black, width: 1),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Log Out',
                              style: TextStyle(
                                fontFamily: AppFont.OutfitFont,
                                fontSize: 23,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
        ],
              ),
            ),
          ),
        ]);
      },
    );
  }

  bool _isCurrentPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;


  void _showChangePasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Stack(children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              color: Colors.black.withOpacity(0.05), // Transparent background
            ),
          ),
          Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  width: 500,
                  // height: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(30),
                  child: ListView(
                    shrinkWrap: true,
                    children:[ Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Change your Password',
                              style: TextStyle(
                                fontSize: 28,
                                fontFamily: AppFont.OutfitFont,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _currentpassword.text = '';
                                  _newpassword.text = '';
                                  _confirmpassword.text = '';
                                });
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: const Icon(
                                Icons.close,
                                color: Colors.black,
                                size: 45,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),

                        // Current Password
                        Text(
                          'Current Password',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: AppFont.OutfitFont,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _currentpassword,
                          obscureText: !_isCurrentPasswordVisible,
                          decoration: InputDecoration(
                            hintText: 'Current Password',
                            hintStyle: const TextStyle(color: Color(0xFFCACAC9)),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0xFFCACAC9)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0xFF626262)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0xFFCACAC9)),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isCurrentPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isCurrentPasswordVisible =
                                      !_isCurrentPasswordVisible;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),

                        // New Password
                        Text(
                          'New Password',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: AppFont.OutfitFont,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _newpassword,
                          obscureText: !_isNewPasswordVisible,
                          decoration: InputDecoration(
                            hintText: 'New Password',
                            hintStyle: const TextStyle(color: Color(0xFFCACAC9)),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0xFFCACAC9)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0xFF626262)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0xFFCACAC9)),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isNewPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isNewPasswordVisible = !_isNewPasswordVisible;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Confirm Password
                        Text(
                          'Confirm Password',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: AppFont.OutfitFont,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _confirmpassword,
                          obscureText: !_isConfirmPasswordVisible,
                          decoration: InputDecoration(
                            hintText: 'Confirm Password',
                            hintStyle: const TextStyle(color: Color(0xFFCACAC9)),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0xFFCACAC9)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0xFF626262)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0xFFCACAC9)),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isConfirmPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isConfirmPasswordVisible =
                                      !_isConfirmPasswordVisible;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),

                        SizedBox(
                          width: double.infinity, // Make button full width
                          child: ElevatedButton(
                            onPressed: () {
                              updatePassword();
                              // Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: const Color(0x74FFFFFF),
                              backgroundColor: const Color(0xFFAA182C),
                              padding: const EdgeInsets.all(15.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Set Password',
                              style: TextStyle(
                                fontFamily: AppFont.OutfitFont,
                                fontSize: 25,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]
                  ),
                );
              },
            ),
          ),
        ]);
      },
    );
  }

















  void updatePassword() async {
    if ((_currentpassword.text) == (userDetails['password'])) {
      if ((_currentpassword.text) != (_newpassword.text)) {
        if ((_newpassword.text) == (_confirmpassword.text)) {
          try {
            var response = await http.Client().patch(
              Uri.parse("${AppUrls.userdetails}$UserID/"),
              headers: {
                "Content-Type": "application/json",
                "Accept": "application/json",
                "Authorization": "Bearer $userToken"
              },
              body: jsonEncode({
                "old_password": _currentpassword.text,
                "new_password": _newpassword.text
              }),
            );

            if (response.statusCode == 200) {
              final responseData = json.decode(response.body);

              // Show success message
              EasyLoading.showSuccess(responseData['message']);

              userDetails['password'] = _newpassword.text;
              await AppSp().setUserDetails(jsonEncode(userDetails));

              setState(() {
                _currentpassword.text = '';
                _newpassword.text = '';
                _confirmpassword.text = '';
              });

              // Navigate back or pop the current screen
              Navigator.of(context).pop();
            } else {
              // Handle error responses from the API
              final responseData = json.decode(response.body);
              EasyLoading.showError(responseData['message']);
            }
          } catch (e) {
            EasyLoading.showError("Error in API $e");
          }
        } else {
          EasyLoading.showError("New and Confirm password do not match");
        }
      } else {
        EasyLoading.showError(
            "New password cannot be the same as the current password");
      }
    } else {
      EasyLoading.showError("Current password is incorrect");
    }
  }
}
