import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:falcon_aviation/utils/app_color.dart';
import 'package:falcon_aviation/utils/app_constant.dart';
import 'package:falcon_aviation/utils/app_font.dart';
import 'package:falcon_aviation/view/screen/profile/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../../../utils/app_functions.dart';
import '../../../utils/app_sp.dart';
import '../../../utils/app_urls.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  final TextEditingController _firstnameTextfield = TextEditingController();
  final TextEditingController _lastnameTextfield = TextEditingController();
  final TextEditingController _emailTextfield = TextEditingController();
  final TextEditingController _phoneTextfield = TextEditingController();
  final TextEditingController _addressTextfield = TextEditingController();
  String? _selectedGender;

  File? _selectedImage;

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
    getUserToken();

  }



  Future<void> getUserToken() async {
    AppSp appSp = AppSp();
    userDetails = await appSp.getUserDetails();
    userToken = await appSp.getToken();
    fullName = await appSp.getFullname();
    selectedGroupName = await appSp.getSelectedgroup();
    profile = await appSp.getUserprofilepic();
    UserID = await appSp.getUserID();

    // print(userDetails);

    setState(() {
      function_FetchUserDetails(UserID,userToken);
      profile = profile;
    });
    _updateTextField();




  }
  void _updateTextField() {
    _firstnameTextfield.text =  userDetails['firstname'] ?? '';
    _lastnameTextfield.text = userDetails['lastname'] ?? '';
    _emailTextfield.text = userDetails['email'] ?? '';
    _phoneTextfield.text = userDetails['phone'] ?? '';
    _selectedGender = userDetails['gender'] ?? '';
    _addressTextfield.text = userDetails['location'] ?? '';

  }



  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: Stack(
        children: [
          // Background container
          Padding(
            padding: const EdgeInsets.only(
              left: 28.0,
              right: 28.0,
              top: 30,
            ),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage(profileBack),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Close button
          Positioned(
            top: 30,
            right: 25,
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  "/profile",
                );
              },
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: MediaQuery.of(context).size.width * 0.04,
              ),
            ),
          ),
          // Title text
          Positioned(
            top: 85,
            left: 16,
            right: 16,
            child: Center(
              child: Text(
                'EDIT PROFILE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width * 0.025,
                  fontFamily: AppFont.OutfitFont,
                  letterSpacing: 15.0,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // Profile image
          Positioned(
            top: MediaQuery.of(context).size.height * 0.12,
            left: 16,
            right: 16,
            child: Align(
              alignment: Alignment.center,
              child: Stack(
                children: [



                  Container(
                    width: MediaQuery.of(context).size.width * 0.26,
                    height: MediaQuery.of(context).size.width * 0.26,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 6.0,
                      ),
                    ),

                    // backgroundImage:  FileImage(File(profile)),


                    child: CircleAvatar(
                      backgroundImage: _selectedImage != null
                          ? FileImage(_selectedImage!)
                          : FileImage(File(profile)) ,
                      radius: MediaQuery.of(context).size.width * 0.13,
                    ),
                  ),
                  // Red plus button
                  Positioned(
                    bottom: 0,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 3.0,
                        ),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: MediaQuery.of(context).size.width * 0.03,
                        ),
                        onPressed: () async {
                          final ImagePicker picker = ImagePicker();
                          final XFile? image = await picker.pickImage(source: ImageSource.gallery);

                          if (image != null) {
                            final File imageFile = File(image.path);
                            final int fileSize = await imageFile.length();
                            const int maxSize = 2 * 1024 * 1024;

                            if (fileSize <= maxSize) {
                              EasyLoading.showProgress(0.5, status: 'Uploading Profile...');
                              setState(() {

                                // print('file pathe');
                                // print('============');
                                // print(imageFile);
                                // print('============');

                                _selectedImage = imageFile;
                                // updateMyprofile();
                                // await function_FetchUserDetails(UserID,userToken);
                              });


                              EasyLoading.dismiss();
                              // EasyLoading.showSuccess('Profile uploaded!');
                            } else {
                              EasyLoading.showError('File size exceeds 2MB limit.');

                            }
                          } else {
                            print('No image selected.');
                          }
                        },
                      ),
                    ),
                  ),




                ],
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(
                left: 28.0,
                right: 28.0,
                top: MediaQuery.of(context).size.height * 0.33,
                bottom: 140),
            child: Container(
              padding:
                  const EdgeInsets.only(left: 50.0, right: 50.0, top: 30, bottom: 30),
              decoration: BoxDecoration(
                color: Colors.white, // Background color
                borderRadius: BorderRadius.circular(14), // Border radius
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Left Side: First Name
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'First Name',
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.019,
                                  fontFamily: AppFont.OutfitFont,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF999999),
                                ),
                              ),
                              const SizedBox(height: 5),
                              TextField(
                                controller: _firstnameTextfield,
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * 0.022,
                                  fontFamily: AppFont.OutfitFont,
                                  fontWeight: FontWeight.w400,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none, // This removes the border
                
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
                        SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Last Name',
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.019,
                                  fontFamily: AppFont.OutfitFont,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF999999),
                                ),
                              ),
                              SizedBox(height: 5),
                              TextField(
                                controller: _lastnameTextfield,
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * 0.022,
                                  fontFamily: AppFont.OutfitFont,
                                  fontWeight: FontWeight.w400,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                
                              Divider(
                                height: 20,
                                color: Color(0xFFF2F2F2),
                                thickness: 1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20), // Space between rows
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Email
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Email',
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.019,
                                  fontFamily: AppFont.OutfitFont,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF999999),
                                ),
                              ),
                              SizedBox(height: 5),
                              TextField(
                                controller: _emailTextfield,
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * 0.022,
                                  fontFamily: AppFont.OutfitFont,
                                  fontWeight: FontWeight.w400,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                
                              Divider(
                                height: 20,
                                color: Color(0xFFF2F2F2),
                                thickness: 1,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 20),
                        // Phone
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Phone',
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.019,
                                  fontFamily: AppFont.OutfitFont,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF999999),
                                ),
                              ),
                              SizedBox(height: 5),
                              TextField(
                                controller: _phoneTextfield,
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * 0.022,
                                  fontFamily: AppFont.OutfitFont,
                                  fontWeight: FontWeight.w400,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                
                              Divider(
                                height: 20,
                                color: Color(0xFFF2F2F2),
                                thickness: 1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                
                    SizedBox(height: 20), // Space between rows
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Email
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Gender',
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.019,
                                  fontFamily: AppFont.OutfitFont,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF999999),
                                ),
                              ),
                              SizedBox(height: 5),
                
                              DropdownButtonFormField<String>(
                                value: _selectedGender,
                                items: ['Male', 'Female', 'Other']
                                    .map((label) => DropdownMenuItem(
                                  child: Text(label),
                                  value: label,
                                ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedGender = value;
                                  });
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                                ),
                                style: TextStyle(
                                  fontSize:
                                  MediaQuery.of(context).size.width * 0.022,
                                  fontFamily: AppFont.OutfitFont,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black
                                ),
                              ),
                              Divider(
                                height: 20,
                                color: Color(0xFFF2F2F2),
                                thickness: 1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                
                    SizedBox(height: 20), // Space between rows
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Email
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Place',
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.019,
                                  fontFamily: AppFont.OutfitFont,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF999999),
                                ),
                              ),
                              SizedBox(height: 5),
                              TextField(
                                controller: _addressTextfield,
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * 0.022,
                                  fontFamily: AppFont.OutfitFont,
                                  fontWeight: FontWeight.w400,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                              Divider(
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


          Positioned(
            bottom: 40,
            left: MediaQuery.of(context).size.width * 0.25,
            right: MediaQuery.of(context).size.width * 0.25,
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  EasyLoading.show( status: 'Updating...');
                  updateMyprofile();
                },
                style: ButtonStyle(
                  foregroundColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.pressed)) {
                      return Colors.white; // Text color when button is pressed
                    }
                    return Colors.white70; // Default text color
                  }),
                  // backgroundColor: WidgetStateProperty.all(Color(0xFFAA182C)),

                  backgroundColor:  WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.pressed)) {
                      return(Color(0xFFE8374F)); // Text color when button is pressed
                    }
                    return (Color(0xFFAA182C)); // Default text color
                  }),


                  padding: WidgetStateProperty.all(const EdgeInsets.all(13.0)),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                child: Text(
                  'Update',
                  style: TextStyle(
                    fontFamily: AppFont.OutfitFont,
                    fontSize: 23,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),









        ],
      ),
    );
  }

  // void updateMyprofile() async {
  //
  //   print(_firstnameTextfield.text);
  //   print(_lastnameTextfield.text);
  //   print(_emailTextfield.text);
  //   print(_phoneTextfield.text);
  //   print(_addressTextfield.text);
  //   print(_selectedGender);
  //
  //   // {"firstname":"Rashisir","lastname":"Sadik","email": "testxx@gmail.com","phone": "9876543211","gender":"Male","dob":"2030-07-30","location":"GH 234 Hosue Germany","profile_pic": "/media/profile/business_1.png"}
  //
  //
  //   try {
  //     var response = await http.Client().put(
  //       Uri.parse("${AppUrls.userdetails}$UserID/"),
  //       headers: {
  //         "Content-Type": "application/json",
  //         "Accept": "application/json",
  //         "Authorization": "Bearer $userToken"
  //       },
  //       body: jsonEncode({
  //         "firstname": _firstnameTextfield.text,
  //         "lastname":_lastnameTextfield.text,
  //         "email":_emailTextfield.text,
  //         "phone":_phoneTextfield.text,
  //         "gender":_selectedGender,
  //         "location":_addressTextfield.text,
  //
  //       }),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final responseData = json.decode(response.body);
  //       print(responseData);
  //
  //       EasyLoading.showSuccess("Profile updated successfully");
  //       function_FetchUserDetails(UserID,userToken);
  //       // Navigator.pushNamed( context, "/profile",);
  //       Navigator.push( context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
  //
  //     } else {
  //       EasyLoading.showError("Failed to load subgroups");
  //     }
  //   } catch (e) {
  //     log("Error in API $e");
  //     EasyLoading.showError("Error in API $e");
  //
  //   }
  //
  //
  // }

  void updateMyprofile() async {
    // print(_firstnameTextfield.text);
    // print(_lastnameTextfield.text);
    // print(_emailTextfield.text);
    // print(_phoneTextfield.text);
    // print(_addressTextfield.text);
    // print(_selectedGender);

    try {
      var request = http.MultipartRequest('PUT', Uri.parse("${AppUrls.userdetails}$UserID/"));

      // Add headers
      request.headers.addAll({
        "Content-Type": "multipart/form-data",
        "Accept": "application/json",
        "Authorization": "Bearer $userToken",
      });

      // Add text fields
      request.fields['firstname'] = _firstnameTextfield.text;
      request.fields['lastname'] = _lastnameTextfield.text;
      request.fields['email'] = _emailTextfield.text;
      request.fields['phone'] = _phoneTextfield.text;
      request.fields['gender'] = _selectedGender!;
      request.fields['location'] = _addressTextfield.text;

      // Add image file if it's selected
      final _selectedImage = this._selectedImage;
      if (_selectedImage != null) {
        // print('saved ths image $_selectedImage' );
        var imageFile = await http.MultipartFile.fromPath('profile_pic', _selectedImage.path);

        // print(imageFile);
        request.files.add(imageFile);
      }else{
        print('this is not in saved ths image');
      }

      // Send the request
      var response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final responseData = json.decode(responseBody);
        EasyLoading.dismiss();

        EasyLoading.showSuccess("Profile updated successfully");

        String localIconPath = await downloadAppIcon( responseData['data']['profile_pic'], "${responseData['data']['firstname']}_${responseData['data']['lastname']}");

        setState(() {
          AppSp().setUserprofilepic(localIconPath);
          function_FetchUserDetails(UserID, userToken);
          // profile = profile;
        });

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
      } else {
        EasyLoading.showError("Failed to update profile. Status code: ${response.statusCode}");
      }
    } catch (e) {
      log("Error in API: $e");
      EasyLoading.showError("Error in API: $e");
    }


  }

}














