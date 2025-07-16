import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

import '../../../../utils/app_color.dart';
import '../../../../utils/app_constant.dart';
import '../../../../utils/app_font.dart';
import '../../../../utils/app_sp.dart';
import '../../../../utils/app_urls.dart';
import '../../profile/profile_screen.dart';

class AircraftSearchChecklist extends StatefulWidget {
  const AircraftSearchChecklist({super.key});

  @override
  State<AircraftSearchChecklist> createState() =>
      _AircraftSearchChecklistState();
}

class _AircraftSearchChecklistState extends State<AircraftSearchChecklist> {
  final TextEditingController _location = TextEditingController();
  final TextEditingController _comment = TextEditingController();
  final TextEditingController _timeStart = TextEditingController();
  final TextEditingController _timeEnd = TextEditingController();

  bool _isChecked1_1 = false;
  bool _isChecked1_2 = false;
  bool _isChecked1_3 = false;
  bool _isChecked1_4 = false;
  bool _isChecked1_5 = false;
  bool _isChecked1_6 = false;
  bool _isChecked1_7 = false;

  bool _isChecked2_1 = false;
  bool _isChecked2_2 = false;
  bool _isChecked2_3 = false;
  bool _isChecked2_4 = false;

  bool _isChecked3_1 = false;
  bool _isChecked3_1a = false;
  bool _isChecked3_1b = false;
  bool _isChecked3_2 = false;
  bool _isChecked3_3 = false;
  bool _isChecked3_4 = false;
  bool _isChecked3_5 = false;

  bool _isChecked4_1 = false;
  bool _isChecked4_2 = false;

  bool _isChecked5_1 = false;
  bool _isChecked5_2 = false;
  bool _isChecked5_3 = false;
  bool _isChecked5_4 = false;
  bool _isChecked5_5 = false;
  bool _isChecked5_6 = false;

  final TextEditingController _remark1_1 = TextEditingController();
  final TextEditingController _remark1_2 = TextEditingController();
  final TextEditingController _remark1_3 = TextEditingController();
  final TextEditingController _remark1_4 = TextEditingController();
  final TextEditingController _remark1_5 = TextEditingController();
  final TextEditingController _remark1_6 = TextEditingController();
  final TextEditingController _remark1_7 = TextEditingController();

  final TextEditingController _remark2_1 = TextEditingController();
  final TextEditingController _remark2_2 = TextEditingController();
  final TextEditingController _remark2_3 = TextEditingController();
  final TextEditingController _remark2_4 = TextEditingController();

  final TextEditingController _remark3_1 = TextEditingController();
  final TextEditingController _remark3_1a = TextEditingController();
  final TextEditingController _remark3_1b = TextEditingController();
  final TextEditingController _remark3_2 = TextEditingController();
  final TextEditingController _remark3_3 = TextEditingController();
  final TextEditingController _remark3_4 = TextEditingController();
  final TextEditingController _remark3_5 = TextEditingController();

  final TextEditingController _remark4_1 = TextEditingController();
  final TextEditingController _remark4_2 = TextEditingController();

  final TextEditingController _remark5_1 = TextEditingController();
  final TextEditingController _remark5_2 = TextEditingController();
  final TextEditingController _remark5_3 = TextEditingController();
  final TextEditingController _remark5_4 = TextEditingController();
  final TextEditingController _remark5_5 = TextEditingController();
  final TextEditingController _remark5_6 = TextEditingController();

  var formId = 'FAF01';
  var currentDate =
      "${DateTime.now().day.toString().padLeft(2, '0')}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().year}";

  bool _userSign = false;

  String userToken = '';
  String fullName = '';
  String selectedGroupName = '';
  List<dynamic> apps = [];
  String profilePic = '';
  String UserID = '';
  String selectedGroupId_id = '';

  String selectMaingroup = '';
  String selectMaingroupId = '';

  var profile = dummyProfile;
  String _formStatus = '';
  String aircraft_search_checklist_refno = '';

  bool allCheckboxesChecked() {
    List<bool> checkGroup1 = [
      _isChecked1_1,
      _isChecked1_2,
      _isChecked1_3,
      _isChecked1_4,
      _isChecked1_5,
      _isChecked1_6,
      _isChecked1_7
    ];

    List<bool> checkGroup2 = [
      _isChecked2_1,
      _isChecked2_2,
      _isChecked2_3,
      _isChecked2_4
    ];

    List<bool> checkGroup3 = [
      _isChecked3_1,
      _isChecked3_1a,
      _isChecked3_1b,
      _isChecked3_2,
      _isChecked3_3,
      _isChecked3_4,
      _isChecked3_5
    ];

    List<bool> checkGroup4 = [_isChecked4_1, _isChecked4_2];

    List<bool> checkGroup5 = [
      _isChecked5_1,
      _isChecked5_2,
      _isChecked5_3,
      _isChecked5_4,
      _isChecked5_5,
      _isChecked5_6
    ];

    return checkGroup1.every((checked) => checked) &&
        checkGroup2.every((checked) => checked) &&
        checkGroup3.every((checked) => checked) &&
        checkGroup4.every((checked) => checked) &&
        checkGroup5.every((checked) => checked);
  }

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

    //form data section
    await formdata_pass_backend(UserID, userToken);

    setState(() {
      selectedGroupId_id = selectedGroupId_id;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> formdata_pass_backend(String userID, String userToken) async {
    print(
        "${AppUrls.formdata}?formid=$formId&userid=$userID&date=$currentDate");
    EasyLoading.show();
    try {
      var response = await http.Client().get(
        Uri.parse(
            "${AppUrls.formdata}?formid=$formId&userid=$userID&date=$currentDate&aircrafttype=$selectMaingroupId&aircraftreg=$selectedGroupId_id"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $userToken"
        },
      );

      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        print(response.body);
        final responseData = json.decode(response.body);
        print(responseData['data']['form_ref_no']);

        setState(() {
          aircraft_search_checklist_refno = responseData['data']['form_ref_no'];
        });

        if ((responseData['data']['form_status']) == 'completed') {
          _location.text = responseData['data']['form_data']['location'] ?? '';
          _comment.text = responseData['data']['form_data']['comments'] ?? '';
          _timeStart.text =
              responseData['data']['form_data']['timeStart'] ?? '';
          _timeEnd.text = responseData['data']['form_data']['timeEnd'] ?? '';
          _userSign = true;

          _formStatus = 'completed';

// Populate remarks dynamically
          var formFields =
              responseData['data']['form_data']['formFields'] ?? [];
          for (var field in formFields) {
            var subFields = field['subFields'] ?? [];
            for (var subField in subFields) {
              var subFieldId = subField['subfieldId'];
              var remarks = subField['remarks'] ?? '';
              if (subFieldId != null && remarks != null) {
                switch (subFieldId.toString()) {
                  case '1.1':
                    _remark1_1.text = remarks;
                    break;
                  case '1.2':
                    _remark1_2.text = remarks;
                    break;
                  case '1.3':
                    _remark1_3.text = remarks;
                    break;
                  case '1.4':
                    _remark1_4.text = remarks;
                    break;
                  case '1.5':
                    _remark1_5.text = remarks;
                    break;
                  case '1.6':
                    _remark1_6.text = remarks;
                    break;
                  case '1.7':
                    _remark1_7.text = remarks;
                    break;
                  case '2.1':
                    _remark2_1.text = remarks;
                    break;
                  case '2.2':
                    _remark2_2.text = remarks;
                    break;
                  case '2.3':
                    _remark2_3.text = remarks;
                    break;
                  case '2.4':
                    _remark2_4.text = remarks;
                    break;
                  case '3.1':
                    _remark3_1.text = remarks;
                    break;
                  case '3.1a':
                    _remark3_1a.text = remarks;
                    break;
                  case '3.1b':
                    _remark3_1b.text = remarks;
                    break;
                  case '3.2':
                    _remark3_2.text = remarks;
                    break;
                  case '3.3':
                    _remark3_3.text = remarks;
                    break;
                  case '3.4':
                    _remark3_4.text = remarks;
                    break;
                  case '3.5':
                    _remark3_5.text = remarks;
                    break;
                  case '4.1':
                    _remark4_1.text = remarks;
                    break;
                  case '4.2':
                    _remark4_2.text = remarks;
                    break;
                  case '5.1':
                    _remark5_1.text = remarks;
                    break;
                  case '5.2':
                    _remark5_2.text = remarks;
                    break;
                  case '5.3':
                    _remark5_3.text = remarks;
                    break;
                  case '5.4':
                    _remark5_4.text = remarks;
                    break;
                  case '5.5':
                    _remark5_5.text = remarks;
                    break;
                  case '5.6':
                    _remark5_6.text = remarks;
                    break;
                }
              }
            }
          }

          _isChecked1_1 = true;
          _isChecked1_2 = true;
          _isChecked1_3 = true;
          _isChecked1_4 = true;
          _isChecked1_5 = true;
          _isChecked1_6 = true;
          _isChecked1_7 = true;
          _isChecked2_1 = true;
          _isChecked2_2 = true;
          _isChecked2_3 = true;
          _isChecked2_4 = true;
          _isChecked3_1 = true;
          _isChecked3_1a = true;
          _isChecked3_1b = true;
          _isChecked3_2 = true;
          _isChecked3_3 = true;
          _isChecked3_4 = true;
          _isChecked3_5 = true;
          _isChecked4_1 = true;
          _isChecked4_2 = true;
          _isChecked5_1 = true;
          _isChecked5_2 = true;
          _isChecked5_3 = true;
          _isChecked5_4 = true;
          _isChecked5_5 = true;
          _isChecked5_6 = true;
        }
      } else {
        EasyLoading.dismiss();
        final responseData = json.decode(response.body);
        print(responseData['message']);
      }
    } catch (e) {
      EasyLoading.dismiss();
      log("Error in API $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Incomplete Form"),
              content: Text("Please fill out the form before leaving."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false); // Stay on the page
                  },
                  child: Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true); // Allow back navigation
                  },
                  child: Text("Continue"),
                ),
              ],
            );
          },
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
                                      builder: (context) =>
                                      const ProfileScreen(),
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
                          child:
                              Card(
                                color: AppColor.primaryColor,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    // Space between icon and text
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    // Vertically centers icon and text
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                            context,
                                            "/forms",
                                          );
                                        },
                                        child: const Icon(
                                          Icons.arrow_back, // Left arrow icon
                                          color: Colors.white,
                                        ),
                                      ),
                                      Expanded(
                                        // Ensures the text stays centered
                                        child: Text(
                                          'Aircraft Search Checklist: $selectMaingroup'
                                              .toUpperCase(),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ),
                            const SizedBox(width: 20),
                            Row(
                              children: [
                                Icon(
                                  Icons
                                      .calendar_month_outlined, // Calendar icon
                                  color: AppColor.primaryColor,
                                ),
                                const SizedBox(
                                    width:
                                    8), // Space between icon and date text
                                Text(
                                  currentDate.toUpperCase(),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: AppFont.OutfitFont,
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                          ),

                              SizedBox(height: 20),

                              Row(
                                children: [
                                  // Left side: "Reg:" label and TextField
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Text('Reg : ',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: AppFont.OutfitFont,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                            )),
                                        const SizedBox(width: 25),
                                        Expanded(
                                          child: TextField(
                                            autocorrect: false,
                                            enableSuggestions: false,
                                            controller: TextEditingController(
                                                text: selectedGroupName),
                                            readOnly: true,
                                            decoration: InputDecoration(
                                              hintStyle: const TextStyle(
                                                  color: Color(0xFFCACAC9)),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(12),
                                                borderSide: const BorderSide(
                                                    color: Color(0xFFCACAC9)),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(12),
                                                borderSide: const BorderSide(
                                                    color: Color(0xFF626262)),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(12),
                                                borderSide: const BorderSide(
                                                    color: Color(0xFFCACAC9)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 25),

                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Text('Location : ',
                                            // Label for the first text field
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: AppFont.OutfitFont,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                            )),
                                        const SizedBox(width: 25),
                                        Expanded(
                                          child: TextField(
                                            autocorrect: false,
                                            enableSuggestions: false,
                                            controller: _location,
                                            textCapitalization:
                                            TextCapitalization.characters,
                                            decoration: InputDecoration(
                                              hintStyle: const TextStyle(
                                                  color: Color(0xFFCACAC9)),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(12),
                                                borderSide: const BorderSide(
                                                    color: Color(0xFFCACAC9)),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(12),
                                                borderSide: const BorderSide(
                                                    color: Color(0xFF626262)),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(12),
                                                borderSide: const BorderSide(
                                                    color: Color(0xFFCACAC9)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'If any suspicious object or Explosive Device is found: DO NOT TOUCH OR DISTURB.',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: AppFont.OutfitFont,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          textAlign: TextAlign
                                              .left, // Ensures left alignment within Text widget
                                        ),
                                        SizedBox(height: 3),
                                        // Adds space between the two texts
                                        Text(
                                          'Secure the area and contact FAS Security Manager and / or the nearest Police representative.',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: AppFont.OutfitFont,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          textAlign: TextAlign
                                              .left, // Ensures left alignment within Text widget
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 20),

                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Row(
                                    children: [
                                      // Item text
                                      Expanded(
                                        flex: 70,
                                        child: Text(
                                          'Item',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: AppFont.OutfitFont,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      // Checked text
                                      Expanded(
                                        flex: 10,
                                        child: Text(
                                          'Checked',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: AppFont.OutfitFont,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 30),
                                      Expanded(
                                        flex: 23,
                                        child: Text(
                                          'Remarks',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: AppFont.OutfitFont,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Card(
                                        elevation: 0,
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          side: BorderSide(
                                            color: Colors.grey,
                                            width: 0.5,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text('1   Flight Deck',
                                                  style: TextStyle(
                                                    fontSize: 21,
                                                    fontFamily:
                                                    AppFont.OutfitFont,
                                                    color:
                                                    AppColor.primaryColor,
                                                    fontWeight: FontWeight.w800,
                                                  )),
                                              Divider(thickness: 1),
                                              Column(
                                                children: [
                                                  ListTile(
                                                    contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                    title: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            children: [
                                                              Text('1.1',
                                                                  textAlign:
                                                                  TextAlign
                                                                      .center,
                                                                  style:
                                                                  TextStyle(
                                                                    fontSize:
                                                                    16,
                                                                    fontFamily:
                                                                    AppFont
                                                                        .OutfitFont,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                  )),
                                                              Container(
                                                                width: 1,
                                                                height: 50,
                                                                color:
                                                                Colors.grey,
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                    10),
                                                              ),
                                                              Flexible(
                                                                child: Text(
                                                                    'Seats including pouches, cushions and underside and back side of seats',
                                                                    textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                    softWrap:
                                                                    true,
                                                                    overflow:
                                                                    TextOverflow
                                                                        .visible,
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize:
                                                                      16,
                                                                      fontFamily:
                                                                      AppFont
                                                                          .OutfitFont,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                    )),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(width: 30),
                                                        Checkbox(
                                                          value: _isChecked1_1,
                                                          activeColor: AppColor
                                                              .primaryColor,
                                                          checkColor:
                                                          Colors.white,
                                                          shape:
                                                          RoundedRectangleBorder(
                                                            side: BorderSide(
                                                              color:
                                                              Colors.grey,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                4.0),
                                                          ),
                                                          onChanged:
                                                              (bool? value) {
                                                            setState(() {
                                                              _isChecked1_1 =
                                                                  value ??
                                                                      false;
                                                            });
                                                          },
                                                        ),
                                                        SizedBox(width: 20),
                                                        Container(
                                                          width: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width *
                                                              0.2,
                                                          height: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.035,
                                                          child: TextField(
                                                            autocorrect: false,
                                                            enableSuggestions: false,
                                                            controller:
                                                            _remark1_1,
                                                            decoration:
                                                            InputDecoration(
                                                              hintStyle: const TextStyle(
                                                                  color: Color(
                                                                      0xFFCACAC9)),
                                                              border:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                              focusedBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFF626262)),
                                                              ),
                                                              enabledBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Divider(thickness: 1),
                                                  ListTile(
                                                    contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                    title: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            children: [
                                                              Text('1.2',
                                                                  textAlign:
                                                                  TextAlign
                                                                      .center,
                                                                  style:
                                                                  TextStyle(
                                                                    fontSize:
                                                                    16,
                                                                    fontFamily:
                                                                    AppFont
                                                                        .OutfitFont,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                  )),
                                                              Container(
                                                                width: 1,
                                                                height: 50,
                                                                color:
                                                                Colors.grey,
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                    10),
                                                              ),
                                                              Flexible(
                                                                child: Text(
                                                                    'Log book and flight manual stowage',
                                                                    textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                    softWrap:
                                                                    true,
                                                                    overflow:
                                                                    TextOverflow
                                                                        .visible,
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize:
                                                                      16,
                                                                      fontFamily:
                                                                      AppFont
                                                                          .OutfitFont,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                    )),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(width: 30),
                                                        Checkbox(
                                                          value: _isChecked1_2,
                                                          activeColor: AppColor
                                                              .primaryColor,
                                                          checkColor:
                                                          Colors.white,
                                                          shape:
                                                          RoundedRectangleBorder(
                                                            side: BorderSide(
                                                              color:
                                                              Colors.grey,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                4.0),
                                                          ),
                                                          onChanged:
                                                              (bool? value) {
                                                            setState(() {
                                                              _isChecked1_2 =
                                                                  value ??
                                                                      false;
                                                            });
                                                          },
                                                        ),
                                                        SizedBox(width: 20),
                                                        Container(
                                                          width: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width *
                                                              0.2,
                                                          height: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.035,
                                                          child: TextField(
                                                            autocorrect: false,
                                                            enableSuggestions: false,
                                                            controller:
                                                            _remark1_2,
                                                            decoration:
                                                            InputDecoration(
                                                              hintStyle: const TextStyle(
                                                                  color: Color(
                                                                      0xFFCACAC9)),
                                                              border:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                              focusedBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFF626262)),
                                                              ),
                                                              enabledBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Divider(thickness: 1),
                                                  ListTile(
                                                    contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                    title: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            children: [
                                                              Text('1.3',
                                                                  textAlign:
                                                                  TextAlign
                                                                      .center,
                                                                  style:
                                                                  TextStyle(
                                                                    fontSize:
                                                                    16,
                                                                    fontFamily:
                                                                    AppFont
                                                                        .OutfitFont,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                  )),
                                                              Container(
                                                                width: 1,
                                                                height: 50,
                                                                color:
                                                                Colors.grey,
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                    10),
                                                              ),
                                                              Flexible(
                                                                child: Text(
                                                                    'Entire floor, including area forward of tail rotor pedals and beneath flight deck seats',
                                                                    textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                    softWrap:
                                                                    true,
                                                                    overflow:
                                                                    TextOverflow
                                                                        .visible,
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize:
                                                                      16,
                                                                      fontFamily:
                                                                      AppFont
                                                                          .OutfitFont,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                    )),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(width: 30),
                                                        Checkbox(
                                                          value: _isChecked1_3,
                                                          activeColor: AppColor
                                                              .primaryColor,
                                                          checkColor:
                                                          Colors.white,
                                                          shape:
                                                          RoundedRectangleBorder(
                                                            side: BorderSide(
                                                              color:
                                                              Colors.grey,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                4.0),
                                                          ),
                                                          onChanged:
                                                              (bool? value) {
                                                            setState(() {
                                                              _isChecked1_3 =
                                                                  value ??
                                                                      false;
                                                            });
                                                          },
                                                        ),
                                                        SizedBox(width: 20),
                                                        Container(
                                                          width: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width *
                                                              0.2,
                                                          height: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.035,
                                                          child: TextField(
                                                            autocorrect: false,
                                                            enableSuggestions: false,
                                                            controller:
                                                            _remark1_3,
                                                            decoration:
                                                            InputDecoration(
                                                              hintStyle: const TextStyle(
                                                                  color: Color(
                                                                      0xFFCACAC9)),
                                                              border:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                              focusedBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFF626262)),
                                                              ),
                                                              enabledBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Divider(thickness: 1),
                                                  ListTile(
                                                    contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                    title: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            children: [
                                                              Text('1.4',
                                                                  textAlign:
                                                                  TextAlign
                                                                      .center,
                                                                  style:
                                                                  TextStyle(
                                                                    fontSize:
                                                                    16,
                                                                    fontFamily:
                                                                    AppFont
                                                                        .OutfitFont,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                  )),
                                                              Container(
                                                                width: 1,
                                                                height: 50,
                                                                color:
                                                                Colors.grey,
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                    10),
                                                              ),
                                                              Flexible(
                                                                child: Text(
                                                                    'Entire cockpit structure',
                                                                    textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                    softWrap:
                                                                    true,
                                                                    overflow:
                                                                    TextOverflow
                                                                        .visible,
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize:
                                                                      16,
                                                                      fontFamily:
                                                                      AppFont
                                                                          .OutfitFont,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                    )),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(width: 30),
                                                        Checkbox(
                                                          value: _isChecked1_4,
                                                          activeColor: AppColor
                                                              .primaryColor,
                                                          checkColor:
                                                          Colors.white,
                                                          shape:
                                                          RoundedRectangleBorder(
                                                            side: BorderSide(
                                                              color:
                                                              Colors.grey,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                4.0),
                                                          ),
                                                          onChanged:
                                                              (bool? value) {
                                                            setState(() {
                                                              _isChecked1_4 =
                                                                  value ??
                                                                      false;
                                                            });
                                                          },
                                                        ),
                                                        SizedBox(width: 20),
                                                        Container(
                                                          width: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width *
                                                              0.2,
                                                          height: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.035,
                                                          child: TextField(
                                                            autocorrect: false,
                                                            enableSuggestions: false,
                                                            controller:
                                                            _remark1_4,
                                                            decoration:
                                                            InputDecoration(
                                                              hintStyle: const TextStyle(
                                                                  color: Color(
                                                                      0xFFCACAC9)),
                                                              border:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                              focusedBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFF626262)),
                                                              ),
                                                              enabledBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Divider(thickness: 1),
                                                  ListTile(
                                                    contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                    title: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            children: [
                                                              Text('1.5',
                                                                  textAlign:
                                                                  TextAlign
                                                                      .center,
                                                                  style:
                                                                  TextStyle(
                                                                    fontSize:
                                                                    16,
                                                                    fontFamily:
                                                                    AppFont
                                                                        .OutfitFont,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                  )),
                                                              Container(
                                                                width: 1,
                                                                height: 50,
                                                                color:
                                                                Colors.grey,
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                    10),
                                                              ),
                                                              Flexible(
                                                                child: Text(
                                                                    'Life jacket stowage',
                                                                    textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                    softWrap:
                                                                    true,
                                                                    overflow:
                                                                    TextOverflow
                                                                        .visible,
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize:
                                                                      16,
                                                                      fontFamily:
                                                                      AppFont
                                                                          .OutfitFont,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                    )),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(width: 30),
                                                        Checkbox(
                                                          value: _isChecked1_5,
                                                          activeColor: AppColor
                                                              .primaryColor,
                                                          checkColor:
                                                          Colors.white,
                                                          shape:
                                                          RoundedRectangleBorder(
                                                            side: BorderSide(
                                                              color:
                                                              Colors.grey,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                4.0),
                                                          ),
                                                          onChanged:
                                                              (bool? value) {
                                                            setState(() {
                                                              _isChecked1_5 =
                                                                  value ??
                                                                      false;
                                                            });
                                                          },
                                                        ),
                                                        SizedBox(width: 20),
                                                        Container(
                                                          width: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width *
                                                              0.2,
                                                          height: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.035,
                                                          child: TextField(
                                                            autocorrect: false,
                                                            enableSuggestions: false,
                                                            controller:
                                                            _remark1_5,
                                                            decoration:
                                                            InputDecoration(
                                                              hintStyle: const TextStyle(
                                                                  color: Color(
                                                                      0xFFCACAC9)),
                                                              border:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                              focusedBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFF626262)),
                                                              ),
                                                              enabledBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Divider(thickness: 1),
                                                  ListTile(
                                                    contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                    title: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            children: [
                                                              Text('1.6',
                                                                  textAlign:
                                                                  TextAlign
                                                                      .center,
                                                                  style:
                                                                  TextStyle(
                                                                    fontSize:
                                                                    16,
                                                                    fontFamily:
                                                                    AppFont
                                                                        .OutfitFont,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                  )),
                                                              Container(
                                                                width: 1,
                                                                height: 50,
                                                                color:
                                                                Colors.grey,
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                    10),
                                                              ),
                                                              Flexible(
                                                                child: Text(
                                                                    'First aid kit ensure seal intact',
                                                                    textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                    softWrap:
                                                                    true,
                                                                    overflow:
                                                                    TextOverflow
                                                                        .visible,
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize:
                                                                      16,
                                                                      fontFamily:
                                                                      AppFont
                                                                          .OutfitFont,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                    )),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(width: 30),
                                                        Checkbox(
                                                          value: _isChecked1_6,
                                                          activeColor: AppColor
                                                              .primaryColor,
                                                          checkColor:
                                                          Colors.white,
                                                          shape:
                                                          RoundedRectangleBorder(
                                                            side: BorderSide(
                                                              color:
                                                              Colors.grey,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                4.0),
                                                          ),
                                                          onChanged:
                                                              (bool? value) {
                                                            setState(() {
                                                              _isChecked1_6 =
                                                                  value ??
                                                                      false;
                                                            });
                                                          },
                                                        ),
                                                        SizedBox(width: 20),
                                                        Container(
                                                          width: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width *
                                                              0.2,
                                                          height: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.035,
                                                          child: TextField(
                                                            autocorrect: false,
                                                            enableSuggestions: false,
                                                            controller:
                                                            _remark1_6,
                                                            decoration:
                                                            InputDecoration(
                                                              hintStyle: const TextStyle(
                                                                  color: Color(
                                                                      0xFFCACAC9)),
                                                              border:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                              focusedBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFF626262)),
                                                              ),
                                                              enabledBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Divider(thickness: 1),
                                                  ListTile(
                                                    contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                    title: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            children: [
                                                              Text('1.7',
                                                                  textAlign:
                                                                  TextAlign
                                                                      .center,
                                                                  style:
                                                                  TextStyle(
                                                                    fontSize:
                                                                    16,
                                                                    fontFamily:
                                                                    AppFont
                                                                        .OutfitFont,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                  )),
                                                              Container(
                                                                width: 1,
                                                                height: 50,
                                                                color:
                                                                Colors.grey,
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                    10),
                                                              ),
                                                              Flexible(
                                                                child: Text(
                                                                    'Fire Extinguisher mounting case',
                                                                    textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                    softWrap:
                                                                    true,
                                                                    overflow:
                                                                    TextOverflow
                                                                        .visible,
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize:
                                                                      16,
                                                                      fontFamily:
                                                                      AppFont
                                                                          .OutfitFont,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                    )),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(width: 30),
                                                        Checkbox(
                                                          value: _isChecked1_7,
                                                          activeColor: AppColor
                                                              .primaryColor,
                                                          checkColor:
                                                          Colors.white,
                                                          shape:
                                                          RoundedRectangleBorder(
                                                            side: BorderSide(
                                                              color:
                                                              Colors.grey,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                4.0),
                                                          ),
                                                          onChanged:
                                                              (bool? value) {
                                                            setState(() {
                                                              _isChecked1_7 =
                                                                  value ??
                                                                      false;
                                                            });
                                                          },
                                                        ),
                                                        SizedBox(width: 20),
                                                        Container(
                                                          width: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width *
                                                              0.2,
                                                          height: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.035,
                                                          child: TextField(
                                                            autocorrect: false,
                                                            enableSuggestions: false,
                                                            controller:
                                                            _remark1_7,
                                                            decoration:
                                                            InputDecoration(
                                                              hintStyle: const TextStyle(
                                                                  color: Color(
                                                                      0xFFCACAC9)),
                                                              border:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                              focusedBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFF626262)),
                                                              ),
                                                              enabledBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                            ),
                                                          ),
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
                                      Card(
                                        elevation: 0,
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          side: BorderSide(
                                            color: Colors.grey,
                                            width: 0.5,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text('2   Main Cabin',
                                                  style: TextStyle(
                                                    fontSize: 21,
                                                    fontFamily:
                                                    AppFont.OutfitFont,
                                                    color:
                                                    AppColor.primaryColor,
                                                    fontWeight: FontWeight.w800,
                                                  )),
                                              Divider(thickness: 1),
                                              Column(
                                                children: [
                                                  ListTile(
                                                    contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                    title: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            children: [
                                                              Text('2.1',
                                                                  textAlign:
                                                                  TextAlign
                                                                      .center,
                                                                  style:
                                                                  TextStyle(
                                                                    fontSize:
                                                                    16,
                                                                    fontFamily:
                                                                    AppFont
                                                                        .OutfitFont,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                  )),
                                                              Container(
                                                                width: 1,
                                                                height: 50,
                                                                color:
                                                                Colors.grey,
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                    10),
                                                              ),
                                                              Flexible(
                                                                child: Text(
                                                                    'Seats (pouches, cushions and underside of seats)',
                                                                    textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                    softWrap:
                                                                    true,
                                                                    overflow:
                                                                    TextOverflow
                                                                        .visible,
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize:
                                                                      16,
                                                                      fontFamily:
                                                                      AppFont
                                                                          .OutfitFont,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                    )),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(width: 30),
                                                        Checkbox(
                                                          value: _isChecked2_1,
                                                          activeColor: AppColor
                                                              .primaryColor,
                                                          checkColor:
                                                          Colors.white,
                                                          shape:
                                                          RoundedRectangleBorder(
                                                            side: BorderSide(
                                                              color:
                                                              Colors.grey,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                4.0),
                                                          ),
                                                          onChanged:
                                                              (bool? value) {
                                                            setState(() {
                                                              _isChecked2_1 =
                                                                  value ??
                                                                      false;
                                                            });
                                                          },
                                                        ),
                                                        SizedBox(width: 20),
                                                        Container(
                                                          width: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width *
                                                              0.2,
                                                          height: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.035,
                                                          child: TextField(
                                                            autocorrect: false,
                                                            enableSuggestions: false,
                                                            controller:
                                                            _remark2_1,
                                                            decoration:
                                                            InputDecoration(
                                                              hintStyle: const TextStyle(
                                                                  color: Color(
                                                                      0xFFCACAC9)),
                                                              border:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                              focusedBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFF626262)),
                                                              ),
                                                              enabledBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Divider(thickness: 1),
                                                  ListTile(
                                                    contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                    title: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            children: [
                                                              Text('2.2',
                                                                  textAlign:
                                                                  TextAlign
                                                                      .center,
                                                                  style:
                                                                  TextStyle(
                                                                    fontSize:
                                                                    16,
                                                                    fontFamily:
                                                                    AppFont
                                                                        .OutfitFont,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                  )),
                                                              Container(
                                                                width: 1,
                                                                height: 50,
                                                                color:
                                                                Colors.grey,
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                    10),
                                                              ),
                                                              Flexible(
                                                                child: Text(
                                                                    'Floor and shelves located under the floor',
                                                                    textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                    softWrap:
                                                                    true,
                                                                    overflow:
                                                                    TextOverflow
                                                                        .visible,
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize:
                                                                      16,
                                                                      fontFamily:
                                                                      AppFont
                                                                          .OutfitFont,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                    )),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(width: 30),
                                                        Checkbox(
                                                          value: _isChecked2_2,
                                                          activeColor: AppColor
                                                              .primaryColor,
                                                          checkColor:
                                                          Colors.white,
                                                          shape:
                                                          RoundedRectangleBorder(
                                                            side: BorderSide(
                                                              color:
                                                              Colors.grey,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                4.0),
                                                          ),
                                                          onChanged:
                                                              (bool? value) {
                                                            setState(() {
                                                              _isChecked2_2 =
                                                                  value ??
                                                                      false;
                                                            });
                                                          },
                                                        ),
                                                        SizedBox(width: 20),
                                                        Container(
                                                          width: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width *
                                                              0.2,
                                                          height: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.035,
                                                          child: TextField(
                                                            autocorrect: false,
                                                            enableSuggestions: false,
                                                            controller:
                                                            _remark2_2,
                                                            decoration:
                                                            InputDecoration(
                                                              hintStyle: const TextStyle(
                                                                  color: Color(
                                                                      0xFFCACAC9)),
                                                              border:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                              focusedBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFF626262)),
                                                              ),
                                                              enabledBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Divider(thickness: 1),
                                                  ListTile(
                                                    contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                    title: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            children: [
                                                              Text('2.3',
                                                                  textAlign:
                                                                  TextAlign
                                                                      .center,
                                                                  style:
                                                                  TextStyle(
                                                                    fontSize:
                                                                    16,
                                                                    fontFamily:
                                                                    AppFont
                                                                        .OutfitFont,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                  )),
                                                              Container(
                                                                width: 1,
                                                                height: 50,
                                                                color:
                                                                Colors.grey,
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                    10),
                                                              ),
                                                              Flexible(
                                                                child: Text(
                                                                    'Cabin internal structure including side walls, ceiling, doors pouches and light recesses',
                                                                    textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                    softWrap:
                                                                    true,
                                                                    overflow:
                                                                    TextOverflow
                                                                        .visible,
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize:
                                                                      16,
                                                                      fontFamily:
                                                                      AppFont
                                                                          .OutfitFont,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                    )),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(width: 30),
                                                        Checkbox(
                                                          value: _isChecked2_3,
                                                          activeColor: AppColor
                                                              .primaryColor,
                                                          checkColor:
                                                          Colors.white,
                                                          shape:
                                                          RoundedRectangleBorder(
                                                            side: BorderSide(
                                                              color:
                                                              Colors.grey,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                4.0),
                                                          ),
                                                          onChanged:
                                                              (bool? value) {
                                                            setState(() {
                                                              _isChecked2_3 =
                                                                  value ??
                                                                      false;
                                                            });
                                                          },
                                                        ),
                                                        SizedBox(width: 20),
                                                        Container(
                                                          width: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width *
                                                              0.2,
                                                          height: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.035,
                                                          child: TextField(
                                                            autocorrect: false,
                                                            enableSuggestions: false,
                                                            controller:
                                                            _remark2_3,
                                                            decoration:
                                                            InputDecoration(
                                                              hintStyle: const TextStyle(
                                                                  color: Color(
                                                                      0xFFCACAC9)),
                                                              border:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                              focusedBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFF626262)),
                                                              ),
                                                              enabledBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Divider(thickness: 1),
                                                  ListTile(
                                                    contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                    title: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            children: [
                                                              Text('2.4',
                                                                  textAlign:
                                                                  TextAlign
                                                                      .center,
                                                                  style:
                                                                  TextStyle(
                                                                    fontSize:
                                                                    16,
                                                                    fontFamily:
                                                                    AppFont
                                                                        .OutfitFont,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                  )),
                                                              Container(
                                                                width: 1,
                                                                height: 50,
                                                                color:
                                                                Colors.grey,
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                    10),
                                                              ),
                                                              Flexible(
                                                                child: Text(
                                                                    'Life jacket stowage pockets',
                                                                    textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                    softWrap:
                                                                    true,
                                                                    overflow:
                                                                    TextOverflow
                                                                        .visible,
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize:
                                                                      16,
                                                                      fontFamily:
                                                                      AppFont
                                                                          .OutfitFont,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                    )),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(width: 30),
                                                        Checkbox(
                                                          value: _isChecked2_4,
                                                          activeColor: AppColor
                                                              .primaryColor,
                                                          checkColor:
                                                          Colors.white,
                                                          shape:
                                                          RoundedRectangleBorder(
                                                            side: BorderSide(
                                                              color:
                                                              Colors.grey,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                4.0),
                                                          ),
                                                          onChanged:
                                                              (bool? value) {
                                                            setState(() {
                                                              _isChecked2_4 =
                                                                  value ??
                                                                      false;
                                                            });
                                                          },
                                                        ),
                                                        SizedBox(width: 20),
                                                        Container(
                                                          width: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width *
                                                              0.2,
                                                          height: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.035,
                                                          child: TextField(
                                                            autocorrect: false,
                                                            enableSuggestions: false,
                                                            controller:
                                                            _remark2_4,
                                                            decoration:
                                                            InputDecoration(
                                                              hintStyle: const TextStyle(
                                                                  color: Color(
                                                                      0xFFCACAC9)),
                                                              border:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                              focusedBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFF626262)),
                                                              ),
                                                              enabledBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                            ),
                                                          ),
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
                                      Card(
                                        elevation: 0,
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          side: BorderSide(
                                            color: Colors.grey,
                                            width: 0.5,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  '3   Aircraft Exterior and Cargo Compartments',
                                                  style: TextStyle(
                                                    fontSize: 21,
                                                    fontFamily:
                                                    AppFont.OutfitFont,
                                                    color:
                                                    AppColor.primaryColor,
                                                    fontWeight: FontWeight.w800,
                                                  )),
                                              Divider(thickness: 1),
                                              Column(
                                                children: [
                                                  ListTile(
                                                    contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                    title: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            children: [
                                                              Text('3.1',
                                                                  textAlign:
                                                                  TextAlign
                                                                      .center,
                                                                  style:
                                                                  TextStyle(
                                                                    fontSize:
                                                                    16,
                                                                    fontFamily:
                                                                    AppFont
                                                                        .OutfitFont,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                  )),
                                                              Container(
                                                                width: 1,
                                                                height: 50,
                                                                color:
                                                                Colors.grey,
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                    10),
                                                              ),
                                                              Flexible(
                                                                child: Text(
                                                                    'Fuselage areas behind the following doors and openings:',
                                                                    textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                    softWrap:
                                                                    true,
                                                                    overflow:
                                                                    TextOverflow
                                                                        .visible,
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize:
                                                                      16,
                                                                      fontFamily:
                                                                      AppFont
                                                                          .OutfitFont,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                    )),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(width: 30),
                                                        Checkbox(
                                                          value: _isChecked3_1,
                                                          activeColor: AppColor
                                                              .primaryColor,
                                                          checkColor:
                                                          Colors.white,
                                                          shape:
                                                          RoundedRectangleBorder(
                                                            side: BorderSide(
                                                              color:
                                                              Colors.grey,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                4.0),
                                                          ),
                                                          onChanged:
                                                              (bool? value) {
                                                            setState(() {
                                                              _isChecked3_1 =
                                                                  value ??
                                                                      false;
                                                            });
                                                          },
                                                        ),
                                                        SizedBox(width: 20),
                                                        Container(
                                                          width: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width *
                                                              0.2,
                                                          height: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.035,
                                                          child: TextField(
                                                            autocorrect: false,
                                                            enableSuggestions: false,
                                                            controller:
                                                            _remark3_1,
                                                            decoration:
                                                            InputDecoration(
                                                              hintStyle: const TextStyle(
                                                                  color: Color(
                                                                      0xFFCACAC9)),
                                                              border:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                              focusedBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFF626262)),
                                                              ),
                                                              enabledBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Divider(thickness: 1),
                                                  ListTile(
                                                    contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                    title: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            children: [
                                                              Text('3.1 a',
                                                                  textAlign:
                                                                  TextAlign
                                                                      .center,
                                                                  style:
                                                                  TextStyle(
                                                                    fontSize:
                                                                    16,
                                                                    fontFamily:
                                                                    AppFont
                                                                        .OutfitFont,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                  )),
                                                              Container(
                                                                width: 1,
                                                                height: 50,
                                                                color:
                                                                Colors.grey,
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                    10),
                                                              ),
                                                              Flexible(
                                                                child: Text(
                                                                    'R/H fuselage side compartment doors',
                                                                    textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                    softWrap:
                                                                    true,
                                                                    overflow:
                                                                    TextOverflow
                                                                        .visible,
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize:
                                                                      16,
                                                                      fontFamily:
                                                                      AppFont
                                                                          .OutfitFont,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                    )),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(width: 30),
                                                        Checkbox(
                                                          value: _isChecked3_1a,
                                                          activeColor: AppColor
                                                              .primaryColor,
                                                          checkColor:
                                                          Colors.white,
                                                          shape:
                                                          RoundedRectangleBorder(
                                                            side: BorderSide(
                                                              color:
                                                              Colors.grey,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                4.0),
                                                          ),
                                                          onChanged:
                                                              (bool? value) {
                                                            setState(() {
                                                              _isChecked3_1a =
                                                                  value ??
                                                                      false;
                                                            });
                                                          },
                                                        ),
                                                        SizedBox(width: 20),
                                                        Container(
                                                          width: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width *
                                                              0.2,
                                                          height: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.035,
                                                          child: TextField(
                                                            autocorrect: false,
                                                            enableSuggestions: false,
                                                            controller:
                                                            _remark3_1a,
                                                            decoration:
                                                            InputDecoration(
                                                              hintStyle: const TextStyle(
                                                                  color: Color(
                                                                      0xFFCACAC9)),
                                                              border:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                              focusedBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFF626262)),
                                                              ),
                                                              enabledBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Divider(thickness: 1),
                                                  ListTile(
                                                    contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                    title: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            children: [
                                                              Text('3.1 b',
                                                                  textAlign:
                                                                  TextAlign
                                                                      .center,
                                                                  style:
                                                                  TextStyle(
                                                                    fontSize:
                                                                    16,
                                                                    fontFamily:
                                                                    AppFont
                                                                        .OutfitFont,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                  )),
                                                              Container(
                                                                width: 1,
                                                                height: 50,
                                                                color:
                                                                Colors.grey,
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                    10),
                                                              ),
                                                              Flexible(
                                                                child: Text(
                                                                    'L/H fuselage side compartment doors',
                                                                    textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                    softWrap:
                                                                    true,
                                                                    overflow:
                                                                    TextOverflow
                                                                        .visible,
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize:
                                                                      16,
                                                                      fontFamily:
                                                                      AppFont
                                                                          .OutfitFont,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                    )),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(width: 30),
                                                        Checkbox(
                                                          value: _isChecked3_1b,
                                                          activeColor: AppColor
                                                              .primaryColor,
                                                          checkColor:
                                                          Colors.white,
                                                          shape:
                                                          RoundedRectangleBorder(
                                                            side: BorderSide(
                                                              color:
                                                              Colors.grey,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                4.0),
                                                          ),
                                                          onChanged:
                                                              (bool? value) {
                                                            setState(() {
                                                              _isChecked3_1b =
                                                                  value ??
                                                                      false;
                                                            });
                                                          },
                                                        ),
                                                        SizedBox(width: 20),
                                                        Container(
                                                          width: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width *
                                                              0.2,
                                                          height: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.035,
                                                          child: TextField(
                                                            autocorrect: false,
                                                            enableSuggestions: false,
                                                            controller:
                                                            _remark3_1b,
                                                            decoration:
                                                            InputDecoration(
                                                              hintStyle: const TextStyle(
                                                                  color: Color(
                                                                      0xFFCACAC9)),
                                                              border:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                              focusedBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFF626262)),
                                                              ),
                                                              enabledBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Divider(thickness: 1),
                                                  ListTile(
                                                    contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                    title: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            children: [
                                                              Text('3.2',
                                                                  textAlign:
                                                                  TextAlign
                                                                      .center,
                                                                  style:
                                                                  TextStyle(
                                                                    fontSize:
                                                                    16,
                                                                    fontFamily:
                                                                    AppFont
                                                                        .OutfitFont,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                  )),
                                                              Container(
                                                                width: 1,
                                                                height: 50,
                                                                color:
                                                                Colors.grey,
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                    10),
                                                              ),
                                                              Flexible(
                                                                child: Text(
                                                                    'Ground power access door',
                                                                    textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                    softWrap:
                                                                    true,
                                                                    overflow:
                                                                    TextOverflow
                                                                        .visible,
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize:
                                                                      16,
                                                                      fontFamily:
                                                                      AppFont
                                                                          .OutfitFont,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                    )),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(width: 30),
                                                        Checkbox(
                                                          value: _isChecked3_2,
                                                          activeColor: AppColor
                                                              .primaryColor,
                                                          checkColor:
                                                          Colors.white,
                                                          shape:
                                                          RoundedRectangleBorder(
                                                            side: BorderSide(
                                                              color:
                                                              Colors.grey,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                4.0),
                                                          ),
                                                          onChanged:
                                                              (bool? value) {
                                                            setState(() {
                                                              _isChecked3_2 =
                                                                  value ??
                                                                      false;
                                                            });
                                                          },
                                                        ),
                                                        SizedBox(width: 20),
                                                        Container(
                                                          width: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width *
                                                              0.2,
                                                          height: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.035,
                                                          child: TextField(
                                                            autocorrect: false,
                                                            enableSuggestions: false,
                                                            controller:
                                                            _remark3_2,
                                                            decoration:
                                                            InputDecoration(
                                                              hintStyle: const TextStyle(
                                                                  color: Color(
                                                                      0xFFCACAC9)),
                                                              border:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                              focusedBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFF626262)),
                                                              ),
                                                              enabledBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Divider(thickness: 1),
                                                  ListTile(
                                                    contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                    title: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            children: [
                                                              Text('3.3',
                                                                  textAlign:
                                                                  TextAlign
                                                                      .center,
                                                                  style:
                                                                  TextStyle(
                                                                    fontSize:
                                                                    16,
                                                                    fontFamily:
                                                                    AppFont
                                                                        .OutfitFont,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                  )),
                                                              Container(
                                                                width: 1,
                                                                height: 50,
                                                                color:
                                                                Colors.grey,
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                    10),
                                                              ),
                                                              Flexible(
                                                                child: Text(
                                                                    'Tail rotor drive shaft and gear box inspection panels',
                                                                    textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                    softWrap:
                                                                    true,
                                                                    overflow:
                                                                    TextOverflow
                                                                        .visible,
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize:
                                                                      16,
                                                                      fontFamily:
                                                                      AppFont
                                                                          .OutfitFont,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                    )),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(width: 30),
                                                        Checkbox(
                                                          value: _isChecked3_3,
                                                          activeColor: AppColor
                                                              .primaryColor,
                                                          checkColor:
                                                          Colors.white,
                                                          shape:
                                                          RoundedRectangleBorder(
                                                            side: BorderSide(
                                                              color:
                                                              Colors.grey,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                4.0),
                                                          ),
                                                          onChanged:
                                                              (bool? value) {
                                                            setState(() {
                                                              _isChecked3_3 =
                                                                  value ??
                                                                      false;
                                                            });
                                                          },
                                                        ),
                                                        SizedBox(width: 20),
                                                        Container(
                                                          width: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width *
                                                              0.2,
                                                          height: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.035,
                                                          child: TextField(
                                                            autocorrect: false,
                                                            enableSuggestions: false,
                                                            controller:
                                                            _remark3_3,
                                                            decoration:
                                                            InputDecoration(
                                                              hintStyle: const TextStyle(
                                                                  color: Color(
                                                                      0xFFCACAC9)),
                                                              border:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                              focusedBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFF626262)),
                                                              ),
                                                              enabledBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Divider(thickness: 1),
                                                  ListTile(
                                                    contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                    title: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            children: [
                                                              Text('3.4',
                                                                  textAlign:
                                                                  TextAlign
                                                                      .center,
                                                                  style:
                                                                  TextStyle(
                                                                    fontSize:
                                                                    16,
                                                                    fontFamily:
                                                                    AppFont
                                                                        .OutfitFont,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                  )),
                                                              Container(
                                                                width: 1,
                                                                height: 50,
                                                                color:
                                                                Colors.grey,
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                    10),
                                                              ),
                                                              Flexible(
                                                                child: Text(
                                                                    'Tail boom baggage compartment',
                                                                    textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                    softWrap:
                                                                    true,
                                                                    overflow:
                                                                    TextOverflow
                                                                        .visible,
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize:
                                                                      16,
                                                                      fontFamily:
                                                                      AppFont
                                                                          .OutfitFont,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                    )),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(width: 30),
                                                        Checkbox(
                                                          value: _isChecked3_4,
                                                          activeColor: AppColor
                                                              .primaryColor,
                                                          checkColor:
                                                          Colors.white,
                                                          shape:
                                                          RoundedRectangleBorder(
                                                            side: BorderSide(
                                                              color:
                                                              Colors.grey,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                4.0),
                                                          ),
                                                          onChanged:
                                                              (bool? value) {
                                                            setState(() {
                                                              _isChecked3_4 =
                                                                  value ??
                                                                      false;
                                                            });
                                                          },
                                                        ),
                                                        SizedBox(width: 20),
                                                        Container(
                                                          width: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width *
                                                              0.2,
                                                          height: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.035,
                                                          child: TextField(
                                                            autocorrect: false,
                                                            enableSuggestions: false,
                                                            controller:
                                                            _remark3_4,
                                                            decoration:
                                                            InputDecoration(
                                                              hintStyle: const TextStyle(
                                                                  color: Color(
                                                                      0xFFCACAC9)),
                                                              border:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                              focusedBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFF626262)),
                                                              ),
                                                              enabledBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Divider(thickness: 1),
                                                  ListTile(
                                                    contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                    title: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            children: [
                                                              Text('3.5',
                                                                  textAlign:
                                                                  TextAlign
                                                                      .center,
                                                                  style:
                                                                  TextStyle(
                                                                    fontSize:
                                                                    16,
                                                                    fontFamily:
                                                                    AppFont
                                                                        .OutfitFont,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                  )),
                                                              Container(
                                                                width: 1,
                                                                height: 50,
                                                                color:
                                                                Colors.grey,
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                    10),
                                                              ),
                                                              Flexible(
                                                                child: Text(
                                                                    'Fuselage maintenance steps and handholds',
                                                                    textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                    softWrap:
                                                                    true,
                                                                    overflow:
                                                                    TextOverflow
                                                                        .visible,
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize:
                                                                      16,
                                                                      fontFamily:
                                                                      AppFont
                                                                          .OutfitFont,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                    )),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(width: 30),
                                                        Checkbox(
                                                          value: _isChecked3_5,
                                                          activeColor: AppColor
                                                              .primaryColor,
                                                          checkColor:
                                                          Colors.white,
                                                          shape:
                                                          RoundedRectangleBorder(
                                                            side: BorderSide(
                                                              color:
                                                              Colors.grey,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                4.0),
                                                          ),
                                                          onChanged:
                                                              (bool? value) {
                                                            setState(() {
                                                              _isChecked3_5 =
                                                                  value ??
                                                                      false;
                                                            });
                                                          },
                                                        ),
                                                        SizedBox(width: 20),
                                                        Container(
                                                          width: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width *
                                                              0.2,
                                                          height: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.035,
                                                          child: TextField(
                                                            autocorrect: false,
                                                            enableSuggestions: false,
                                                            controller:
                                                            _remark3_5,
                                                            decoration:
                                                            InputDecoration(
                                                              hintStyle: const TextStyle(
                                                                  color: Color(
                                                                      0xFFCACAC9)),
                                                              border:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                              focusedBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFF626262)),
                                                              ),
                                                              enabledBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                            ),
                                                          ),
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
                                      Card(
                                        elevation: 0,
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          side: BorderSide(
                                            color: Colors.grey,
                                            width: 0.5,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text('4   Landing Gear',
                                                  style: TextStyle(
                                                    fontSize: 21,
                                                    fontFamily:
                                                    AppFont.OutfitFont,
                                                    color:
                                                    AppColor.primaryColor,
                                                    fontWeight: FontWeight.w800,
                                                  )),
                                              Divider(thickness: 1),
                                              Column(
                                                children: [
                                                  ListTile(
                                                    contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                    title: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            children: [
                                                              Text('4.1',
                                                                  textAlign:
                                                                  TextAlign
                                                                      .center,
                                                                  style:
                                                                  TextStyle(
                                                                    fontSize:
                                                                    16,
                                                                    fontFamily:
                                                                    AppFont
                                                                        .OutfitFont,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                  )),
                                                              Container(
                                                                width: 1,
                                                                height: 50,
                                                                color:
                                                                Colors.grey,
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                    10),
                                                              ),
                                                              Flexible(
                                                                child: Text(
                                                                    'Main Landing Gear skids and floatation bags',
                                                                    textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                    softWrap:
                                                                    true,
                                                                    overflow:
                                                                    TextOverflow
                                                                        .visible,
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize:
                                                                      16,
                                                                      fontFamily:
                                                                      AppFont
                                                                          .OutfitFont,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                    )),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(width: 30),
                                                        Checkbox(
                                                          value: _isChecked4_1,
                                                          activeColor: AppColor
                                                              .primaryColor,
                                                          checkColor:
                                                          Colors.white,
                                                          shape:
                                                          RoundedRectangleBorder(
                                                            side: BorderSide(
                                                              color:
                                                              Colors.grey,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                4.0),
                                                          ),
                                                          onChanged:
                                                              (bool? value) {
                                                            setState(() {
                                                              _isChecked4_1 =
                                                                  value ??
                                                                      false;
                                                            });
                                                          },
                                                        ),
                                                        SizedBox(width: 20),
                                                        Container(
                                                          width: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width *
                                                              0.2,
                                                          height: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.035,
                                                          child: TextField(
                                                            autocorrect: false,
                                                            enableSuggestions: false,
                                                            controller:
                                                            _remark4_1,
                                                            decoration:
                                                            InputDecoration(
                                                              hintStyle: const TextStyle(
                                                                  color: Color(
                                                                      0xFFCACAC9)),
                                                              border:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                              focusedBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFF626262)),
                                                              ),
                                                              enabledBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Divider(thickness: 1),
                                                  ListTile(
                                                    contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                    title: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            children: [
                                                              Text('4.2',
                                                                  textAlign:
                                                                  TextAlign
                                                                      .center,
                                                                  style:
                                                                  TextStyle(
                                                                    fontSize:
                                                                    16,
                                                                    fontFamily:
                                                                    AppFont
                                                                        .OutfitFont,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                  )),
                                                              Container(
                                                                width: 1,
                                                                height: 50,
                                                                color:
                                                                Colors.grey,
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                    10),
                                                              ),
                                                              Flexible(
                                                                child: Text(
                                                                    'Flotation gear inflation bottle',
                                                                    textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                    softWrap:
                                                                    true,
                                                                    overflow:
                                                                    TextOverflow
                                                                        .visible,
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize:
                                                                      16,
                                                                      fontFamily:
                                                                      AppFont
                                                                          .OutfitFont,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                    )),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(width: 30),
                                                        Checkbox(
                                                          value: _isChecked4_2,
                                                          activeColor: AppColor
                                                              .primaryColor,
                                                          checkColor:
                                                          Colors.white,
                                                          shape:
                                                          RoundedRectangleBorder(
                                                            side: BorderSide(
                                                              color:
                                                              Colors.grey,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                4.0),
                                                          ),
                                                          onChanged:
                                                              (bool? value) {
                                                            setState(() {
                                                              _isChecked4_2 =
                                                                  value ??
                                                                      false;
                                                            });
                                                          },
                                                        ),
                                                        SizedBox(width: 20),
                                                        Container(
                                                          width: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width *
                                                              0.2,
                                                          height: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.035,
                                                          child: TextField(
                                                            autocorrect: false,
                                                            enableSuggestions: false,
                                                            controller:
                                                            _remark4_2,
                                                            decoration:
                                                            InputDecoration(
                                                              hintStyle: const TextStyle(
                                                                  color: Color(
                                                                      0xFFCACAC9)),
                                                              border:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                              focusedBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFF626262)),
                                                              ),
                                                              enabledBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                            ),
                                                          ),
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
                                      Card(
                                        elevation: 0,
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          side: BorderSide(
                                            color: Colors.grey,
                                            width: 0.5,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  '5   Engine, Transmission and Rotor Head',
                                                  style: TextStyle(
                                                    fontSize: 21,
                                                    fontFamily:
                                                    AppFont.OutfitFont,
                                                    color:
                                                    AppColor.primaryColor,
                                                    fontWeight: FontWeight.w800,
                                                  )),
                                              Divider(thickness: 1),
                                              Column(
                                                children: [
                                                  ListTile(
                                                    contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                    title: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            children: [
                                                              Text('5.1',
                                                                  textAlign:
                                                                  TextAlign
                                                                      .center,
                                                                  style:
                                                                  TextStyle(
                                                                    fontSize:
                                                                    16,
                                                                    fontFamily:
                                                                    AppFont
                                                                        .OutfitFont,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                  )),
                                                              Container(
                                                                width: 1,
                                                                height: 50,
                                                                color:
                                                                Colors.grey,
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                    10),
                                                              ),
                                                              Flexible(
                                                                child: Text(
                                                                    'LH and RH Engine air intakes',
                                                                    textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                    softWrap:
                                                                    true,
                                                                    overflow:
                                                                    TextOverflow
                                                                        .visible,
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize:
                                                                      16,
                                                                      fontFamily:
                                                                      AppFont
                                                                          .OutfitFont,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                    )),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(width: 30),
                                                        Checkbox(
                                                          value: _isChecked5_1,
                                                          activeColor: AppColor
                                                              .primaryColor,
                                                          checkColor:
                                                          Colors.white,
                                                          shape:
                                                          RoundedRectangleBorder(
                                                            side: BorderSide(
                                                              color:
                                                              Colors.grey,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                4.0),
                                                          ),
                                                          onChanged:
                                                              (bool? value) {
                                                            setState(() {
                                                              _isChecked5_1 =
                                                                  value ??
                                                                      false;
                                                            });
                                                          },
                                                        ),
                                                        SizedBox(width: 20),
                                                        Container(
                                                          width: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width *
                                                              0.2,
                                                          height: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.035,
                                                          child: TextField(
                                                            autocorrect: false,
                                                            enableSuggestions: false,
                                                            controller:
                                                            _remark5_1,
                                                            decoration:
                                                            InputDecoration(
                                                              hintStyle: const TextStyle(
                                                                  color: Color(
                                                                      0xFFCACAC9)),
                                                              border:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                              focusedBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFF626262)),
                                                              ),
                                                              enabledBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Divider(thickness: 1),
                                                  ListTile(
                                                    contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                    title: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            children: [
                                                              Text('5.2',
                                                                  textAlign:
                                                                  TextAlign
                                                                      .center,
                                                                  style:
                                                                  TextStyle(
                                                                    fontSize:
                                                                    16,
                                                                    fontFamily:
                                                                    AppFont
                                                                        .OutfitFont,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                  )),
                                                              Container(
                                                                width: 1,
                                                                height: 50,
                                                                color:
                                                                Colors.grey,
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                    10),
                                                              ),
                                                              Flexible(
                                                                child: Text(
                                                                    'LH and RH Engine exhausts',
                                                                    textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                    softWrap:
                                                                    true,
                                                                    overflow:
                                                                    TextOverflow
                                                                        .visible,
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize:
                                                                      16,
                                                                      fontFamily:
                                                                      AppFont
                                                                          .OutfitFont,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                    )),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(width: 30),
                                                        Checkbox(
                                                          value: _isChecked5_2,
                                                          activeColor: AppColor
                                                              .primaryColor,
                                                          checkColor:
                                                          Colors.white,
                                                          shape:
                                                          RoundedRectangleBorder(
                                                            side: BorderSide(
                                                              color:
                                                              Colors.grey,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                4.0),
                                                          ),
                                                          onChanged:
                                                              (bool? value) {
                                                            setState(() {
                                                              _isChecked5_2 =
                                                                  value ??
                                                                      false;
                                                            });
                                                          },
                                                        ),
                                                        SizedBox(width: 20),
                                                        Container(
                                                          width: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width *
                                                              0.2,
                                                          height: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.035,
                                                          child: TextField(
                                                            autocorrect: false,
                                                            enableSuggestions: false,
                                                            controller:
                                                            _remark5_2,
                                                            decoration:
                                                            InputDecoration(
                                                              hintStyle: const TextStyle(
                                                                  color: Color(
                                                                      0xFFCACAC9)),
                                                              border:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                              focusedBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFF626262)),
                                                              ),
                                                              enabledBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Divider(thickness: 1),
                                                  ListTile(
                                                    contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                    title: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            children: [
                                                              Text('5.3',
                                                                  textAlign:
                                                                  TextAlign
                                                                      .center,
                                                                  style:
                                                                  TextStyle(
                                                                    fontSize:
                                                                    16,
                                                                    fontFamily:
                                                                    AppFont
                                                                        .OutfitFont,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                  )),
                                                              Container(
                                                                width: 1,
                                                                height: 50,
                                                                color:
                                                                Colors.grey,
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                    10),
                                                              ),
                                                              Flexible(
                                                                child: Text(
                                                                    'LH and RH Engine deck and entire engine installations',
                                                                    textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                    softWrap:
                                                                    true,
                                                                    overflow:
                                                                    TextOverflow
                                                                        .visible,
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize:
                                                                      16,
                                                                      fontFamily:
                                                                      AppFont
                                                                          .OutfitFont,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                    )),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(width: 30),
                                                        Checkbox(
                                                          value: _isChecked5_3,
                                                          activeColor: AppColor
                                                              .primaryColor,
                                                          checkColor:
                                                          Colors.white,
                                                          shape:
                                                          RoundedRectangleBorder(
                                                            side: BorderSide(
                                                              color:
                                                              Colors.grey,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                4.0),
                                                          ),
                                                          onChanged:
                                                              (bool? value) {
                                                            setState(() {
                                                              _isChecked5_3 =
                                                                  value ??
                                                                      false;
                                                            });
                                                          },
                                                        ),
                                                        SizedBox(width: 20),
                                                        Container(
                                                          width: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width *
                                                              0.2,
                                                          height: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.035,
                                                          child: TextField(
                                                            autocorrect: false,
                                                            enableSuggestions: false,
                                                            controller:
                                                            _remark5_3,
                                                            decoration:
                                                            InputDecoration(
                                                              hintStyle: const TextStyle(
                                                                  color: Color(
                                                                      0xFFCACAC9)),
                                                              border:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                              focusedBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFF626262)),
                                                              ),
                                                              enabledBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Divider(thickness: 1),
                                                  ListTile(
                                                    contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                    title: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            children: [
                                                              Text('5.4',
                                                                  textAlign:
                                                                  TextAlign
                                                                      .center,
                                                                  style:
                                                                  TextStyle(
                                                                    fontSize:
                                                                    16,
                                                                    fontFamily:
                                                                    AppFont
                                                                        .OutfitFont,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                  )),
                                                              Container(
                                                                width: 1,
                                                                height: 50,
                                                                color:
                                                                Colors.grey,
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                    10),
                                                              ),
                                                              Flexible(
                                                                child: Text(
                                                                    'Transmission deck and entire transmission installation',
                                                                    textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                    softWrap:
                                                                    true,
                                                                    overflow:
                                                                    TextOverflow
                                                                        .visible,
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize:
                                                                      16,
                                                                      fontFamily:
                                                                      AppFont
                                                                          .OutfitFont,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                    )),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(width: 30),
                                                        Checkbox(
                                                          value: _isChecked5_4,
                                                          activeColor: AppColor
                                                              .primaryColor,
                                                          checkColor:
                                                          Colors.white,
                                                          shape:
                                                          RoundedRectangleBorder(
                                                            side: BorderSide(
                                                              color:
                                                              Colors.grey,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                4.0),
                                                          ),
                                                          onChanged:
                                                              (bool? value) {
                                                            setState(() {
                                                              _isChecked5_4 =
                                                                  value ??
                                                                      false;
                                                            });
                                                          },
                                                        ),
                                                        SizedBox(width: 20),
                                                        Container(
                                                          width: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width *
                                                              0.2,
                                                          height: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.035,
                                                          child: TextField(
                                                            autocorrect: false,
                                                            enableSuggestions: false,
                                                            controller:
                                                            _remark5_4,
                                                            decoration:
                                                            InputDecoration(
                                                              hintStyle: const TextStyle(
                                                                  color: Color(
                                                                      0xFFCACAC9)),
                                                              border:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                              focusedBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFF626262)),
                                                              ),
                                                              enabledBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Divider(thickness: 1),
                                                  ListTile(
                                                    contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                    title: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            children: [
                                                              Text('5.5',
                                                                  textAlign:
                                                                  TextAlign
                                                                      .center,
                                                                  style:
                                                                  TextStyle(
                                                                    fontSize:
                                                                    16,
                                                                    fontFamily:
                                                                    AppFont
                                                                        .OutfitFont,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                  )),
                                                              Container(
                                                                width: 1,
                                                                height: 50,
                                                                color:
                                                                Colors.grey,
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                    10),
                                                              ),
                                                              Flexible(
                                                                child: Text(
                                                                    'Swashplate and support area',
                                                                    textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                    softWrap:
                                                                    true,
                                                                    overflow:
                                                                    TextOverflow
                                                                        .visible,
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize:
                                                                      16,
                                                                      fontFamily:
                                                                      AppFont
                                                                          .OutfitFont,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                    )),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(width: 30),
                                                        Checkbox(
                                                          value: _isChecked5_5,
                                                          activeColor: AppColor
                                                              .primaryColor,
                                                          checkColor:
                                                          Colors.white,
                                                          shape:
                                                          RoundedRectangleBorder(
                                                            side: BorderSide(
                                                              color:
                                                              Colors.grey,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                4.0),
                                                          ),
                                                          onChanged:
                                                              (bool? value) {
                                                            setState(() {
                                                              _isChecked5_5 =
                                                                  value ??
                                                                      false;
                                                            });
                                                          },
                                                        ),
                                                        SizedBox(width: 20),
                                                        Container(
                                                          width: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width *
                                                              0.2,
                                                          height: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.035,
                                                          child: TextField(
                                                            autocorrect: false,
                                                            enableSuggestions: false,
                                                            controller:
                                                            _remark5_5,
                                                            decoration:
                                                            InputDecoration(
                                                              hintStyle: const TextStyle(
                                                                  color: Color(
                                                                      0xFFCACAC9)),
                                                              border:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                              focusedBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFF626262)),
                                                              ),
                                                              enabledBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Divider(thickness: 1),
                                                  ListTile(
                                                    contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                    title: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            children: [
                                                              Text('5.6',
                                                                  textAlign:
                                                                  TextAlign
                                                                      .center,
                                                                  style:
                                                                  TextStyle(
                                                                    fontSize:
                                                                    16,
                                                                    fontFamily:
                                                                    AppFont
                                                                        .OutfitFont,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                  )),
                                                              Container(
                                                                width: 1,
                                                                height: 50,
                                                                color:
                                                                Colors.grey,
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                    10),
                                                              ),
                                                              Flexible(
                                                                child: Text(
                                                                    'Rotor head and main rotor blades attachment area',
                                                                    textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                    softWrap:
                                                                    true,
                                                                    overflow:
                                                                    TextOverflow
                                                                        .visible,
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize:
                                                                      16,
                                                                      fontFamily:
                                                                      AppFont
                                                                          .OutfitFont,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                    )),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(width: 30),
                                                        Checkbox(
                                                          value: _isChecked5_6,
                                                          activeColor: AppColor
                                                              .primaryColor,
                                                          checkColor:
                                                          Colors.white,
                                                          shape:
                                                          RoundedRectangleBorder(
                                                            side: BorderSide(
                                                              color:
                                                              Colors.grey,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                4.0),
                                                          ),
                                                          onChanged:
                                                              (bool? value) {
                                                            setState(() {
                                                              _isChecked5_6 =
                                                                  value ??
                                                                      false;
                                                            });
                                                          },
                                                        ),
                                                        SizedBox(width: 20),
                                                        Container(
                                                          width: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width *
                                                              0.2,
                                                          height: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.035,
                                                          child: TextField(
                                                            autocorrect: false,
                                                            enableSuggestions: false,
                                                            controller:
                                                            _remark5_6,
                                                            decoration:
                                                            InputDecoration(
                                                              hintStyle: const TextStyle(
                                                                  color: Color(
                                                                      0xFFCACAC9)),
                                                              border:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                              focusedBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFF626262)),
                                                              ),
                                                              enabledBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                            ),
                                                          ),
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
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(height: 25),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Text('Comments : ',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: AppFont.OutfitFont,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                            )),
                                        const SizedBox(width: 25),
                                        Expanded(
                                          child: TextField(
                                            autocorrect: false,
                                            enableSuggestions: false,
                                            controller: _comment,
                                            decoration: InputDecoration(
                                              hintStyle: const TextStyle(
                                                  color: Color(0xFFCACAC9)),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(12),
                                                borderSide: const BorderSide(
                                                    color: Color(0xFFCACAC9)),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(12),
                                                borderSide: const BorderSide(
                                                    color: Color(0xFF626262)),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(12),
                                                borderSide: const BorderSide(
                                                    color: Color(0xFFCACAC9)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 25),

                              // Row(
                              //   children: [
                              //     Expanded(
                              //       child: Row(
                              //         crossAxisAlignment:
                              //             CrossAxisAlignment.center,
                              //         children: [
                              //           Text('Captain :',
                              //               style: TextStyle(
                              //                 fontSize: 20,
                              //                 fontFamily: AppFont.OutfitFont,
                              //                 color: Colors.black,
                              //                 fontWeight: FontWeight.w400,
                              //               )),
                              //           const SizedBox(width: 25),
                              //           Expanded(
                              //             child: TextField(
                              // autocorrect: false,
                              // enableSuggestions: false,
                              //               decoration: InputDecoration(
                              //                 hintStyle: const TextStyle(
                              //                     color: Color(0xFFCACAC9)),
                              //                 border: OutlineInputBorder(
                              //                   borderRadius:
                              //                       BorderRadius.circular(12),
                              //                   borderSide: const BorderSide(
                              //                       color: Color(0xFFCACAC9)),
                              //                 ),
                              //                 focusedBorder: OutlineInputBorder(
                              //                   borderRadius:
                              //                       BorderRadius.circular(12),
                              //                   borderSide: const BorderSide(
                              //                       color: Color(0xFF626262)),
                              //                 ),
                              //                 enabledBorder: OutlineInputBorder(
                              //                   borderRadius:
                              //                       BorderRadius.circular(12),
                              //                   borderSide: const BorderSide(
                              //                       color: Color(0xFFCACAC9)),
                              //                 ),
                              //               ),
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //     const SizedBox(width: 25),
                              //     Expanded(
                              //       child: Row(
                              //         crossAxisAlignment:
                              //             CrossAxisAlignment.center,
                              //         children: [
                              //           Text('Date : ',
                              //               style: TextStyle(
                              //                 fontSize: 20,
                              //                 fontFamily: AppFont.OutfitFont,
                              //                 color: Colors.black,
                              //                 fontWeight: FontWeight.w400,
                              //               )),
                              //           const SizedBox(width: 25),
                              //           Expanded(
                              //             child: TextField(
                              // autocorrect: false,
                              // enableSuggestions: false,
                              //               decoration: InputDecoration(
                              //                 hintStyle: const TextStyle(
                              //                     color: Color(0xFFCACAC9)),
                              //                 border: OutlineInputBorder(
                              //                   borderRadius:
                              //                       BorderRadius.circular(12),
                              //                   borderSide: const BorderSide(
                              //                       color: Color(0xFFCACAC9)),
                              //                 ),
                              //                 focusedBorder: OutlineInputBorder(
                              //                   borderRadius:
                              //                       BorderRadius.circular(12),
                              //                   borderSide: const BorderSide(
                              //                       color: Color(0xFF626262)),
                              //                 ),
                              //                 enabledBorder: OutlineInputBorder(
                              //                   borderRadius:
                              //                       BorderRadius.circular(12),
                              //                   borderSide: const BorderSide(
                              //                       color: Color(0xFFCACAC9)),
                              //                 ),
                              //               ),
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //   ],
                              // ),

                              // const SizedBox(height: 25),

                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Text('SIGNATURE :',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: AppFont.OutfitFont,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                            )),
                                        const SizedBox(width: 25),
                                        Expanded(
                                          child: Checkbox(
                                            value: _userSign,
                                            activeColor: AppColor.primaryColor,
                                            checkColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                color: Colors.grey,
                                                width: 5.0,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(4.0),
                                            ),
                                            onChanged: (bool? value) {
                                              setState(() {
                                                _userSign = value ?? false;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 25),
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Text('TIME START : ',
                                            // Label for the first text field
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: AppFont.OutfitFont,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                            )),
                                        const SizedBox(width: 25),
                                        Expanded(
                                          child: TextField(
                                            autocorrect: false,
                                            enableSuggestions: false,
                                            controller: _timeStart,
                                            readOnly: true,
                                            onTap: () async {
                                              TimeOfDay? pickedTime =
                                              await showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now(),
                                                builder: (context, child) {
                                                  return MediaQuery(
                                                    data: MediaQuery.of(context)
                                                        .copyWith(
                                                        alwaysUse24HourFormat:
                                                        true),
                                                    child: child!,
                                                  );
                                                },
                                              );

                                              if (pickedTime != null) {
                                                // Format the selected time and update the TextField
                                                String formattedTime =
                                                    '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                                                _timeStart.text =
                                                    formattedTime; // Update the controller's text
                                              }
                                            },
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(12),
                                                borderSide: const BorderSide(
                                                    color: Color(0xFFCACAC9)),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(12),
                                                borderSide: const BorderSide(
                                                    color: Color(0xFF626262)),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(12),
                                                borderSide: const BorderSide(
                                                    color: Color(0xFFCACAC9)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 25),
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Text('END : ',
                                            // Label for the first text field
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: AppFont.OutfitFont,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                            )),
                                        const SizedBox(width: 25),

                                        Expanded(
                                          child: TextField(
                                            autocorrect: false,
                                            enableSuggestions: false,
                                            controller: _timeEnd,
                                            readOnly: true,
                                            onTap: () async {
                                              TimeOfDay? pickedTime =
                                              await showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now(),
                                                builder: (context, child) {
                                                  return MediaQuery(
                                                    data: MediaQuery.of(context)
                                                        .copyWith(
                                                        alwaysUse24HourFormat:
                                                        true),
                                                    child: child!,
                                                  );
                                                },
                                              );

                                              if (pickedTime != null) {
                                                // Format the selected time and update the TextField
                                                String formattedTime =
                                                    '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                                                _timeEnd.text =
                                                    formattedTime; // Update the controller's text
                                              }
                                            },
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(12),
                                                borderSide: const BorderSide(
                                                    color: Color(0xFFCACAC9)),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(12),
                                                borderSide: const BorderSide(
                                                    color: Color(0xFF626262)),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(12),
                                                borderSide: const BorderSide(
                                                    color: Color(0xFFCACAC9)),
                                              ),
                                            ),
                                          ),
                                        ),

                                        // Expanded(
                                        //   child: TextField(
                                        // autocorrect: false,
                                        // enableSuggestions: false,
                                        //     controller: _timeEnd,
                                        //     decoration: InputDecoration(
                                        //       hintStyle: const TextStyle(
                                        //           color: Color(0xFFCACAC9)),
                                        //       border: OutlineInputBorder(
                                        //         borderRadius:
                                        //             BorderRadius.circular(12),
                                        //         borderSide: const BorderSide(
                                        //             color: Color(0xFFCACAC9)),
                                        //       ),
                                        //       focusedBorder: OutlineInputBorder(
                                        //         borderRadius:
                                        //             BorderRadius.circular(12),
                                        //         borderSide: const BorderSide(
                                        //             color: Color(0xFF626262)),
                                        //       ),
                                        //       enabledBorder: OutlineInputBorder(
                                        //         borderRadius:
                                        //             BorderRadius.circular(12),
                                        //         borderSide: const BorderSide(
                                        //             color: Color(0xFFCACAC9)),
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),


                              SizedBox(height: 15),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "SEC-FOR-07",
                                    style: TextStyle(
                                      fontFamily: AppFont.OutfitFont,
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "Rev.0",
                                    style: TextStyle(
                                      fontFamily: AppFont.OutfitFont,
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "05 JUNE 2023",
                                    style: TextStyle(
                                      fontFamily: AppFont.OutfitFont,
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 25),

                              if (_formStatus != 'completed') ...[
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                            context,
                                            "/forms",
                                          );
                                        },
                                        style: ButtonStyle(
                                          foregroundColor:
                                          MaterialStateProperty.resolveWith(
                                                  (states) {
                                                if (states.contains(
                                                    MaterialState.pressed)) {
                                                  return Colors
                                                      .white; // Text color when pressed
                                                }
                                                return Color(
                                                    0xFFAA182C); // Text color when not pressed
                                              }),
                                          backgroundColor:
                                          MaterialStateProperty.resolveWith(
                                                  (states) {
                                                if (states.contains(
                                                    MaterialState.pressed)) {
                                                  return Color(
                                                      0xFFAA182C); // Background color when pressed
                                                }
                                                return Colors
                                                    .white; // Background color when not pressed
                                              }),
                                          side: MaterialStateProperty.all(
                                              BorderSide(
                                                  color: Color(0xFFAA182C),
                                                  width: 1)), // Red outline
                                          padding: MaterialStateProperty.all(
                                              const EdgeInsets.all(13.0)),
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          'Back',
                                          style: TextStyle(
                                            fontFamily: AppFont.OutfitFont,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          // EasyLoading.show( status: 'Updating...');

                                          if (!allCheckboxesChecked()) {
                                            //EasyLoading.showError('');
                                            EasyLoading.showInfo(
                                                'Please check all sections');
                                          } else {
                                            if (!_userSign) {
                                              EasyLoading.showInfo(
                                                  'Please sign in to continue');
                                            } else {
                                              if (_timeStart.text.toString() ==
                                                  "") {
                                                EasyLoading.showInfo(
                                                    'Please sign in to continue');
                                              } else if (_timeEnd.text
                                                  .toString() ==
                                                  "") {
                                                EasyLoading.showInfo(
                                                    'Please sign in to continue');
                                                //
                                              } else {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title:
                                                      Text('Confirmation'),
                                                      content: Text(
                                                          'Do you want to save your changes?'),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          onPressed: () {
                                                            // Close the dialog without saving
                                                            Navigator.of(
                                                                context)
                                                                .pop();
                                                          },
                                                          child: Text('No'),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            EasyLoading.show(
                                                                status:
                                                                'Saving...');
                                                            saveformdata();
                                                            Navigator.of(
                                                                context)
                                                                .pop();
                                                          },
                                                          child: Text('Yes'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              }
                                            }
                                          }
                                        },
                                        style: ButtonStyle(
                                          foregroundColor:
                                          WidgetStateProperty.resolveWith(
                                                  (states) {
                                                if (states.contains(
                                                    WidgetState.pressed)) {
                                                  return Colors.white;
                                                }
                                                return Colors.white70;
                                              }),
                                          backgroundColor:
                                          WidgetStateProperty.resolveWith(
                                                  (states) {
                                                if (states.contains(
                                                    WidgetState.pressed)) {
                                                  return (Color(0xFFE8374F));
                                                }
                                                return (Color(0xFFAA182C));
                                              }),
                                          padding: WidgetStateProperty.all(
                                              const EdgeInsets.all(13.0)),
                                          shape: WidgetStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          'Save',
                                          style: TextStyle(
                                            fontFamily: AppFont.OutfitFont,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 25),
                              ]
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
      ),
    );
  }

  Future<void> saveformdata() async {
    var aircraft = {
      "aircraftId": selectMaingroupId,
      "aircraftType": selectMaingroup,
      "aircraftRegId": selectedGroupId_id,
      "aircraftRegistration": selectedGroupName
    };
    var currentDate =
        "${DateTime.now().day.toString().padLeft(2, '0')}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().year}";
    var formUser = {"userId": UserID, "userName": fullName};
    var captainUser = {"captainId": UserID, "captainName": fullName};

    var data = {
      "refNo": aircraft_search_checklist_refno,
      "aircraft": aircraft,
      "formId": formId,
      "date": currentDate,
      "formUser": formUser,
      "captainUser": captainUser,
      "location": _location.text,
      "comments": _comment.text,
      "sign": _userSign,
      "timeStart": _timeStart.text,
      "timeEnd": _timeEnd.text,
      "formFields": [
        {
          "fieldId": "1",
          "Item": "Flight Deck",
          "subFields": [
            {
              "subfieldId": "1.1",
              "subItem":
              "Seats including pouches, cushions and underside and back side of seats",
              "checked": "1",
              "remarks": _remark1_1.text
            },
            {
              "subfieldId": "1.2",
              "subItem": "Log book and flight manual stowage",
              "checked": "1",
              "remarks": _remark1_2.text
            },
            {
              "subfieldId": "1.3",
              "subItem":
              "Entire floor, including area forward of tail rotor pedals and beneath flight deck seats",
              "checked": "1",
              "remarks": _remark1_3.text
            },
            {
              "subfieldId": "1.4",
              "subItem": "Entire cockpit structure",
              "checked": "1",
              "remarks": _remark1_4.text
            },
            {
              "subfieldId": "1.5",
              "subItem": "Life jacket stowage",
              "checked": "1",
              "remarks": _remark1_5.text
            },
            {
              "subfieldId": "1.6",
              "subItem": "First aid kit ensure seal intact",
              "checked": "1",
              "remarks": _remark1_6.text
            },
            {
              "subfieldId": "1.7",
              "subItem": "Fire Extinguisher mounting case",
              "checked": "1",
              "remarks": _remark1_7.text
            }
          ]
        },
        {
          "fieldId": "2",
          "Item": "Main Cabin",
          "subFields": [
            {
              "subfieldId": "2.1",
              "subItem": "Seats (pouches, cushions and underside of seats)",
              "checked": "1",
              "remarks": _remark2_1.text
            },
            {
              "subfieldId": "2.2",
              "subItem": "Floor and shelves located under the floor",
              "checked": "1",
              "remarks": _remark2_2.text
            },
            {
              "subfieldId": "2.3",
              "subItem":
              "Cabin internal structure including side walls, ceiling, doors pouches and light recesses",
              "checked": "1",
              "remarks": _remark2_3.text
            },
            {
              "subfieldId": "2.4",
              "subItem": "Life jacket stowage pockets",
              "checked": "1",
              "remarks": _remark2_4.text
            }
          ]
        },
        {
          "fieldId": "3",
          "Item": "Aircraft Exterior and Cargo Compartments",
          "subFields": [
            {
              "subfieldId": "3.1",
              "subItem":
              "Fuselage areas behind the following doors and openings:",
              "checked": "1",
              "remarks": _remark3_1.text
            },
            {
              "subfieldId": "3.1a",
              "subItem": "R/H fuselage side compartment doors",
              "checked": "1",
              "remarks": _remark3_1a.text
            },
            {
              "subfieldId": "3.1b",
              "subItem": "L/H fuselage side compartment doors",
              "checked": "1",
              "remarks": _remark3_1b.text
            },
            {
              "subfieldId": "3.2",
              "subItem": "Ground power access door",
              "checked": "1",
              "remarks": _remark3_2.text
            },
            {
              "subfieldId": "3.3",
              "subItem":
              "Tail rotor drive shaft and gear box inspection panels",
              "checked": "1",
              "remarks": _remark3_3.text
            },
            {
              "subfieldId": "3.4",
              "subItem": "Tail boom baggage compartment",
              "checked": "1",
              "remarks": _remark3_4.text
            },
            {
              "subfieldId": "3.5",
              "subItem": "Fuselage maintenance steps and handholds",
              "checked": "1",
              "remarks": _remark3_5.text
            }
          ]
        },
        {
          "fieldId": "4",
          "Item": "Landing Gear",
          "subFields": [
            {
              "subfieldId": "4.1",
              "subItem": "Main Landing Gear skids and floatation bags",
              "checked": "1",
              "remarks": _remark4_1.text
            },
            {
              "subfieldId": "4.2",
              "subItem": "Flotation gear inflation bottle",
              "checked": "1",
              "remarks": _remark4_2.text
            }
          ]
        },
        {
          "fieldId": "5",
          "Item": "Engine, Transmission and Rotor Head",
          "subFields": [
            {
              "subfieldId": "5.1",
              "subItem": "LH and RH Engine air intakes",
              "checked": "1",
              "remarks": _remark5_1.text
            },
            {
              "subfieldId": "5.2",
              "subItem": "LH and RH Engine exhausts",
              "checked": "1",
              "remarks": _remark5_2.text
            },
            {
              "subfieldId": "5.3",
              "subItem":
              "LH and RH Engine deck and entire engine installations",
              "checked": "1",
              "remarks": _remark5_3.text
            },
            {
              "subfieldId": "5.4",
              "subItem":
              "Transmission deck and entire transmission installation",
              "checked": "1",
              "remarks": _remark5_4.text
            },
            {
              "subfieldId": "5.5",
              "subItem": "Swashplate and support area",
              "checked": "1",
              "remarks": _remark5_5.text
            },
            {
              "subfieldId": "5.6",
              "subItem": "Rotor head and main rotor blades attachment area",
              "checked": "1",
              "remarks": _remark5_6.text
            }
          ]
        }
      ]
    };

    try {
      var response = await http.Client().post(
        Uri.parse(
            "${AppUrls.formdata}?formid=$formId&formrefno=$aircraft_search_checklist_refno"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $userToken"
        },
        body: jsonEncode({
          "data": data,
        }),
      );

      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        final responseData = json.decode(response.body);
        print(responseData);
        EasyLoading.showSuccess("Saved");
        formdata_pass_backend(UserID, userToken);
      } else {
        EasyLoading.dismiss();
        final responseData = json.decode(response.body);
        print(responseData);
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
}
