import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:falcon_aviation/utils/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:path_provider/path_provider.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/app_font.dart';
import 'package:http/http.dart' as http;

import '../../../utils/app_sp.dart';
import '../../../utils/app_urls.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  final TextEditingController _passwordcontroller = TextEditingController();
  final FocusNode _passwordfocusNode = FocusNode();
  bool _obscurePassword = true;
  bool _isLoading = false;
  bool _isCompleted = false;
  bool _showGroupDropdown = false;
  bool _showSubGroupDropdown = false;
  bool _isPressed = false;
  bool _showLoginButton = false;

  String userToken = "";
  String _userEmail = "";

  String selectedGroupis = '';
  String selectedSubGroupis = '';
  String selectedGroupNameis = '';

  Map<String, String> groupMap = {};
  Map<String, String> subgroupMap = {};

  @override
  void dispose() {
    _emailController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  //email Fetching API
  void _emailSearch(String email) async {
    setState(() {
      _isLoading = true;
      _isCompleted = false;
    });

    try {
      var response = await http.Client().get(
        Uri.parse("${AppUrls.emailcheck}$email"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        userToken = responseData['token'];
        _userEmail = email;

        AppSp().setToken(responseData['token']);

        Map<String, String> fetchedGroups = {
          '0': 'Select Aircraft Type',
          for (var group in responseData['data']['groups'])
            group['id'].toString(): group['name'].toString()
        };

        setState(() {
          groupMap = fetchedGroups;
          _isLoading = false;
          _isCompleted = true;
          _showGroupDropdown = true;
        });
      } else {
        final responseData = json.decode(response.body);
        EasyLoading.showError(responseData['message']);
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      log("Error in API $e");
      EasyLoading.showError("Error in API $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  //Subgroup fetching API
  void _fetchsubgroup(String groupId) async {
    try {
      var response = await http.Client().get(
        Uri.parse("${AppUrls.groups}$groupId/subgroups/"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $userToken"
        },
      );

      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        final responseData = json.decode(response.body);
        Map<String, String> fetchedSubgroups = {
          '0': 'Select Aircraft Registration',
          for (var subgroup in responseData)
            subgroup['id'].toString(): subgroup['group_name'].toString()
        };

        setState(() {
          subgroupMap = fetchedSubgroups;
          _showSubGroupDropdown = true;
        });
      } else {
        EasyLoading.dismiss();
        EasyLoading.showError("Failed to load subgroups");
      }
    } catch (e) {
      EasyLoading.dismiss();
      log("Error in API $e");
      EasyLoading.showError("Error in API $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Login API
  void _loginAuthenticate(String password, String selectedSubGroupId) async {
    // print(password);
    // print(selectedSubGroupId);
    // print(_userEmail);

    try {
      var response = await http.Client().post(
        Uri.parse(AppUrls.login),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $userToken"
        },
        body: jsonEncode({
          "email": _userEmail,
          "group": selectedSubGroupId,
          "password": password
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        // print(responseData);
        AppSp().setUserDetails(jsonEncode(responseData['data']));

        AppSp().setFirstname(responseData['data']['firstname']);
        AppSp().setLastname(responseData['data']['lastname']);
        AppSp().setFullname(
            "${responseData['data']['firstname']} ${responseData['data']['lastname']}");
        AppSp().setUserID(responseData['data']['id']);

        // print(responseData);

        String localIconPath = await downloadAppIcon(
            responseData['data']['profile_pic'],
            "${responseData['data']['firstname']}_${responseData['data']['lastname']}");

        AppSp().setUserprofilepic(localIconPath);

        AppSp().setIsLogged(true);
        EasyLoading.dismiss();
        EasyLoading.showSuccess(responseData['message']);
        Navigator.pushNamed(
          context,
          "/home",
        );
      } else {
        EasyLoading.dismiss();
        final responseData = json.decode(response.body);
        // print(responseData['message']);
        EasyLoading.showError(responseData['message']);

        setState(() {
          _passwordcontroller.text = '';
        });
      }
    } catch (e) {
      EasyLoading.dismiss();
      if (e.toString().contains('Connection refused')) {
        EasyLoading.showToast(
            'You are in offline mode!\nPlease check your network connection.');
      } else {
        EasyLoading.showToast(
            'Something went wrong!\nPlease check again later.');
      }

      log("Error in API $e");
    }
  }

  //fetch profile picture

  Future<String> downloadAppIcon(String iconUrl, String appName) async {
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
  Widget build(BuildContext context) {
    String selectedGroupId =
        groupMap.keys.isNotEmpty ? groupMap.keys.first : 'Select Aircraft type';
    String dropdownGroupValue = groupMap[selectedGroupId] ?? 'Select Aircraft type';

    String selectedSubGroupId = subgroupMap.keys.isNotEmpty
        ? subgroupMap.keys.first
        : 'Select a Aircraft Registration';
    String dropdownSubGroupValue =
        subgroupMap[selectedSubGroupId] ?? 'Select a Registration';

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
        backgroundColor: const Color(0xFFF8F9FB),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              WhiteBackground,
              fit: BoxFit.cover,
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 200),
                  // Logo
                  Image.asset(
                    RedBlackLogo,
                    width: 180,
                    height: 100,
                  ),
                  const SizedBox(height: 50),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 180.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Email',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: AppFont.OutfitFont,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                )),
                            const SizedBox(height: 10),
                            TextField(
                              controller: _emailController,
                              focusNode: _focusNode,
                              textInputAction: TextInputAction.search,
                              onSubmitted: (value) {
                                if (_emailController.text.toString() == "") {
                                  EasyLoading.showToast(
                                      "Email address is required.");
                                } else {
                                  _emailSearch(_emailController.text);
                                }
                              },
                              decoration: InputDecoration(
                                hintText: 'Email or Username',
                                hintStyle:
                                    const TextStyle(color: Color(0xFFCACAC9)),
                                filled: true, // Enables the background fill
                                fillColor: Colors
                                    .white, // Sets the background color to white
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      const BorderSide(color: Color(0xFFCACAC9)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      const BorderSide(color: Color(0xFF626262)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      const BorderSide(color: Color(0xFFCACAC9)),
                                ),
                                suffixIcon: _isLoading
                                    ? Padding(
                                        padding: const EdgeInsets.only(right: 20.0),
                                        child: Container(
                                          height: 20,
                                          width: 20,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0),
                                          child: const CircularProgressIndicator(
                                            color: AppColor.primaryColor,
                                            backgroundColor: Colors.white,
                                            strokeWidth: 3.0,
                                          ),
                                        ),
                                      )
                                    : _isCompleted
                                        ? const Padding(
                                            padding: EdgeInsets.only(right: 20.0),
                                            child: Icon(
                                              Icons.check_circle_outline_outlined,
                                              color: Colors.green,
                                              size: 30,
                                            ),
                                          )
                                        : null,
                              ),
                            ),
                            const SizedBox(height: 20),
                            AnimatedOpacity(
                              opacity: _showGroupDropdown ? 1.0 : 0.0,
                              duration: const Duration(milliseconds: 500),
                              child: AnimatedSlide(
                                offset: _showGroupDropdown
                                    ? const Offset(0, 0)
                                    : const Offset(0, 0.2),
                                duration: const Duration(milliseconds: 500),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Aircraft Type',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: AppFont.OutfitFont,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    DropdownButtonFormField<String>(
                                      value: dropdownGroupValue,
                                      items: groupMap.values.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedGroupId = groupMap.keys
                                              .firstWhere(
                                                  (id) => groupMap[id] == newValue,
                                                  orElse: () => 'Select Group');
                                          // print( Selected Group ID: $selectedGroupId");
                      
                                          subgroupMap.clear();
                      
                                          if (selectedGroupId == '0') {
                                            EasyLoading.showError(
                                                'Please Select Aircraft Type');
                                          } else {
                                            EasyLoading.show();
                                            selectedGroupis = selectedGroupId;
                      
                      
                      
                                            AppSp().setSelected_Maingroup(
                                                newValue!);
                                            AppSp().setSelected_MaingroupID(
                                                selectedGroupis);
                      
                      
                                            _fetchsubgroup(selectedGroupId);
                                          }
                                        });
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'Select an Aircraft Type',
                                        hintStyle: const TextStyle(
                                            color: Color(0xFFCACAC9)),
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                              color: Color(0xFFCACAC9)),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                              color: Color(0xFFCACAC9)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                              color: Color(0xFF626262)),
                                        ),
                                      ),
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            AnimatedOpacity(
                              opacity: _showSubGroupDropdown ? 1.0 : 0.0,
                              duration: const Duration(milliseconds: 500),
                              child: AnimatedSlide(
                                offset: _showSubGroupDropdown
                                    ? const Offset(0, 0)
                                    : const Offset(0, 0.2),
                                duration: const Duration(milliseconds: 500),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Aircraft Registration',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: AppFont.OutfitFont,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    DropdownButtonFormField<String>(
                                      value: dropdownSubGroupValue,
                                      items: subgroupMap.values.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedSubGroupId = subgroupMap.keys
                                              .firstWhere(
                                                  (id) =>
                                                      subgroupMap[id] == newValue,
                                                  orElse: () => '0');
                      
                                          // print( "Selected SubGroup ID: $selectedSubGroupId");
                      
                                          if (selectedSubGroupId == '0') {
                                            EasyLoading.showError(
                                                'Please Select a Aircraft Registration');
                                          } else {
                                            // EasyLoading.show();
                                            print(selectedSubGroupId);
                                            print(
                                                "Selected SubGroup Name: ${subgroupMap[selectedSubGroupId]}");
                                            selectedGroupNameis =
                                                subgroupMap[selectedSubGroupId]!;
                      
                                            selectedSubGroupis = selectedSubGroupId;
                                            AppSp().setSelectedgroup(
                                                selectedGroupNameis);
                                            AppSp().setSelectedgroupID(
                                                selectedSubGroupId);
                                            _showLoginButton = true;
                                          }
                                        });
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'Select a Aircraft Registration',
                                        hintStyle: const TextStyle(
                                            color: Color(0xFFCACAC9)),
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                              color: Color(0xFFCACAC9)),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                              color: Color(0xFFCACAC9)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                              color: Color(0xFF626262)),
                                        ),
                                      ),
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            AnimatedOpacity(
                              opacity: _showLoginButton ? 1.0 : 0.0,
                              duration: const Duration(milliseconds: 500),
                              child: AnimatedSlide(
                                offset: _showLoginButton
                                    ? const Offset(0, 0)
                                    : const Offset(0, 0.2),
                                duration: const Duration(milliseconds: 500),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Password',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: AppFont.OutfitFont,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                        )),
                                    const SizedBox(height: 10),
                                    TextField(
                                      controller: _passwordcontroller,
                                      focusNode: _passwordfocusNode,
                                      obscureText: _obscurePassword,
                                      textInputAction: TextInputAction.done,
                                      onSubmitted: (value) {},
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: 'Password',
                                        hintStyle: const TextStyle(
                                            color: Color(0xFFCACAC9)),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                              color: Color(0xFFCACAC9)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                              color: Color(0xFF626262)),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                              color: Color(0xFFCACAC9)),
                                        ),
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _obscurePassword =
                                                  !_obscurePassword; // Toggle password visibility
                                            });
                                          },
                                          child: Icon(
                                            _obscurePassword
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: const Color(0xFF626262),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    // Align(
                                    //   alignment: Alignment
                                    //       .centerRight, // Align text to the right
                                    //   child: Text(
                                    //     'Recover Password?',
                                    //     style: TextStyle(
                                    //       fontSize: 18,
                                    //       fontFamily: AppFont.OutfitFont,
                                    //       color: AppColor.primaryColor,
                                    //       fontWeight: FontWeight.w400,
                                    //     ),
                                    //   ),
                                    // ),
                                    const SizedBox(height: 25),
                                    ElevatedButton(
                                      onPressed: () {
                                        if (_passwordcontroller.text.toString() ==
                                            "") {
                                          EasyLoading.showError(
                                              "Please Enter Password");
                                        } else {
                                          EasyLoading.show( status: 'Authenticating...');
                                          _loginAuthenticate(
                                              _passwordcontroller.text,
                                              selectedGroupis);
                                        }
                      
                                        // setState(() {
                                        //   _isPressed = !_isPressed;
                                        //
                                        //   Navigator.pushNamed(
                                        //     context,
                                        //     "/home",
                                        //   );
                                        // });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: _isPressed
                                            ? AppColor.primaryColor
                                            : Colors.white,
                                        minimumSize:
                                            const Size(double.infinity, 55),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15),
                                          side: const BorderSide(
                                              color: Color(0xFF2D2A26), width: 1),
                                        ),
                                        elevation: 0,
                                      ),
                                      child: Text('Login',
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontFamily: AppFont.OutfitFont,
                                            color: _isPressed
                                                ? Colors.white
                                                : Colors.black,
                                            fontWeight: FontWeight.w400,
                                          )),
                                    ),
                                  ],
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
            ),
          ],
        ),
      ),
    );
  }
}
