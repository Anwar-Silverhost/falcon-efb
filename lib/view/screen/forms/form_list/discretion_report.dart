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

class DiscretionReport extends StatefulWidget {
  const DiscretionReport({super.key});

  @override
  State<DiscretionReport> createState() => _DiscretionReportState();
}

class _DiscretionReportState extends State<DiscretionReport> {
  //Extension of dudty
  final TextEditingController _Extension_commandersname =
      TextEditingController();
  final TextEditingController _Extension_crew_involved_PIC =
      TextEditingController();
  final TextEditingController _Extension_crew_involved_SIC =
      TextEditingController();
  final TextEditingController _Extension_schedule_flighttype =
      TextEditingController();
  final TextEditingController _Extension_schedule_routing =
      TextEditingController();
  final TextEditingController _Extension_schedule_FDP = TextEditingController();
  final TextEditingController _Extension_schedule_FDPstart_UTC =
      TextEditingController();
  final TextEditingController _Extension_schedule_FDPstart_LT =
      TextEditingController();
  final TextEditingController _Extension_schedule_allowedFDP =
      TextEditingController();
  final TextEditingController _Extension_actual_FDPstart_place =
      TextEditingController();
  final TextEditingController _Extension_actual_FDPstart_UTC =
      TextEditingController();
  final TextEditingController _Extension_actual_FDPstart_LT =
      TextEditingController();
  final TextEditingController _Extension_actual_FDPend_place =
      TextEditingController();
  final TextEditingController _Extension_actual_FDPend_UTC =
      TextEditingController();
  final TextEditingController _Extension_actual_FDPend_LT =
      TextEditingController();
  final TextEditingController _Extension_actual_actual_FDP =
      TextEditingController();
  final TextEditingController _Extension_actual_FDP_exceed =
      TextEditingController();
  final TextEditingController _Extension_commanders_reason =
      TextEditingController();
  final TextEditingController _Extension_operators_remark =
      TextEditingController();
  bool _Extension_Commanders_check = false;
  bool _Extension_Operators_check = false;

  final TextEditingController _Reduced_commandersname = TextEditingController();
  final TextEditingController _Reduced_crew_involved_PIC =
      TextEditingController();
  final TextEditingController _Reduced_crew_involved_SIC =
      TextEditingController();
  bool _Reduced_Commander_Point1 = false;
  bool _Reduced_Commander_Point2 = false;
  bool _Reduced_Commander_Point3 = false;
  bool _Reduced_Commander_Point4 = false;
  bool _Reduced_Commander_Point5 = false;
  final TextEditingController _Reduced_lastdutystarted_UTC =
      TextEditingController();
  final TextEditingController _Reduced_lastdutystarted_LT =
      TextEditingController();
  final TextEditingController _Reduced_lastdutyended_UTC =
      TextEditingController();
  final TextEditingController _Reduced_lastdutyended_LT =
      TextEditingController();
  final TextEditingController _Reduced_restEarned = TextEditingController();
  final TextEditingController _Reduced_actualstartofnextFDP_UTC =
      TextEditingController();
  final TextEditingController _Reduced_actualstartofnextFDP_LT =
      TextEditingController();
  final TextEditingController _Reduced_restperiodreducedby =
      TextEditingController();
  final TextEditingController _Reduced_commanders_reason =
      TextEditingController();
  final TextEditingController _Reduced_operators_remark =
      TextEditingController();
  bool _Reduced_Commanders_check = false;
  bool _Reduced_Operators_check = false;

  var formId = 'FAF05';
  var currentDate =
      "${DateTime.now().day.toString().padLeft(2, '0')}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().year}";

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

  String commanders_discretion_report_refno = '';

  String? extensionStatus;
  String? reducedStatus;

  @override
  void initState() {
    super.initState();
    getUserToken();

    _Extension_actual_FDP_exceed.addListener(() {
      String value = _Extension_actual_FDP_exceed.text;
      if (value.startsWith('-')) {
        _Extension_actual_FDP_exceed.value = const TextEditingValue(
          text: "No Exceedance",
          selection: TextSelection.collapsed(offset: "No Exceedance".length),
        );
      }
    });

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




  void _calculateTotalTime(String startTime, String finishTime,
      TextEditingController totalFdpController) {
    if (startTime.isNotEmpty && finishTime.isNotEmpty) {
      try {
        // Parse the start and finish times
        List<String> startParts = startTime.split(":");
        List<String> finishParts = finishTime.split(":");

        int startHour = int.parse(startParts[0]);
        int startMinute = int.parse(startParts[1]);

        int finishHour = int.parse(finishParts[0]);
        int finishMinute = int.parse(finishParts[1]);

        Duration startDuration =
        Duration(hours: startHour, minutes: startMinute);
        Duration finishDuration =
        Duration(hours: finishHour, minutes: finishMinute);

        // Calculate the total duration
        Duration totalDuration = finishDuration - startDuration;

        // Format the duration as HH:mm
        String formattedTotal =
            "${totalDuration.inHours.toString().padLeft(2, '0')}:${(totalDuration.inMinutes % 60).toString().padLeft(2, '0')}";

        // Update the total FDP TextField controller
        totalFdpController.text = formattedTotal;
      } catch (e) {
        // Handle parsing errors
        totalFdpController.text = "Error";
      }
    }
  }











  @override
  void dispose() {
    _Extension_actual_FDP_exceed.dispose();
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
        print(responseData['data']['form_status']);

        setState(() {
          commanders_discretion_report_refno =
              responseData['data']['form_ref_no'];
        });

        if ((responseData['data']['form_status']) == 'completed') {
          // print(responseData['data']['form_status']['tableValues']['extension_commandersname']);
          // var extensionCommandersName = responseData['data']['form_data']['tableValues']['extension']['extension_commandersname'];

          var extensionStatusx = responseData['data']['form_data']
                  ['tableValues']['extension_status'] ??
              '';

          if (extensionStatusx == 'completed') {
            setState(() {
              _Extension_commandersname.text = responseData['data']['form_data']
                          ['tableValues']['extension']
                      ['extension_commandersname'] ??
                  '';
              _Extension_crew_involved_PIC.text = responseData['data']
                          ['form_data']['tableValues']['extension']
                      ['extension_crew_involved_PIC'] ??
                  '';
              _Extension_crew_involved_SIC.text = responseData['data']
                          ['form_data']['tableValues']['extension']
                      ['extension_crew_involved_SIC'] ??
                  '';
              _Extension_schedule_flighttype.text = responseData['data']
                          ['form_data']['tableValues']['extension']
                      ['extension_schedule_flighttype'] ??
                  '';
              _Extension_schedule_routing.text = responseData['data']
                          ['form_data']['tableValues']['extension']
                      ['extension_schedule_routing'] ??
                  '';
              _Extension_schedule_FDP.text = responseData['data']['form_data']
                      ['tableValues']['extension']['extension_schedule_FDP'] ??
                  '';
              _Extension_schedule_FDPstart_UTC.text = responseData['data']
                          ['form_data']['tableValues']['extension']
                      ['extension_schedule_FDPstart_UTC'] ??
                  '';
              _Extension_schedule_FDPstart_LT.text = responseData['data']
                          ['form_data']['tableValues']['extension']
                      ['extension_schedule_FDPstart_LT'] ??
                  '';
              _Extension_schedule_allowedFDP.text = responseData['data']
                          ['form_data']['tableValues']['extension']
                      ['extension_schedule_allowedFDP'] ??
                  '';
              _Extension_actual_FDPstart_place.text = responseData['data']
                          ['form_data']['tableValues']['extension']
                      ['extension_actual_FDPstart_place'] ??
                  '';
              _Extension_actual_FDPstart_UTC.text = responseData['data']
                          ['form_data']['tableValues']['extension']
                      ['extension_actual_FDPstart_UTC'] ??
                  '';
              _Extension_actual_FDPstart_LT.text = responseData['data']
                          ['form_data']['tableValues']['extension']
                      ['extension_actual_FDPstart_LT'] ??
                  '';
              _Extension_actual_FDPend_place.text = responseData['data']
                          ['form_data']['tableValues']['extension']
                      ['extension_actual_FDPend_place'] ??
                  '';
              _Extension_actual_FDPend_UTC.text = responseData['data']
                          ['form_data']['tableValues']['extension']
                      ['extension_actual_FDPend_UTC'] ??
                  '';
              _Extension_actual_FDPend_LT.text = responseData['data']
                          ['form_data']['tableValues']['extension']
                      ['extension_actual_FDPend_LT'] ??
                  '';
              _Extension_actual_actual_FDP.text = responseData['data']
                          ['form_data']['tableValues']['extension']
                      ['extension_actual_actual_FDP'] ??
                  '';
              _Extension_actual_FDP_exceed.text = responseData['data']
                          ['form_data']['tableValues']['extension']
                      ['extension_actual_FDP_exceed'] ??
                  '';
              _Extension_commanders_reason.text = responseData['data']
                          ['form_data']['tableValues']['extension']
                      ['extension_commanders_reason'] ??
                  '';
              _Extension_operators_remark.text = responseData['data']
                          ['form_data']['tableValues']['extension']
                      ['extension_operators_remark'] ??
                  '';
              _Extension_Commanders_check = true;
              _Extension_Operators_check = true;
              extensionStatus = 'completed';
            });
          }

          var reducedStatusx = responseData['data']['form_data']['tableValues']
                  ['reduced_status'] ??
              '';

          print(reducedStatusx);

          if (reducedStatusx == 'completed') {
            setState(() {
              _Reduced_commandersname.text = responseData['data']['form_data']
                      ['tableValues']['reduced']['reduced_commandersname'] ??
                  '';
              _Reduced_crew_involved_PIC.text = responseData['data']
                          ['form_data']['tableValues']['reduced']
                      ['reduced_crew_involved_PIC'] ??
                  '';
              _Reduced_crew_involved_SIC.text = responseData['data']
                          ['form_data']['tableValues']['reduced']
                      ['reduced_crew_involved_SIC'] ??
                  '';
              _Reduced_lastdutystarted_UTC.text = responseData['data']
                          ['form_data']['tableValues']['reduced']
                      ['reduced_lastdutystarted_UTC'] ??
                  '';
              _Reduced_lastdutystarted_LT.text = responseData['data']
                          ['form_data']['tableValues']['reduced']
                      ['reduced_lastdutystarted_LT'] ??
                  '';
              _Reduced_lastdutyended_UTC.text = responseData['data']
                          ['form_data']['tableValues']['reduced']
                      ['reduced_lastdutyended_UTC'] ??
                  '';
              _Reduced_lastdutyended_LT.text = responseData['data']['form_data']
                      ['tableValues']['reduced']['reduced_lastdutyended_LT'] ??
                  '';
              _Reduced_restEarned.text = responseData['data']['form_data']
                      ['tableValues']['reduced']['reduced_restEarned'] ??
                  '';
              _Reduced_actualstartofnextFDP_UTC.text = responseData['data']
                          ['form_data']['tableValues']['reduced']
                      ['reduced_actualstartofnextFDP_UTC'] ??
                  '';
              _Reduced_actualstartofnextFDP_LT.text = responseData['data']
                          ['form_data']['tableValues']['reduced']
                      ['reduced_actualstartofnextFDP_LT'] ??
                  '';
              _Reduced_restperiodreducedby.text = responseData['data']
                          ['form_data']['tableValues']['reduced']
                      ['reduced_restperiodreducedby'] ??
                  '';
              _Reduced_commanders_reason.text = responseData['data']
                          ['form_data']['tableValues']['reduced']
                      ['reduced_commanders_reason'] ??
                  '';
              _Reduced_operators_remark.text = responseData['data']['form_data']
                      ['tableValues']['reduced']['reduced_operators_remark'] ??
                  '';
              _Reduced_Commander_Point1 = true;
              _Reduced_Commander_Point2 = true;
              _Reduced_Commander_Point3 = true;
              _Reduced_Commander_Point4 = true;
              _Reduced_Commander_Point5 = true;
              _Reduced_Commanders_check = true;
              _Reduced_Operators_check = true;
              reducedStatus = 'completed';
            });
          }
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
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
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
                                    builder: (context) => const ProfileScreen(),
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
                            // Card with the heading
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                    Expanded(
                                      child: Text(
                                        "COMMANDER'S DISCRETION REPORT - RW"
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
                            SizedBox(height: 20),

                            DefaultTabController(
                              length: 2,
                              child: Column(
                                children: [
                                  TabBar(
                                    indicator: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            color: AppColor.primaryColor,
                                            width: 3),
                                      ),
                                    ),
                                    tabs: [
                                      Container(
                                        width: double.infinity,
                                        alignment: Alignment.center,
                                        child: Tab(
                                            child: Text(
                                          'EXTENSION OF DUTY',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: AppFont.OutfitFont,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        alignment: Alignment.center,
                                        child: Tab(
                                            child: Text(
                                          'REDUCED REST',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: AppFont.OutfitFont,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )),
                                      ),
                                    ],
                                    labelColor: AppColor.primaryColor,
                                    unselectedLabelColor: Colors.black,
                                    indicatorColor: AppColor.primaryColor,
                                    indicatorWeight: 3.0,
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height + 75,
                                    child: TabBarView(
                                      children: [
                                        Column(children: [
                                          const SizedBox(height: 20),
                                          Center(
                                            child: Column(
                                              children: [
                                                Table(
                                                  border: TableBorder.all(
                                                      color: Colors.black26),
                                                  columnWidths: const {
                                                    0: FixedColumnWidth(80.0),
                                                    1: FixedColumnWidth(120.0),
                                                    2: FixedColumnWidth(120.0),
                                                    3: FixedColumnWidth(120.0),
                                                    4: FixedColumnWidth(160.0),
                                                    5: FixedColumnWidth(150.0),
                                                  },
                                                  children: [
                                                    TableRow(children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child: Text(
                                                          'DATE',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontFamily: AppFont
                                                                .OutfitFont,
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0),
                                                        child: Container(
                                                          constraints:
                                                              const BoxConstraints(
                                                            minHeight: 10.0,
                                                            maxHeight: 100.0,
                                                          ),
                                                          child:
                                                              SingleChildScrollView(
                                                            child: TextField(
                                                              autocorrect:
                                                                  false,
                                                              enableSuggestions:
                                                                  false,
                                                              style: const TextStyle(
                                                                  fontSize:
                                                                      16.0,
                                                                  color: AppColor
                                                                      .textColor),
                                                              scrollPhysics:
                                                                  const NeverScrollableScrollPhysics(),
                                                              readOnly: true,
                                                              textCapitalization:
                                                                  TextCapitalization
                                                                      .characters,
                                                              controller:
                                                                  TextEditingController(
                                                                      text:
                                                                          currentDate),
                                                              decoration:
                                                                  const InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                contentPadding:
                                                                    EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            10.0),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                        child: Text(
                                                          'Aircraft Type',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontFamily: AppFont
                                                                .OutfitFont,
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0),
                                                        child: Container(
                                                          constraints:
                                                              const BoxConstraints(
                                                            minHeight: 10.0,
                                                            maxHeight: 100.0,
                                                          ),
                                                          child:
                                                              SingleChildScrollView(
                                                            child: TextField(
                                                              autocorrect: false,
                                                              enableSuggestions: false,
                                                              style: const TextStyle(
                                                                  fontSize:
                                                                      16.0,
                                                                  color: AppColor
                                                                      .textColor),
                                                              scrollPhysics:
                                                                  const NeverScrollableScrollPhysics(),
                                                              textCapitalization:
                                                                  TextCapitalization
                                                                      .characters,
                                                              controller:
                                                                  TextEditingController(
                                                                      text:
                                                                          selectMaingroup),
                                                              decoration:
                                                                  const InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                contentPadding:
                                                                    EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            10.0),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                        child: Text(
                                                          'Aircraft Registration',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontFamily: AppFont
                                                                .OutfitFont,
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0),
                                                        child: Container(
                                                          constraints:
                                                              const BoxConstraints(
                                                            minHeight: 10.0,
                                                            maxHeight: 100.0,
                                                          ),
                                                          child:
                                                              SingleChildScrollView(
                                                            child: TextField(
                                                              autocorrect:
                                                                  false,
                                                              enableSuggestions:
                                                                  false,
                                                              style: const TextStyle(
                                                                  fontSize:
                                                                      16.0,
                                                                  color: AppColor
                                                                      .textColor),
                                                              scrollPhysics:
                                                                  const NeverScrollableScrollPhysics(),
                                                              textCapitalization:
                                                                  TextCapitalization
                                                                      .characters,
                                                              controller:
                                                                  TextEditingController(
                                                                      text:
                                                                          selectedGroupName),
                                                              decoration:
                                                                  const InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                contentPadding:
                                                                    EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            10.0),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ]),
                                                  ],
                                                ),
                                                Table(
                                                  border: const TableBorder(
                                                      horizontalInside:
                                                          BorderSide(
                                                              color: Colors
                                                                  .black26),
                                                      verticalInside:
                                                          BorderSide(
                                                              color: Colors
                                                                  .black26),
                                                      right: BorderSide(
                                                          color:
                                                              Colors.black26),
                                                      left: BorderSide(
                                                          color:
                                                              Colors.black26)),
                                                  columnWidths: const {
                                                    0: FixedColumnWidth(200.0),
                                                    1: FixedColumnWidth(550.0),
                                                  },
                                                  children: [
                                                    TableRow(children: [
                                                      Padding(
                                                        padding: const EdgeInsets.all(
                                                            10.0),
                                                        child: Text(
                                                          'Commander’s Name',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontFamily: AppFont
                                                                .OutfitFont,
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0),
                                                        child: Container(
                                                          constraints:
                                                              const BoxConstraints(
                                                            minHeight: 10.0,
                                                            maxHeight: 100.0,
                                                          ),
                                                          child:
                                                              SingleChildScrollView(
                                                            child: TextField(
                                                              autocorrect:
                                                                  false,
                                                              enableSuggestions:
                                                                  false,
                                                              style: const TextStyle(
                                                                  fontSize:
                                                                      16.0,
                                                                  color: AppColor
                                                                      .textColor),
                                                              scrollPhysics:
                                                                  const NeverScrollableScrollPhysics(),
                                                              textCapitalization:
                                                                  TextCapitalization
                                                                      .characters,
                                                              controller:
                                                                  _Extension_commandersname,
                                                              decoration:
                                                                  const InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                contentPadding:
                                                                    EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            10.0),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ]),
                                                  ],
                                                ),
                                                Table(
                                                  border: TableBorder.all(
                                                      color: Colors.black26),
                                                  columnWidths: const {
                                                    0: FixedColumnWidth(200.0),
                                                    1: FixedColumnWidth(120.0),
                                                    2: FixedColumnWidth(140.0),
                                                    3: FixedColumnWidth(120.0),
                                                    4: FixedColumnWidth(170.0),
                                                  },
                                                  children: [
                                                    TableRow(children: [
                                                      Padding(
                                                        padding: const EdgeInsets.all(
                                                            10.0),
                                                        child: Text(
                                                          'Crew Involved in Discretion',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontFamily: AppFont
                                                                .OutfitFont,
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(
                                                            10.0),
                                                        child: Text(
                                                          'PIC',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontFamily: AppFont
                                                                .OutfitFont,
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0),
                                                        child: Container(
                                                          constraints:
                                                              const BoxConstraints(
                                                            minHeight: 10.0,
                                                            maxHeight: 100.0,
                                                          ),
                                                          child:
                                                              SingleChildScrollView(
                                                            child: TextField(
                                                              autocorrect:
                                                                  false,
                                                              enableSuggestions:
                                                                  false,
                                                              style: const TextStyle(
                                                                  fontSize:
                                                                      16.0,
                                                                  color: AppColor
                                                                      .textColor),
                                                              scrollPhysics:
                                                                  NeverScrollableScrollPhysics(),
                                                              textCapitalization:
                                                                  TextCapitalization
                                                                      .characters,
                                                              controller:
                                                                  _Extension_crew_involved_PIC,
                                                              decoration:
                                                                  const InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                contentPadding:
                                                                    EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            10.0),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(
                                                            10.0),
                                                        child: Text(
                                                          'SIC',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontFamily: AppFont
                                                                .OutfitFont,
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0),
                                                        child: Container(
                                                          constraints:
                                                              const BoxConstraints(
                                                            minHeight: 10.0,
                                                            maxHeight: 100.0,
                                                          ),
                                                          child:
                                                              SingleChildScrollView(
                                                            child: TextField(
                                                              autocorrect:
                                                                  false,
                                                              enableSuggestions:
                                                                  false,
                                                              style: const TextStyle(
                                                                  fontSize:
                                                                      16.0,
                                                                  color: AppColor
                                                                      .textColor),
                                                              scrollPhysics:
                                                                  NeverScrollableScrollPhysics(),
                                                              textCapitalization:
                                                                  TextCapitalization
                                                                      .characters,
                                                              controller:
                                                                  _Extension_crew_involved_SIC,
                                                              decoration:
                                                                  const InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                contentPadding:
                                                                    EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            10.0),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ]),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                Card(
                                                  color: AppColor.primaryColor,
                                                  elevation: 0,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween, // Space between icon and text
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center, // Vertically centers icon and text
                                                      children: [
                                                        Expanded(
                                                          // Ensures the text stays centered
                                                          child: Text(
                                                            'Schedule'
                                                                .toUpperCase(),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                Table(
                                                  border: TableBorder.all(
                                                      color: Colors.black26),
                                                  columnWidths: const {
                                                    0: FixedColumnWidth(150.0),
                                                    1: FixedColumnWidth(600.0),
                                                    // 2: FixedColumnWidth(200.0),
                                                    // 3: FixedColumnWidth(200.0),
                                                  },
                                                  children: [
                                                    TableRow(children: [
                                                      Padding(
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                        child: Text(
                                                          'Flight Type *',
                                                          style: TextStyle(
                                                            fontFamily: AppFont
                                                                .OutfitFont,
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0),
                                                        child: Container(
                                                          constraints:
                                                              const BoxConstraints(
                                                            minHeight: 10.0,
                                                            maxHeight: 100.0,
                                                          ),
                                                          child:
                                                              SingleChildScrollView(
                                                            child: TextField(
                                                              autocorrect:
                                                                  false,
                                                              enableSuggestions:
                                                                  false,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      16.0,
                                                                  color: AppColor
                                                                      .textColor),
                                                              scrollPhysics:
                                                                  NeverScrollableScrollPhysics(),
                                                              textCapitalization:
                                                                  TextCapitalization
                                                                      .characters,
                                                              controller:
                                                                  _Extension_schedule_flighttype,
                                                              decoration:
                                                                  InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                contentPadding:
                                                                    EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            10.0),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ]),
                                                  ],
                                                ),
                                                Table(
                                                  border: TableBorder(
                                                      horizontalInside:
                                                          BorderSide(
                                                              color: Colors
                                                                  .black26),
                                                      verticalInside:
                                                          BorderSide(
                                                              color: Colors
                                                                  .black26),
                                                      right: BorderSide(
                                                          color:
                                                              Colors.black26),
                                                      bottom: BorderSide(
                                                          color:
                                                              Colors.black26),
                                                      left: BorderSide(
                                                          color:
                                                              Colors.black26)),
                                                  columnWidths: const {
                                                    0: FixedColumnWidth(150.0),
                                                    1: FixedColumnWidth(600.0),
                                                  },
                                                  children: [
                                                    TableRow(children: [
                                                      Padding(
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                        child: Text(
                                                          'Routing',
                                                          style: TextStyle(
                                                            fontFamily: AppFont
                                                                .OutfitFont,
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0),
                                                        child: Container(
                                                          constraints:
                                                              const BoxConstraints(
                                                            minHeight: 10.0,
                                                            maxHeight: 100.0,
                                                          ),
                                                          child:
                                                              SingleChildScrollView(
                                                            child: TextField(
                                                              autocorrect:
                                                                  false,
                                                              enableSuggestions:
                                                                  false,
                                                              style: const TextStyle(
                                                                  fontSize:
                                                                      16.0,
                                                                  color: AppColor
                                                                      .textColor),
                                                              scrollPhysics:
                                                                  const NeverScrollableScrollPhysics(),
                                                              textCapitalization:
                                                                  TextCapitalization
                                                                      .characters,
                                                              controller:
                                                                  _Extension_schedule_routing,
                                                              decoration:
                                                                  const InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                contentPadding:
                                                                    EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            10.0),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ]),
                                                  ],
                                                ),
                                                Table(
                                                  border: TableBorder(
                                                      horizontalInside:
                                                          BorderSide(
                                                              color: Colors
                                                                  .black26),
                                                      verticalInside:
                                                          BorderSide(
                                                              color: Colors
                                                                  .black26),
                                                      right: BorderSide(
                                                          color:
                                                              Colors.black26),
                                                      bottom: BorderSide(
                                                          color:
                                                              Colors.black26),
                                                      left: BorderSide(
                                                          color:
                                                              Colors.black26)),
                                                  columnWidths: const {
                                                    0: FixedColumnWidth(150.0),
                                                    1: FixedColumnWidth(200.0),
                                                    2: FixedColumnWidth(200.0),
                                                    3: FixedColumnWidth(200.0),
                                                  },
                                                  children: [
                                                    TableRow(children: [
                                                      Container(),
                                                      Container(),
                                                      Padding(
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                        child: Text(
                                                          'UTC** (hh:mm)',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontFamily: AppFont
                                                                .OutfitFont,
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                        child: Text(
                                                          'LT (hh:mm)',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontFamily: AppFont
                                                                .OutfitFont,
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ]),
                                                  ],
                                                ),
                                                Table(
                                                  border: const TableBorder(
                                                      horizontalInside:
                                                          BorderSide(
                                                              color: Colors
                                                                  .black26),
                                                      verticalInside:
                                                          BorderSide(
                                                              color: Colors
                                                                  .black26),
                                                      right: BorderSide(
                                                          color:
                                                              Colors.black26),
                                                      bottom: BorderSide(
                                                          color:
                                                              Colors.black26),
                                                      left: BorderSide(
                                                          color:
                                                              Colors.black26)),
                                                  columnWidths: const {
                                                    0: FixedColumnWidth(150.0),
                                                    1: FixedColumnWidth(200.0),
                                                    2: FixedColumnWidth(200.0),
                                                    3: FixedColumnWidth(200.0),
                                                  },
                                                  children: [
                                                    TableRow(children: [
                                                      Padding(
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                        child: Text(
                                                          'FDP Start',
                                                          style: TextStyle(
                                                            fontFamily: AppFont
                                                                .OutfitFont,
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0),
                                                        child: Container(
                                                          constraints:
                                                              const BoxConstraints(
                                                            minHeight: 10.0,
                                                            maxHeight: 100.0,
                                                          ),
                                                          child:
                                                              SingleChildScrollView(
                                                            child: TextField(
                                                              autocorrect:
                                                                  false,
                                                              enableSuggestions:
                                                                  false,
                                                              style: const TextStyle(
                                                                  fontSize:
                                                                      16.0,
                                                                  color: AppColor
                                                                      .textColor),
                                                              scrollPhysics:
                                                                  const NeverScrollableScrollPhysics(),
                                                              textCapitalization:
                                                                  TextCapitalization
                                                                      .characters,
                                                              controller:
                                                                  _Extension_schedule_FDP,
                                                              decoration:
                                                                  const InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                contentPadding:
                                                                    EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            10.0),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0),
                                                        child: Container(
                                                          constraints:
                                                              const BoxConstraints(
                                                            minHeight: 10.0,
                                                            maxHeight: 100.0,
                                                          ),
                                                          child:
                                                              SingleChildScrollView(
                                                            child: TextField(
                                                              autocorrect:
                                                                  false,
                                                              enableSuggestions:
                                                                  false,
                                                              style: const TextStyle(
                                                                  fontSize:
                                                                      16.0,
                                                                  color: AppColor
                                                                      .textColor),
                                                              scrollPhysics:
                                                                  const NeverScrollableScrollPhysics(),
                                                              textCapitalization:
                                                                  TextCapitalization
                                                                      .characters,
                                                              controller:
                                                                  _Extension_schedule_FDPstart_UTC,
                                                              readOnly: true,
                                                              onTap: () async {
                                                                TimeOfDay?
                                                                    pickedTime =
                                                                    await showTimePicker(
                                                                  context:
                                                                      context,
                                                                  initialTime:
                                                                      TimeOfDay
                                                                          .now(),
                                                                  builder:
                                                                      (context,
                                                                          child) {
                                                                    return MediaQuery(
                                                                      data: MediaQuery.of(
                                                                              context)
                                                                          .copyWith(
                                                                              alwaysUse24HourFormat: true),
                                                                      child:
                                                                          child!,
                                                                    );
                                                                  },
                                                                );

                                                                if (pickedTime !=
                                                                    null) {
                                                                  // Format the selected time and update the TextField
                                                                  String
                                                                      formattedTime =
                                                                      '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                                                                  _Extension_schedule_FDPstart_UTC
                                                                          .text =
                                                                      formattedTime; // Update the controller's text
                                                                }
                                                              },
                                                              decoration:
                                                                  const InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                contentPadding:
                                                                    EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            10.0),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0),
                                                        child: Container(
                                                          constraints:
                                                              const BoxConstraints(
                                                            minHeight: 10.0,
                                                            maxHeight: 100.0,
                                                          ),
                                                          child:
                                                              SingleChildScrollView(
                                                            child: TextField(
                                                              autocorrect:
                                                                  false,
                                                              enableSuggestions:
                                                                  false,
                                                              style: const TextStyle(
                                                                  fontSize:
                                                                      16.0,
                                                                  color: AppColor
                                                                      .textColor),
                                                              scrollPhysics:
                                                                  const NeverScrollableScrollPhysics(),
                                                              textCapitalization:
                                                                  TextCapitalization
                                                                      .characters,
                                                              controller:
                                                                  _Extension_schedule_FDPstart_LT,
                                                              readOnly: true,
                                                              onTap: () async {
                                                                TimeOfDay?
                                                                    pickedTime =
                                                                    await showTimePicker(
                                                                  context:
                                                                      context,
                                                                  initialTime:
                                                                      TimeOfDay
                                                                          .now(),
                                                                  builder:
                                                                      (context,
                                                                          child) {
                                                                    return MediaQuery(
                                                                      data: MediaQuery.of(
                                                                              context)
                                                                          .copyWith(
                                                                              alwaysUse24HourFormat: true),
                                                                      child:
                                                                          child!,
                                                                    );
                                                                  },
                                                                );

                                                                if (pickedTime !=
                                                                    null) {
                                                                  // Format the selected time and update the TextField
                                                                  String
                                                                      formattedTime =
                                                                      '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                                                                  _Extension_schedule_FDPstart_LT
                                                                          .text =
                                                                      formattedTime; // Update the controller's text
                                                                }
                                                              },
                                                              decoration:
                                                                  const InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                contentPadding:
                                                                    EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            10.0),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ]),
                                                  ],
                                                ),
                                                Table(
                                                  border: TableBorder(
                                                      horizontalInside:
                                                          BorderSide(
                                                              color: Colors
                                                                  .black26),
                                                      verticalInside:
                                                          BorderSide(
                                                              color: Colors
                                                                  .black26),
                                                      right: BorderSide(
                                                          color:
                                                              Colors.black26),
                                                      bottom: BorderSide(
                                                          color:
                                                              Colors.black26),
                                                      left: BorderSide(
                                                          color:
                                                              Colors.black26)),
                                                  columnWidths: const {
                                                    0: FixedColumnWidth(350.0),
                                                    1: FixedColumnWidth(400.0),
                                                  },
                                                  children: [
                                                    TableRow(children: [
                                                      Padding(
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                        child: Text(
                                                          'Allowed FDP',
                                                          style: TextStyle(
                                                            fontFamily: AppFont
                                                                .OutfitFont,
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0),
                                                        child: Container(
                                                          constraints:
                                                              const BoxConstraints(
                                                            minHeight: 10.0,
                                                            maxHeight: 100.0,
                                                          ),
                                                          child:
                                                              SingleChildScrollView(
                                                            child:
                                                                TextField(
                                                              autocorrect: false,
                                                              enableSuggestions: false,
                                                              style: const TextStyle(fontSize: 16.0, color: AppColor.textColor),
                                                              scrollPhysics: const NeverScrollableScrollPhysics(),
                                                              textCapitalization: TextCapitalization.characters,
                                                              controller: _Extension_schedule_allowedFDP,
                                                              readOnly: true,
                                                              onTap: () async {
                                                                TimeOfDay? pickedTime = await showTimePicker(
                                                                  context: context,
                                                                  initialTime: TimeOfDay(hour: TimeOfDay.now().hour, minute: 0), // Ensuring minutes are set to 00
                                                                  builder: (context, child) {
                                                                    return MediaQuery(
                                                                      data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                                                      child: child!,
                                                                    );
                                                                  },
                                                                );

                                                                if (pickedTime != null) {
                                                                  // Format the selected hour, ensuring minutes are always 00
                                                                  String formattedTime = '${pickedTime.hour.toString().padLeft(2, '0')}:00';
                                                                  _Extension_schedule_allowedFDP.text = formattedTime;

                                                                  _calculateTotalTime(
                                                                    _Extension_actual_actual_FDP.text,
                                                                    _Extension_schedule_allowedFDP.text,
                                                                    _Extension_actual_FDP_exceed,
                                                                  );



                                                                }
                                                              },
                                                              decoration: const InputDecoration(
                                                                border: InputBorder.none,
                                                                contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                                                              ),
                                                            ),

                                                            //TextField(
                                                            //   autocorrect:false,
                                                            //   enableSuggestions:false,
                                                            //   style: const TextStyle(fontSize:16.0,color: AppColor.textColor),
                                                            //   scrollPhysics:const NeverScrollableScrollPhysics(),
                                                            //   textCapitalization:TextCapitalization.characters,
                                                            //   controller:_Extension_schedule_allowedFDP,
                                                            //   // keyboardType: TextInputType.number,
                                                            //
                                                            //   readOnly: true,
                                                            //   onTap: () async {
                                                            //     TimeOfDay? pickedTime = await showTimePicker(
                                                            //       context: context,
                                                            //       initialTime: TimeOfDay.now(),
                                                            //       builder: (context, child) {
                                                            //         return MediaQuery(
                                                            //           data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                                            //           child: child!,
                                                            //         );
                                                            //       },
                                                            //     );
                                                            //
                                                            //     if (pickedTime != null) {
                                                            //       // Only display the hour, set minutes to 00
                                                            //       String formattedTime = '${pickedTime.hour.toString().padLeft(2, '0')}:00';
                                                            //       _Extension_schedule_allowedFDP.text = formattedTime;
                                                            //     }
                                                            //   },
                                                            //  
                                                            //   decoration:
                                                            //       const InputDecoration(
                                                            //     border:
                                                            //         InputBorder
                                                            //             .none,
                                                            //     contentPadding:
                                                            //         EdgeInsets.symmetric(
                                                            //             horizontal:
                                                            //                 10.0),
                                                            //   ),
                                                            // ),
                                                          ),
                                                        ),
                                                      ),
                                                    ]),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                Card(
                                                  color: AppColor.primaryColor,
                                                  elevation: 0,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween, // Space between icon and text
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center, // Vertically centers icon and text
                                                      children: [
                                                        Expanded(
                                                          // Ensures the text stays centered
                                                          child: Text(
                                                            'Actual'
                                                                .toUpperCase(),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                Table(
                                                  border: TableBorder(
                                                      horizontalInside:
                                                          BorderSide(
                                                              color: Colors
                                                                  .black26),
                                                      verticalInside:
                                                          BorderSide(
                                                              color: Colors
                                                                  .black26),
                                                      right: BorderSide(
                                                          color:
                                                              Colors.black26),
                                                      bottom: BorderSide(
                                                          color:
                                                              Colors.black26),
                                                      top: BorderSide(
                                                          color:
                                                              Colors.black26),
                                                      left: BorderSide(
                                                          color:
                                                              Colors.black26)),
                                                  columnWidths: const {
                                                    0: FixedColumnWidth(150.0),
                                                    1: FixedColumnWidth(200.0),
                                                    2: FixedColumnWidth(200.0),
                                                    3: FixedColumnWidth(200.0),
                                                  },
                                                  children: [
                                                    TableRow(children: [
                                                      Container(),
                                                      Padding(
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                        child: Text(
                                                          'Place',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontFamily: AppFont
                                                                .OutfitFont,
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                        child: Text(
                                                          'UTC** (hh:mm)',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontFamily: AppFont
                                                                .OutfitFont,
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                        child: Text(
                                                          'LT (hh:mm)',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontFamily: AppFont
                                                                .OutfitFont,
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ]),
                                                  ],
                                                ),
                                                Table(
                                                  border: TableBorder(
                                                      horizontalInside:
                                                          BorderSide(
                                                              color: Colors
                                                                  .black26),
                                                      verticalInside:
                                                          BorderSide(
                                                              color: Colors
                                                                  .black26),
                                                      right: BorderSide(
                                                          color:
                                                              Colors.black26),
                                                      bottom: BorderSide(
                                                          color:
                                                              Colors.black26),
                                                      left: BorderSide(
                                                          color:
                                                              Colors.black26)),
                                                  columnWidths: const {
                                                    0: FixedColumnWidth(150.0),
                                                    1: FixedColumnWidth(200.0),
                                                    2: FixedColumnWidth(200.0),
                                                    3: FixedColumnWidth(200.0),
                                                  },
                                                  children: [
                                                    TableRow(children: [
                                                      Padding(
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                        child: Text(
                                                          'FDP Start',
                                                          style: TextStyle(
                                                            fontFamily: AppFont
                                                                .OutfitFont,
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0),
                                                        child: Container(
                                                          constraints:
                                                              const BoxConstraints(
                                                            minHeight: 10.0,
                                                            maxHeight: 100.0,
                                                          ),
                                                          child:
                                                              SingleChildScrollView(
                                                            child: TextField(
                                                              autocorrect:
                                                                  false,
                                                              enableSuggestions:
                                                                  false,
                                                              style: const TextStyle(
                                                                  fontSize:
                                                                      16.0,
                                                                  color: AppColor
                                                                      .textColor),
                                                              scrollPhysics:
                                                                  const NeverScrollableScrollPhysics(),
                                                              textCapitalization:
                                                                  TextCapitalization
                                                                      .characters,
                                                              controller:
                                                                  _Extension_actual_FDPstart_place,
                                                              decoration:
                                                                  const InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                contentPadding:
                                                                    EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            10.0),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0),
                                                        child: Container(
                                                          constraints:
                                                              const BoxConstraints(
                                                            minHeight: 10.0,
                                                            maxHeight: 100.0,
                                                          ),
                                                          child:
                                                              SingleChildScrollView(
                                                            child: TextField(
                                                              autocorrect:
                                                                  false,
                                                              enableSuggestions:
                                                                  false,
                                                              style: const TextStyle(
                                                                  fontSize:
                                                                      16.0,
                                                                  color: AppColor
                                                                      .textColor),
                                                              scrollPhysics:
                                                                  const NeverScrollableScrollPhysics(),
                                                              textCapitalization:
                                                                  TextCapitalization
                                                                      .characters,
                                                              controller:
                                                                  _Extension_actual_FDPstart_UTC,
                                                              readOnly: true,
                                                              onTap: () async {
                                                                TimeOfDay?
                                                                    pickedTime =
                                                                    await showTimePicker(
                                                                  context:
                                                                      context,
                                                                  initialTime:
                                                                      TimeOfDay
                                                                          .now(),
                                                                  builder:
                                                                      (context,
                                                                          child) {
                                                                    return MediaQuery(
                                                                      data: MediaQuery.of(
                                                                              context)
                                                                          .copyWith(
                                                                              alwaysUse24HourFormat: true),
                                                                      child:
                                                                          child!,
                                                                    );
                                                                  },
                                                                );

                                                                if (pickedTime !=
                                                                    null) {
                                                                  // Format the selected time and update the TextField
                                                                  String
                                                                      formattedTime =
                                                                      '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                                                                  _Extension_actual_FDPstart_UTC
                                                                          .text =
                                                                      formattedTime; // Update the controller's text

                                                                  _calculateTotalTime(
                                                                    _Extension_actual_FDPstart_UTC
                                                                        .text,
                                                                    _Extension_actual_FDPend_UTC
                                                                        .text,
                                                                    _Extension_actual_actual_FDP,
                                                                  );

                                                                  _calculateTotalTime(
                                                                    _Extension_schedule_allowedFDP.text,
                                                                    _Extension_actual_actual_FDP.text,

                                                                    _Extension_actual_FDP_exceed,
                                                                  );



                                                                }
                                                              },
                                                              decoration:
                                                                  const InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                contentPadding:
                                                                    EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            10.0),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0),
                                                        child: Container(
                                                          constraints:
                                                              const BoxConstraints(
                                                            minHeight: 10.0,
                                                            maxHeight: 100.0,
                                                          ),
                                                          child:
                                                              SingleChildScrollView(
                                                            child: TextField(
                                                              autocorrect:
                                                                  false,
                                                              enableSuggestions:
                                                                  false,
                                                              style: const TextStyle(
                                                                  fontSize:
                                                                      16.0,
                                                                  color: AppColor
                                                                      .textColor),
                                                              scrollPhysics:
                                                                  const NeverScrollableScrollPhysics(),
                                                              textCapitalization:
                                                                  TextCapitalization
                                                                      .characters,
                                                              controller:
                                                                  _Extension_actual_FDPstart_LT,
                                                              readOnly: true,
                                                              onTap: () async {
                                                                TimeOfDay?
                                                                    pickedTime =
                                                                    await showTimePicker(
                                                                  context:
                                                                      context,
                                                                  initialTime:
                                                                      TimeOfDay
                                                                          .now(),
                                                                  builder:
                                                                      (context,
                                                                          child) {
                                                                    return MediaQuery(
                                                                      data: MediaQuery.of(
                                                                              context)
                                                                          .copyWith(
                                                                              alwaysUse24HourFormat: true),
                                                                      child:
                                                                          child!,
                                                                    );
                                                                  },
                                                                );

                                                                if (pickedTime !=
                                                                    null) {
                                                                  // Format the selected time and update the TextField
                                                                  String
                                                                      formattedTime =
                                                                      '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                                                                  _Extension_actual_FDPstart_LT
                                                                          .text =
                                                                      formattedTime; // Update the controller's text
                                                                }
                                                              },
                                                              decoration:
                                                                  const InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                contentPadding:
                                                                    EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            10.0),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ]),
                                                  ],
                                                ),
                                                Table(
                                                  border: TableBorder(
                                                      horizontalInside:
                                                          BorderSide(
                                                              color: Colors
                                                                  .black26),
                                                      verticalInside:
                                                          BorderSide(
                                                              color: Colors
                                                                  .black26),
                                                      right: BorderSide(
                                                          color:
                                                              Colors.black26),
                                                      bottom: BorderSide(
                                                          color:
                                                              Colors.black26),
                                                      left: BorderSide(
                                                          color:
                                                              Colors.black26)),
                                                  columnWidths: const {
                                                    0: FixedColumnWidth(150.0),
                                                    1: FixedColumnWidth(200.0),
                                                    2: FixedColumnWidth(200.0),
                                                    3: FixedColumnWidth(200.0),
                                                  },
                                                  children: [
                                                    TableRow(children: [
                                                      Padding(
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                        child: Text(
                                                          'FDP End',
                                                          style: TextStyle(
                                                            fontFamily: AppFont
                                                                .OutfitFont,
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0),
                                                        child: Container(
                                                          constraints:
                                                              const BoxConstraints(
                                                            minHeight: 10.0,
                                                            maxHeight: 100.0,
                                                          ),
                                                          child:
                                                              SingleChildScrollView(
                                                            child: TextField(
                                                              autocorrect:
                                                                  false,
                                                              enableSuggestions:
                                                                  false,
                                                              style: const TextStyle(
                                                                  fontSize:
                                                                      16.0,
                                                                  color: AppColor
                                                                      .textColor),
                                                              scrollPhysics:
                                                                  const NeverScrollableScrollPhysics(),
                                                              textCapitalization:
                                                                  TextCapitalization
                                                                      .characters,
                                                              controller:
                                                                  _Extension_actual_FDPend_place,
                                                              decoration:
                                                                  const InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                contentPadding:
                                                                    EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            10.0),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0),
                                                        child: Container(
                                                          constraints:
                                                              const BoxConstraints(
                                                            minHeight: 10.0,
                                                            maxHeight: 100.0,
                                                          ),
                                                          child:
                                                              SingleChildScrollView(
                                                            child: TextField(
                                                              autocorrect:
                                                                  false,
                                                              enableSuggestions:
                                                                  false,
                                                              style: const TextStyle(
                                                                  fontSize:
                                                                      16.0,
                                                                  color: AppColor
                                                                      .textColor),
                                                              scrollPhysics:
                                                                  const NeverScrollableScrollPhysics(),
                                                              textCapitalization:
                                                                  TextCapitalization
                                                                      .characters,
                                                              controller:
                                                                  _Extension_actual_FDPend_UTC,
                                                              readOnly: true,
                                                              onTap: () async {
                                                                TimeOfDay?
                                                                    pickedTime =
                                                                    await showTimePicker(
                                                                  context:
                                                                      context,
                                                                  initialTime:
                                                                      TimeOfDay
                                                                          .now(),
                                                                  builder:
                                                                      (context,
                                                                          child) {
                                                                    return MediaQuery(
                                                                      data: MediaQuery.of(
                                                                              context)
                                                                          .copyWith(
                                                                              alwaysUse24HourFormat: true),
                                                                      child:
                                                                          child!,
                                                                    );
                                                                  },
                                                                );

                                                                if (pickedTime !=
                                                                    null) {
                                                                  // Format the selected time and update the TextField
                                                                  String
                                                                      formattedTime =
                                                                      '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                                                                  _Extension_actual_FDPend_UTC
                                                                          .text =
                                                                      formattedTime; // Update the controller's text

                                                                  _calculateTotalTime(
                                                                    _Extension_actual_FDPstart_UTC.text,
                                                                    _Extension_actual_FDPend_UTC.text,
                                                                    _Extension_actual_actual_FDP,
                                                                  );

                                                                  _calculateTotalTime(
                                                                    _Extension_schedule_allowedFDP.text,
                                                                    _Extension_actual_actual_FDP.text,
                                                                    _Extension_actual_FDP_exceed,
                                                                  );

                                                                }
                                                              },
                                                              decoration:
                                                                  const InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                contentPadding:
                                                                    EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            10.0),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0),
                                                        child: Container(
                                                          constraints:
                                                              const BoxConstraints(
                                                            minHeight: 10.0,
                                                            maxHeight: 100.0,
                                                          ),
                                                          child:
                                                              SingleChildScrollView(
                                                            child: TextField(
                                                              autocorrect:
                                                                  false,
                                                              enableSuggestions:
                                                                  false,
                                                              style: const TextStyle(
                                                                  fontSize:
                                                                      16.0,
                                                                  color: AppColor
                                                                      .textColor),
                                                              scrollPhysics:
                                                                  const NeverScrollableScrollPhysics(),
                                                              textCapitalization:
                                                                  TextCapitalization
                                                                      .characters,
                                                              controller:
                                                                  _Extension_actual_FDPend_LT,
                                                              readOnly: true,
                                                              onTap: () async {
                                                                TimeOfDay?
                                                                    pickedTime =
                                                                    await showTimePicker(
                                                                  context:
                                                                      context,
                                                                  initialTime:
                                                                      TimeOfDay
                                                                          .now(),
                                                                  builder:
                                                                      (context,
                                                                          child) {
                                                                    return MediaQuery(
                                                                      data: MediaQuery.of(
                                                                              context)
                                                                          .copyWith(
                                                                              alwaysUse24HourFormat: true),
                                                                      child:
                                                                          child!,
                                                                    );
                                                                  },
                                                                );

                                                                if (pickedTime !=
                                                                    null) {
                                                                  // Format the selected time and update the TextField
                                                                  String
                                                                      formattedTime =
                                                                      '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                                                                  _Extension_actual_FDPend_LT
                                                                          .text =
                                                                      formattedTime; // Update the controller's text
                                                                }
                                                              },
                                                              decoration:
                                                                  const InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                contentPadding:
                                                                    EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            10.0),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ]),
                                                  ],
                                                ),
                                                Table(
                                                  border: TableBorder(
                                                      horizontalInside:
                                                          BorderSide(
                                                              color: Colors
                                                                  .black26),
                                                      verticalInside:
                                                          BorderSide(
                                                              color: Colors
                                                                  .black26),
                                                      right: BorderSide(
                                                          color:
                                                              Colors.black26),
                                                      bottom: BorderSide(
                                                          color:
                                                              Colors.black26),
                                                      left: BorderSide(
                                                          color:
                                                              Colors.black26)),
                                                  columnWidths: const {
                                                    0: FixedColumnWidth(350.0),
                                                    1: FixedColumnWidth(400.0),
                                                  },
                                                  children: [
                                                    TableRow(children: [
                                                      Padding(
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                        child: Text(
                                                          'Actual FDP',
                                                          style: TextStyle(
                                                            fontFamily: AppFont
                                                                .OutfitFont,
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0),
                                                        child: Container(
                                                          constraints:
                                                              const BoxConstraints(
                                                            minHeight: 10.0,
                                                            maxHeight: 100.0,
                                                          ),
                                                          child:
                                                              SingleChildScrollView(
                                                            child: TextField(
                                                              autocorrect:
                                                                  false,
                                                              enableSuggestions:
                                                                  false,
                                                              style: const TextStyle(
                                                                  fontSize:
                                                                      16.0,
                                                                  color: AppColor
                                                                      .textColor),
                                                              scrollPhysics:
                                                                  const NeverScrollableScrollPhysics(),
                                                              textCapitalization:
                                                                  TextCapitalization
                                                                      .characters,
                                                              controller:
                                                                  _Extension_actual_actual_FDP,
                                                              readOnly: true,
                                                              decoration:
                                                                  const InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                contentPadding:
                                                                    EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            10.0),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ]),
                                                  ],
                                                ),
                                                Table(
                                                  border: TableBorder(
                                                      horizontalInside:
                                                          BorderSide(
                                                              color: Colors
                                                                  .black26),
                                                      verticalInside:
                                                          BorderSide(
                                                              color: Colors
                                                                  .black26),
                                                      right: BorderSide(
                                                          color:
                                                              Colors.black26),
                                                      bottom: BorderSide(
                                                          color:
                                                              Colors.black26),
                                                      left: BorderSide(
                                                          color:
                                                              Colors.black26)),
                                                  columnWidths: const {
                                                    0: FixedColumnWidth(350.0),
                                                    1: FixedColumnWidth(400.0),
                                                  },
                                                  children: [
                                                    TableRow(children: [
                                                      Padding(
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                        child: Text(
                                                          'FDP Exceedance',
                                                          style: TextStyle(
                                                            fontFamily: AppFont
                                                                .OutfitFont,
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0),
                                                        child: Container(
                                                          constraints:
                                                              const BoxConstraints(
                                                            minHeight: 10.0,
                                                            maxHeight: 100.0,
                                                          ),
                                                          child:
                                                              SingleChildScrollView(
                                                            child:
                                                             

                                                            TextField(
                                                              autocorrect:
                                                                  false,
                                                              enableSuggestions:
                                                                  false,
                                                              style: const TextStyle(
                                                                  fontSize:
                                                                      16.0,
                                                                  color: AppColor
                                                                      .textColor),
                                                              scrollPhysics:
                                                                  const NeverScrollableScrollPhysics(),
                                                              textCapitalization:
                                                                  TextCapitalization
                                                                      .characters,
                                                              controller:
                                                                  _Extension_actual_FDP_exceed,
                                                              readOnly: true,
                                                              decoration:
                                                                  const InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                contentPadding:
                                                                    EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            10.0),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ]),
                                                  ],
                                                ),
                                                const SizedBox(height: 15),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Commander's Reason For Extension",
                                                            style: TextStyle(
                                                              fontFamily: AppFont
                                                                  .OutfitFont,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 5),
                                                          Container(
                                                            // height:200,
                                                            constraints:
                                                                const BoxConstraints(
                                                              minHeight:
                                                                  60.0, // Increased minHeight
                                                              maxHeight:
                                                                  150.0, // Increased maxHeight
                                                            ),
                                                            child:
                                                                SingleChildScrollView(
                                                              child: TextField(
                                                                autocorrect:
                                                                    false,
                                                                enableSuggestions:
                                                                    false,
                                                                maxLines:
                                                                    3, // Allow the TextField to expand vertically
                                                                textCapitalization:
                                                                    TextCapitalization
                                                                        .characters,
                                                                controller:
                                                                    _Extension_commanders_reason,
                                                                decoration:
                                                                    InputDecoration(
                                                                  hintStyle:
                                                                      const TextStyle(
                                                                          color:
                                                                              Color(0xFFCACAC9)),
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12),
                                                                    borderSide:
                                                                        const BorderSide(
                                                                            color:
                                                                                Color(0xFFCACAC9)),
                                                                  ),
                                                                  focusedBorder:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12),
                                                                    borderSide:
                                                                        const BorderSide(
                                                                            color:
                                                                                Color(0xFF626262)),
                                                                  ),
                                                                  enabledBorder:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12),
                                                                    borderSide:
                                                                        const BorderSide(
                                                                            color:
                                                                                Color(0xFFCACAC9)),
                                                                  ),
                                                                  contentPadding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              16), // Add padding inside the TextField
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                    const SizedBox(
                                                        width:
                                                            16), // Spacing between fields
                                                    // Right Side Fields (Date and Number)
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        const SizedBox(
                                                            height: 20),
                                                        SizedBox(
                                                          width: 120,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const SizedBox(
                                                                  width: 5),
                                                              Text(
                                                                'Signature',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      AppFont
                                                                          .OutfitFont,
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                              Checkbox(
                                                                value:
                                                                    _Extension_Commanders_check,
                                                                activeColor:
                                                                    AppColor
                                                                        .primaryColor,
                                                                checkColor:
                                                                    Colors
                                                                        .white,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  side:
                                                                      const BorderSide(
                                                                    color: Colors
                                                                        .grey,
                                                                    width: 1.0,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              4.0),
                                                                ),
                                                                onChanged:
                                                                    (bool?
                                                                        value) {
                                                                  setState(() {
                                                                    _Extension_Commanders_check =
                                                                        value ??
                                                                            false;
                                                                  });
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 120,
                                                          child: TextField(
                                                            autocorrect: false,
                                                            enableSuggestions:
                                                                false,
                                                            readOnly: true,
                                                            textCapitalization:
                                                                TextCapitalization
                                                                    .characters,
                                                            controller:
                                                                TextEditingController(
                                                                    text:
                                                                        currentDate),
                                                            decoration:
                                                                InputDecoration(
                                                              hintText: 'Date',
                                                              hintStyle: const TextStyle(
                                                                  color: Color(
                                                                      0xFFCACAC9)),
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFF626262)),
                                                              ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                              contentPadding:
                                                                  EdgeInsets.symmetric(
                                                                      vertical:
                                                                          8,
                                                                      horizontal:
                                                                          8),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 15),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Operator's Remarks/Actions taken",
                                                            style: TextStyle(
                                                              fontFamily: AppFont
                                                                  .OutfitFont,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 5),
                                                          Container(
                                                            // height:200,
                                                            constraints:
                                                                const BoxConstraints(
                                                              minHeight:
                                                                  60.0, // Increased minHeight
                                                              maxHeight:
                                                                  150.0, // Increased maxHeight
                                                            ),
                                                            child:
                                                                SingleChildScrollView(
                                                              child: TextField(
                                                                autocorrect:
                                                                    false,
                                                                enableSuggestions:
                                                                    false,
                                                                maxLines:
                                                                    3, // Allow the TextField to expand vertically
                                                                textCapitalization:
                                                                    TextCapitalization
                                                                        .characters,
                                                                controller:
                                                                    _Extension_operators_remark,
                                                                decoration:
                                                                    InputDecoration(
                                                                  hintStyle:
                                                                      const TextStyle(
                                                                          color:
                                                                              Color(0xFFCACAC9)),
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12),
                                                                    borderSide:
                                                                        const BorderSide(
                                                                            color:
                                                                                Color(0xFFCACAC9)),
                                                                  ),
                                                                  focusedBorder:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12),
                                                                    borderSide:
                                                                        const BorderSide(
                                                                            color:
                                                                                Color(0xFF626262)),
                                                                  ),
                                                                  enabledBorder:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12),
                                                                    borderSide:
                                                                        const BorderSide(
                                                                            color:
                                                                                Color(0xFFCACAC9)),
                                                                  ),
                                                                  contentPadding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              16), // Add padding inside the TextField
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                    const SizedBox(
                                                        width:
                                                            16), // Spacing between fields
                                                    // Right Side Fields (Date and Number)
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        const SizedBox(
                                                            height: 20),
                                                        SizedBox(
                                                          width: 120,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const SizedBox(
                                                                  width: 5),
                                                              Text(
                                                                'Signature',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      AppFont
                                                                          .OutfitFont,
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                              Checkbox(
                                                                value:
                                                                    _Extension_Operators_check,
                                                                activeColor:
                                                                    AppColor
                                                                        .primaryColor,
                                                                checkColor:
                                                                    Colors
                                                                        .white,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  side:
                                                                      const BorderSide(
                                                                    color: Colors
                                                                        .grey,
                                                                    width: 1.0,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              4.0),
                                                                ),
                                                                onChanged:
                                                                    (bool?
                                                                        value) {
                                                                  setState(() {
                                                                    _Extension_Operators_check =
                                                                        value ??
                                                                            false;
                                                                  });
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 120,
                                                          child: TextField(
                                                            autocorrect: false,
                                                            enableSuggestions:
                                                                false,
                                                            readOnly: true,
                                                            textCapitalization:
                                                                TextCapitalization
                                                                    .characters,
                                                            controller:
                                                                TextEditingController(
                                                                    text:
                                                                        currentDate),
                                                            decoration:
                                                                InputDecoration(
                                                              hintText: 'Date',
                                                              hintStyle: const TextStyle(
                                                                  color: Color(
                                                                      0xFFCACAC9)),
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFF626262)),
                                                              ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12),
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                              ),
                                                              contentPadding:
                                                                  EdgeInsets.symmetric(
                                                                      vertical:
                                                                          8,
                                                                      horizontal:
                                                                          8),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),

                                                SizedBox(height: 20),

                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      "FO/FOR/RW/58",
                                                      style: TextStyle(
                                                        fontFamily: AppFont.OutfitFont,
                                                        color: Colors.black,
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                    Text(
                                                      "Rev.2",
                                                      style: TextStyle(
                                                        fontFamily: AppFont.OutfitFont,
                                                        color: Colors.black,
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                    Text(
                                                      "05 JAN 2024",
                                                      style: TextStyle(
                                                        fontFamily: AppFont.OutfitFont,
                                                        color: Colors.black,
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                const SizedBox(height: 20),

                                                if (extensionStatus !=
                                                    'completed') ...[

                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
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
                                                                MaterialStateProperty
                                                                    .resolveWith(
                                                                        (states) {
                                                              if (states.contains(
                                                                  MaterialState
                                                                      .pressed)) {
                                                                return Colors
                                                                    .white; // Text color when pressed
                                                              }
                                                              return Color(
                                                                  0xFFAA182C); // Text color when not pressed
                                                            }),
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .resolveWith(
                                                                        (states) {
                                                              if (states.contains(
                                                                  MaterialState
                                                                      .pressed)) {
                                                                return Color(
                                                                    0xFFAA182C); // Background color when pressed
                                                              }
                                                              return Colors
                                                                  .white; // Background color when not pressed
                                                            }),
                                                            side: MaterialStateProperty
                                                                .all(BorderSide(
                                                                    color: Color(
                                                                        0xFFAA182C),
                                                                    width:
                                                                        1)), // Red outline
                                                            padding:
                                                                MaterialStateProperty.all(
                                                                    const EdgeInsets
                                                                        .all(
                                                                        13.0)),
                                                            shape:
                                                                MaterialStateProperty
                                                                    .all(
                                                              RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                            ),
                                                          ),
                                                          child: Text(
                                                            'Back',
                                                            style: TextStyle(
                                                              fontFamily: AppFont
                                                                  .OutfitFont,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 10),
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.7,
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            if (!_Extension_Commanders_check) {
                                                              EasyLoading.showInfo(
                                                                  'Please Commanders sign in to continue');
                                                            } else {
                                                              if (!_Extension_Operators_check) {
                                                                EasyLoading
                                                                    .showInfo(
                                                                        'Please Operators sign in to continue');
                                                              } else {
                                                                showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return AlertDialog(
                                                                      title: Text(
                                                                          'Confirmation'),
                                                                      content: Text(
                                                                          'Do you want to save your changes?'),
                                                                      actions: <Widget>[
                                                                        TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            // Close the dialog without saving
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                          child:
                                                                              Text('No'),
                                                                        ),
                                                                        TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            _saveExtensionForm('extension');
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                          child:
                                                                              Text('Yes'),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  },
                                                                );
                                                              }
                                                            }
                                                          },
                                                          style: ButtonStyle(
                                                            foregroundColor:
                                                                WidgetStateProperty
                                                                    .resolveWith(
                                                                        (states) {
                                                              if (states.contains(
                                                                  WidgetState
                                                                      .pressed)) {
                                                                return Colors
                                                                    .white70;
                                                              }
                                                              return Colors
                                                                  .white;
                                                            }),
                                                            backgroundColor:
                                                                WidgetStateProperty
                                                                    .resolveWith(
                                                                        (states) {
                                                              if (states.contains(
                                                                  WidgetState
                                                                      .pressed)) {
                                                                return (Color(
                                                                    0xFFE8374F));
                                                              }
                                                              return (Color(
                                                                  0xFFAA182C));
                                                            }),
                                                            padding:
                                                                WidgetStateProperty.all(
                                                                    const EdgeInsets
                                                                        .all(
                                                                        13.0)),
                                                            shape:
                                                                WidgetStateProperty
                                                                    .all(
                                                              RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                            ),
                                                          ),
                                                          child: Text(
                                                            'Save',
                                                            style: TextStyle(
                                                              fontFamily: AppFont
                                                                  .OutfitFont,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ]
                                              ],
                                            ),
                                          )
                                      
                                        ]),
                                        Column(children: [
                                            const SizedBox(height: 20),
                                            Center(
                                              child: Column(
                                                children: [
                                                  Table(
                                                    border: TableBorder.all(
                                                        color: Colors.black26),
                                                    columnWidths: const {
                                                      0: FixedColumnWidth(80.0),
                                                      1: FixedColumnWidth(
                                                          120.0),
                                                      2: FixedColumnWidth(
                                                          120.0),
                                                      3: FixedColumnWidth(
                                                          120.0),
                                                      4: FixedColumnWidth(
                                                          160.0),
                                                      5: FixedColumnWidth(
                                                          150.0),
                                                    },
                                                    children: [
                                                      TableRow(children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10.0),
                                                          child: Text(
                                                            'DATE',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontFamily: AppFont
                                                                  .OutfitFont,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(0),
                                                          child: Container(
                                                            constraints:
                                                                const BoxConstraints(
                                                              minHeight: 10.0,
                                                              maxHeight: 100.0,
                                                            ),
                                                            child:
                                                                SingleChildScrollView(
                                                              child: TextField(
                                                                autocorrect:
                                                                    false,
                                                                enableSuggestions:
                                                                    false,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        16.0,
                                                                    color: AppColor
                                                                        .textColor),
                                                                scrollPhysics:
                                                                    const NeverScrollableScrollPhysics(),
                                                                readOnly: true,
                                                                textCapitalization:
                                                                    TextCapitalization
                                                                        .characters,
                                                                controller:
                                                                    TextEditingController(
                                                                        text:
                                                                            currentDate),
                                                                decoration:
                                                                    const InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  contentPadding:
                                                                      EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              10.0),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10.0),
                                                          child: Text(
                                                            'Aircraft Type',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontFamily: AppFont
                                                                  .OutfitFont,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(0),
                                                          child: Container(
                                                            constraints:
                                                                const BoxConstraints(
                                                              minHeight: 10.0,
                                                              maxHeight: 100.0,
                                                            ),
                                                            child:
                                                                SingleChildScrollView(
                                                              child: TextField(
                                                                autocorrect:
                                                                    false,
                                                                enableSuggestions:
                                                                    false,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        16.0,
                                                                    color: AppColor
                                                                        .textColor),
                                                                scrollPhysics:
                                                                    const NeverScrollableScrollPhysics(),
                                                                textCapitalization:
                                                                    TextCapitalization
                                                                        .characters,
                                                                controller:
                                                                    TextEditingController(
                                                                        text:
                                                                            selectMaingroup),
                                                                decoration:
                                                                    const InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  contentPadding:
                                                                      EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              10.0),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10.0),
                                                          child: Text(
                                                            'Aircraft Registration',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontFamily: AppFont
                                                                  .OutfitFont,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(0),
                                                          child: Container(
                                                            constraints:
                                                                const BoxConstraints(
                                                              minHeight: 10.0,
                                                              maxHeight: 100.0,
                                                            ),
                                                            child:
                                                                SingleChildScrollView(
                                                              child: TextField(
                                                                autocorrect:
                                                                    false,
                                                                enableSuggestions:
                                                                    false,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        16.0,
                                                                    color: AppColor
                                                                        .textColor),
                                                                scrollPhysics:
                                                                    const NeverScrollableScrollPhysics(),
                                                                textCapitalization:
                                                                    TextCapitalization
                                                                        .characters,
                                                                controller:
                                                                    TextEditingController(
                                                                        text:
                                                                            selectedGroupName),
                                                                decoration:
                                                                    const InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  contentPadding:
                                                                      EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              10.0),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ]),
                                                    ],
                                                  ),
                                                  Table(
                                                    border: TableBorder(
                                                        horizontalInside:
                                                            BorderSide(
                                                                color: Colors
                                                                    .black26),
                                                        verticalInside:
                                                            BorderSide(
                                                                color: Colors
                                                                    .black26),
                                                        right: BorderSide(
                                                            color:
                                                                Colors.black26),
                                                        left: BorderSide(
                                                            color: Colors
                                                                .black26)),
                                                    columnWidths: const {
                                                      0: FixedColumnWidth(
                                                          200.0),
                                                      1: FixedColumnWidth(
                                                          550.0),
                                                    },
                                                    children: [
                                                      TableRow(children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10.0),
                                                          child: Text(
                                                            'Commander’s Name',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontFamily: AppFont
                                                                  .OutfitFont,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(0),
                                                          child: Container(
                                                            constraints:
                                                                const BoxConstraints(
                                                              minHeight: 10.0,
                                                              maxHeight: 100.0,
                                                            ),
                                                            child:
                                                                SingleChildScrollView(
                                                              child: TextField(
                                                                autocorrect:
                                                                    false,
                                                                enableSuggestions:
                                                                    false,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16.0,
                                                                    color: AppColor
                                                                        .textColor),
                                                                scrollPhysics:
                                                                    NeverScrollableScrollPhysics(),
                                                                textCapitalization:
                                                                    TextCapitalization
                                                                        .characters,
                                                                controller:
                                                                    _Reduced_commandersname,
                                                                decoration:
                                                                    InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  contentPadding:
                                                                      EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              10.0),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ]),
                                                    ],
                                                  ),
                                                  Table(
                                                    border: TableBorder.all(
                                                        color: Colors.black26),
                                                    columnWidths: const {
                                                      0: FixedColumnWidth(
                                                          200.0),
                                                      1: FixedColumnWidth(
                                                          120.0),
                                                      2: FixedColumnWidth(
                                                          140.0),
                                                      3: FixedColumnWidth(
                                                          120.0),
                                                      4: FixedColumnWidth(
                                                          170.0),
                                                    },
                                                    children: [
                                                      TableRow(children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10.0),
                                                          child: Text(
                                                            'Crew Involved in Discretion',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontFamily: AppFont
                                                                  .OutfitFont,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10.0),
                                                          child: Text(
                                                            'PIC',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontFamily: AppFont
                                                                  .OutfitFont,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(0),
                                                          child: Container(
                                                            constraints:
                                                                const BoxConstraints(
                                                              minHeight: 10.0,
                                                              maxHeight: 100.0,
                                                            ),
                                                            child:
                                                                SingleChildScrollView(
                                                              child: TextField(
                                                                autocorrect:
                                                                    false,
                                                                enableSuggestions:
                                                                    false,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16.0,
                                                                    color: AppColor
                                                                        .textColor),
                                                                scrollPhysics:
                                                                    NeverScrollableScrollPhysics(),
                                                                textCapitalization:
                                                                    TextCapitalization
                                                                        .characters,
                                                                controller:
                                                                    _Reduced_crew_involved_PIC,
                                                                decoration:
                                                                    InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  contentPadding:
                                                                      EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              10.0),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10.0),
                                                          child: Text(
                                                            'SIC',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontFamily: AppFont
                                                                  .OutfitFont,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(0),
                                                          child: Container(
                                                            constraints:
                                                                const BoxConstraints(
                                                              minHeight: 10.0,
                                                              maxHeight: 100.0,
                                                            ),
                                                            child:
                                                                SingleChildScrollView(
                                                              child: TextField(
                                                                autocorrect:
                                                                    false,
                                                                enableSuggestions:
                                                                    false,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16.0,
                                                                    color: AppColor
                                                                        .textColor),
                                                                scrollPhysics:
                                                                    NeverScrollableScrollPhysics(),
                                                                textCapitalization:
                                                                    TextCapitalization
                                                                        .characters,
                                                                controller:
                                                                    _Reduced_crew_involved_SIC,
                                                                decoration:
                                                                    InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  contentPadding:
                                                                      EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              10.0),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ]),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 15),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        // Wrap this in an Expanded widget
                                                        child: Container(
                                                          child: RichText(
                                                            text: TextSpan(
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                fontFamily: AppFont
                                                                    .OutfitFont,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .black, // Default color
                                                              ),
                                                              children: [
                                                                TextSpan(
                                                                  text:
                                                                      'An aircraft commander may take discretion to reduce rest after considering the below points: \n',
                                                                ),
                                                                TextSpan(
                                                                  text:
                                                                      ' (Please check on the below ☑)',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .red), // Change this to red
                                                                ),
                                                              ],
                                                            ),
                                                            textAlign:
                                                                TextAlign.left,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Card(
                                                    elevation: 0,
                                                    color: Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      side: BorderSide(
                                                        color: Colors.grey,
                                                        width: 0.5,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              20.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Checkbox(
                                                                    value:
                                                                        _Reduced_Commander_Point1,
                                                                    activeColor:
                                                                        AppColor
                                                                            .primaryColor,
                                                                    checkColor:
                                                                        Colors
                                                                            .white,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      side:
                                                                          const BorderSide(
                                                                        color: Colors
                                                                            .grey,
                                                                        width:
                                                                            1.0,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              4.0),
                                                                    ),
                                                                    onChanged:
                                                                        (bool?
                                                                            value) {
                                                                      setState(
                                                                          () {
                                                                        _Reduced_Commander_Point1 =
                                                                            value ??
                                                                                false;
                                                                      });
                                                                    },
                                                                  ),
                                                                  Expanded(
                                                                      child:
                                                                          Text(
                                                                    'Taking note of the circumstances of other members of the crew to reduce the rest period.',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontFamily:
                                                                          AppFont
                                                                              .OutfitFont,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: Colors
                                                                          .black, // Default color
                                                                    ),
                                                                  )), // Text next to checkbox
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Checkbox(
                                                                    value:
                                                                        _Reduced_Commander_Point2,
                                                                    activeColor:
                                                                        AppColor
                                                                            .primaryColor,
                                                                    checkColor:
                                                                        Colors
                                                                            .white,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      side:
                                                                          const BorderSide(
                                                                        color: Colors
                                                                            .grey,
                                                                        width:
                                                                            1.0,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              4.0),
                                                                    ),
                                                                    onChanged:
                                                                        (bool?
                                                                            value) {
                                                                      setState(
                                                                          () {
                                                                        _Reduced_Commander_Point2 =
                                                                            value ??
                                                                                false;
                                                                      });
                                                                    },
                                                                  ),
                                                                  Expanded(
                                                                      child:
                                                                          Text(
                                                                    'Reduced Rest Period is not used to reduce successive rest periods.',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontFamily:
                                                                          AppFont
                                                                              .OutfitFont,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: Colors
                                                                          .black, // Default color
                                                                    ),
                                                                  )), // Text next to checkbox
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Checkbox(
                                                                    value:
                                                                        _Reduced_Commander_Point3,
                                                                    activeColor:
                                                                        AppColor
                                                                            .primaryColor,
                                                                    checkColor:
                                                                        Colors
                                                                            .white,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      side:
                                                                          const BorderSide(
                                                                        color: Colors
                                                                            .grey,
                                                                        width:
                                                                            1.0,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              4.0),
                                                                    ),
                                                                    onChanged:
                                                                        (bool?
                                                                            value) {
                                                                      setState(
                                                                          () {
                                                                        _Reduced_Commander_Point3 =
                                                                            value ??
                                                                                false;
                                                                      });
                                                                    },
                                                                  ),
                                                                  Expanded(
                                                                      child:
                                                                          Text(
                                                                    'If the preceding FDP was extended then, the rest period may be reduced provided that the subsequent allowable FDP is also reduced by the same amount.',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontFamily:
                                                                          AppFont
                                                                              .OutfitFont,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: Colors
                                                                          .black, // Default color
                                                                    ),
                                                                  )), // Text next to checkbox
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Checkbox(
                                                                    value:
                                                                        _Reduced_Commander_Point4,
                                                                    activeColor:
                                                                        AppColor
                                                                            .primaryColor,
                                                                    checkColor:
                                                                        Colors
                                                                            .white,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      side:
                                                                          const BorderSide(
                                                                        color: Colors
                                                                            .grey,
                                                                        width:
                                                                            1.0,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              4.0),
                                                                    ),
                                                                    onChanged:
                                                                        (bool?
                                                                            value) {
                                                                      setState(
                                                                          () {
                                                                        _Reduced_Commander_Point4 =
                                                                            value ??
                                                                                false;
                                                                      });
                                                                    },
                                                                  ),
                                                                  Expanded(
                                                                      child:
                                                                          Text(
                                                                    'In NO circumstances, may a commander exercise discretion to reduce a rest period below 10 hours.',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontFamily:
                                                                          AppFont
                                                                              .OutfitFont,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: Colors
                                                                          .black, // Default color
                                                                    ),
                                                                  )), // Text next to checkbox
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Checkbox(
                                                                    value:
                                                                        _Reduced_Commander_Point5,
                                                                    activeColor:
                                                                        AppColor
                                                                            .primaryColor,
                                                                    checkColor:
                                                                        Colors
                                                                            .white,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      side:
                                                                          const BorderSide(
                                                                        color: Colors
                                                                            .grey,
                                                                        width:
                                                                            1.0,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              4.0),
                                                                    ),
                                                                    onChanged:
                                                                        (bool?
                                                                            value) {
                                                                      setState(
                                                                          () {
                                                                        _Reduced_Commander_Point5 =
                                                                            value ??
                                                                                false;
                                                                      });
                                                                    },
                                                                  ),
                                                                  Expanded(
                                                                      child:
                                                                          Text(
                                                                    'This Discretion is taken due to emergency and NOT due to any commercial practices.',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontFamily:
                                                                          AppFont
                                                                              .OutfitFont,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: Colors
                                                                          .black, // Default color
                                                                    ),
                                                                  )), // Text next to checkbox
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 15),
                                                  Table(
                                                    border: TableBorder(
                                                        horizontalInside:
                                                            BorderSide(
                                                                color: Colors
                                                                    .black26),
                                                        verticalInside:
                                                            BorderSide(
                                                                color: Colors
                                                                    .black26),
                                                        right: BorderSide(
                                                            color:
                                                                Colors.black26),
                                                        bottom: BorderSide(
                                                            color:
                                                                Colors.black26),
                                                        top: BorderSide(
                                                            color:
                                                                Colors.black26),
                                                        left: BorderSide(
                                                            color: Colors
                                                                .black26)),
                                                    columnWidths: const {
                                                      0: FixedColumnWidth(
                                                          350.0),
                                                      1: FixedColumnWidth(
                                                          200.0),
                                                      2: FixedColumnWidth(
                                                          200.0),
                                                    },
                                                    children: [
                                                      TableRow(children: [
                                                        Container(),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10.0),
                                                          child: Text(
                                                            'UTC** (hh:mm)',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontFamily: AppFont
                                                                  .OutfitFont,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10.0),
                                                          child: Text(
                                                            'LT (hh:mm)',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontFamily: AppFont
                                                                  .OutfitFont,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                      ]),
                                                    ],
                                                  ),
                                                  Table(
                                                    border: TableBorder(
                                                        horizontalInside:
                                                            BorderSide(
                                                                color: Colors
                                                                    .black26),
                                                        verticalInside:
                                                            BorderSide(
                                                                color: Colors
                                                                    .black26),
                                                        right: BorderSide(
                                                            color:
                                                                Colors.black26),
                                                        bottom: BorderSide(
                                                            color:
                                                                Colors.black26),
                                                        left: BorderSide(
                                                            color: Colors
                                                                .black26)),
                                                    columnWidths: const {
                                                      0: FixedColumnWidth(
                                                          350.0),
                                                      1: FixedColumnWidth(
                                                          200.0),
                                                      2: FixedColumnWidth(
                                                          200.0),
                                                    },
                                                    children: [
                                                      TableRow(children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10.0),
                                                          child: Text(
                                                            'Last duty Started',
                                                            style: TextStyle(
                                                              fontFamily: AppFont
                                                                  .OutfitFont,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(0),
                                                          child: Container(
                                                            constraints:
                                                                const BoxConstraints(
                                                              minHeight: 10.0,
                                                              maxHeight: 100.0,
                                                            ),
                                                            child:
                                                                SingleChildScrollView(
                                                              child: TextField(
                                                                autocorrect:
                                                                    false,
                                                                enableSuggestions:
                                                                    false,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16.0,
                                                                    color: AppColor
                                                                        .textColor),
                                                                scrollPhysics:
                                                                    NeverScrollableScrollPhysics(),
                                                                textCapitalization:
                                                                    TextCapitalization
                                                                        .characters,
                                                                controller:
                                                                    _Reduced_lastdutystarted_UTC,
                                                                readOnly: true,
                                                                onTap:
                                                                    () async {
                                                                  TimeOfDay?
                                                                      pickedTime =
                                                                      await showTimePicker(
                                                                    context:
                                                                        context,
                                                                    initialTime:
                                                                        TimeOfDay
                                                                            .now(),
                                                                    builder:
                                                                        (context,
                                                                            child) {
                                                                      return MediaQuery(
                                                                        data: MediaQuery.of(context).copyWith(
                                                                            alwaysUse24HourFormat:
                                                                                true),
                                                                        child:
                                                                            child!,
                                                                      );
                                                                    },
                                                                  );

                                                                  if (pickedTime !=
                                                                      null) {
                                                                    // Format the selected time and update the TextField
                                                                    String
                                                                        formattedTime =
                                                                        '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                                                                    _Reduced_lastdutystarted_UTC
                                                                            .text =
                                                                        formattedTime; // Update the controller's text
                                                                  }
                                                                },
                                                                decoration:
                                                                    InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  contentPadding:
                                                                      EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              10.0),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(0),
                                                          child: Container(
                                                            constraints:
                                                                const BoxConstraints(
                                                              minHeight: 10.0,
                                                              maxHeight: 100.0,
                                                            ),
                                                            child:
                                                                SingleChildScrollView(
                                                              child: TextField(
                                                                autocorrect:
                                                                    false,
                                                                enableSuggestions:
                                                                    false,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16.0,
                                                                    color: AppColor
                                                                        .textColor),
                                                                scrollPhysics:
                                                                    NeverScrollableScrollPhysics(),
                                                                textCapitalization:
                                                                    TextCapitalization
                                                                        .characters,
                                                                controller:
                                                                    _Reduced_lastdutystarted_LT,
                                                                readOnly: true,
                                                                onTap:
                                                                    () async {
                                                                  TimeOfDay?
                                                                      pickedTime =
                                                                      await showTimePicker(
                                                                    context:
                                                                        context,
                                                                    initialTime:
                                                                        TimeOfDay
                                                                            .now(),
                                                                    builder:
                                                                        (context,
                                                                            child) {
                                                                      return MediaQuery(
                                                                        data: MediaQuery.of(context).copyWith(
                                                                            alwaysUse24HourFormat:
                                                                                true),
                                                                        child:
                                                                            child!,
                                                                      );
                                                                    },
                                                                  );

                                                                  if (pickedTime !=
                                                                      null) {
                                                                    // Format the selected time and update the TextField
                                                                    String
                                                                        formattedTime =
                                                                        '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                                                                    _Reduced_lastdutystarted_LT
                                                                            .text =
                                                                        formattedTime; // Update the controller's text
                                                                  }
                                                                },
                                                                decoration:
                                                                    InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  contentPadding:
                                                                      EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              10.0),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ]),
                                                    ],
                                                  ),
                                                  Table(
                                                    border: TableBorder(
                                                        horizontalInside:
                                                            BorderSide(
                                                                color: Colors
                                                                    .black26),
                                                        verticalInside:
                                                            BorderSide(
                                                                color: Colors
                                                                    .black26),
                                                        right: BorderSide(
                                                            color:
                                                                Colors.black26),
                                                        bottom: BorderSide(
                                                            color:
                                                                Colors.black26),
                                                        left: BorderSide(
                                                            color: Colors
                                                                .black26)),
                                                    columnWidths: const {
                                                      0: FixedColumnWidth(
                                                          350.0),
                                                      1: FixedColumnWidth(
                                                          200.0),
                                                      2: FixedColumnWidth(
                                                          200.0),
                                                    },
                                                    children: [
                                                      TableRow(children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10.0),
                                                          child: Text(
                                                            'Last duty Ended',
                                                            style: TextStyle(
                                                              fontFamily: AppFont
                                                                  .OutfitFont,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(0),
                                                          child: Container(
                                                            constraints:
                                                                const BoxConstraints(
                                                              minHeight: 10.0,
                                                              maxHeight: 100.0,
                                                            ),
                                                            child:
                                                                SingleChildScrollView(
                                                              child: TextField(
                                                                autocorrect:
                                                                    false,
                                                                enableSuggestions:
                                                                    false,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16.0,
                                                                    color: AppColor
                                                                        .textColor),
                                                                scrollPhysics:
                                                                    NeverScrollableScrollPhysics(),
                                                                textCapitalization:
                                                                    TextCapitalization
                                                                        .characters,
                                                                controller:
                                                                    _Reduced_lastdutyended_UTC,
                                                                readOnly: true,
                                                                onTap:
                                                                    () async {
                                                                  TimeOfDay?
                                                                      pickedTime =
                                                                      await showTimePicker(
                                                                    context:
                                                                        context,
                                                                    initialTime:
                                                                        TimeOfDay
                                                                            .now(),
                                                                    builder:
                                                                        (context,
                                                                            child) {
                                                                      return MediaQuery(
                                                                        data: MediaQuery.of(context).copyWith(
                                                                            alwaysUse24HourFormat:
                                                                                true),
                                                                        child:
                                                                            child!,
                                                                      );
                                                                    },
                                                                  );

                                                                  if (pickedTime !=
                                                                      null) {
                                                                    // Format the selected time and update the TextField
                                                                    String
                                                                        formattedTime =
                                                                        '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                                                                    _Reduced_lastdutyended_UTC
                                                                            .text =
                                                                        formattedTime; // Update the controller's text
                                                                  }
                                                                },
                                                                decoration:
                                                                    InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  contentPadding:
                                                                      EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              10.0),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(0),
                                                          child: Container(
                                                            constraints:
                                                                const BoxConstraints(
                                                              minHeight: 10.0,
                                                              maxHeight: 100.0,
                                                            ),
                                                            child:
                                                                SingleChildScrollView(
                                                              child: TextField(
                                                                autocorrect:
                                                                    false,
                                                                enableSuggestions:
                                                                    false,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16.0,
                                                                    color: AppColor
                                                                        .textColor),
                                                                scrollPhysics:
                                                                    NeverScrollableScrollPhysics(),
                                                                textCapitalization:
                                                                    TextCapitalization
                                                                        .characters,
                                                                controller:
                                                                    _Reduced_lastdutyended_LT,
                                                                readOnly: true,
                                                                onTap:
                                                                    () async {
                                                                  TimeOfDay?
                                                                      pickedTime =
                                                                      await showTimePicker(
                                                                    context:
                                                                        context,
                                                                    initialTime:
                                                                        TimeOfDay
                                                                            .now(),
                                                                    builder:
                                                                        (context,
                                                                            child) {
                                                                      return MediaQuery(
                                                                        data: MediaQuery.of(context).copyWith(
                                                                            alwaysUse24HourFormat:
                                                                                true),
                                                                        child:
                                                                            child!,
                                                                      );
                                                                    },
                                                                  );

                                                                  if (pickedTime !=
                                                                      null) {
                                                                    // Format the selected time and update the TextField
                                                                    String
                                                                        formattedTime =
                                                                        '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                                                                    _Reduced_lastdutyended_LT
                                                                            .text =
                                                                        formattedTime; // Update the controller's text
                                                                  }
                                                                },
                                                                decoration:
                                                                    InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  contentPadding:
                                                                      EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              10.0),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ]),
                                                    ],
                                                  ),
                                                  Table(
                                                    border: TableBorder(
                                                        horizontalInside:
                                                            BorderSide(
                                                                color: Colors
                                                                    .black26),
                                                        verticalInside:
                                                            BorderSide(
                                                                color: Colors
                                                                    .black26),
                                                        right: BorderSide(
                                                            color:
                                                                Colors.black26),
                                                        bottom: BorderSide(
                                                            color:
                                                                Colors.black26),
                                                        left: BorderSide(
                                                            color: Colors
                                                                .black26)),
                                                    columnWidths: const {
                                                      0: FixedColumnWidth(
                                                          350.0),
                                                      1: FixedColumnWidth(
                                                          400.0),
                                                    },
                                                    children: [
                                                      TableRow(children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10.0),
                                                          child: Text(
                                                            'Rest Earned',
                                                            style: TextStyle(
                                                              fontFamily: AppFont
                                                                  .OutfitFont,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(0),
                                                          child: Container(
                                                            constraints:
                                                                const BoxConstraints(
                                                              minHeight: 10.0,
                                                              maxHeight: 100.0,
                                                            ),
                                                            child:
                                                                SingleChildScrollView(
                                                              child: TextField(
                                                                autocorrect:
                                                                    false,
                                                                enableSuggestions:
                                                                    false,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        16.0,
                                                                    color: AppColor
                                                                        .textColor),
                                                                scrollPhysics:
                                                                    const NeverScrollableScrollPhysics(),
                                                                textCapitalization:
                                                                    TextCapitalization
                                                                        .characters,
                                                                controller:
                                                                    _Reduced_restEarned,
                                                                decoration:
                                                                    const InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  contentPadding:
                                                                      EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              10.0),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ]),
                                                    ],
                                                  ),
                                                  Table(
                                                    border: TableBorder(
                                                        horizontalInside:
                                                            BorderSide(
                                                                color: Colors
                                                                    .black26),
                                                        verticalInside:
                                                            BorderSide(
                                                                color: Colors
                                                                    .black26),
                                                        right: BorderSide(
                                                            color:
                                                                Colors.black26),
                                                        bottom: BorderSide(
                                                            color:
                                                                Colors.black26),
                                                        left: BorderSide(
                                                            color: Colors
                                                                .black26)),
                                                    columnWidths: const {
                                                      0: FixedColumnWidth(
                                                          350.0),
                                                      1: FixedColumnWidth(
                                                          200.0),
                                                      2: FixedColumnWidth(
                                                          200.0),
                                                    },
                                                    children: [
                                                      TableRow(children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10.0),
                                                          child: Text(
                                                            'Actual start of next FDP',
                                                            style: TextStyle(
                                                              fontFamily: AppFont
                                                                  .OutfitFont,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(0),
                                                          child: Container(
                                                            constraints:
                                                                const BoxConstraints(
                                                              minHeight: 10.0,
                                                              maxHeight: 100.0,
                                                            ),
                                                            child:
                                                                SingleChildScrollView(
                                                              child: TextField(
                                                                autocorrect:
                                                                    false,
                                                                enableSuggestions:
                                                                    false,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16.0,
                                                                    color: AppColor
                                                                        .textColor),
                                                                scrollPhysics:
                                                                    NeverScrollableScrollPhysics(),
                                                                textCapitalization:
                                                                    TextCapitalization
                                                                        .characters,
                                                                controller:
                                                                    _Reduced_actualstartofnextFDP_UTC,
                                                                readOnly: true,
                                                                onTap:
                                                                    () async {
                                                                  TimeOfDay?
                                                                      pickedTime =
                                                                      await showTimePicker(
                                                                    context:
                                                                        context,
                                                                    initialTime:
                                                                        TimeOfDay
                                                                            .now(),
                                                                    builder:
                                                                        (context,
                                                                            child) {
                                                                      return MediaQuery(
                                                                        data: MediaQuery.of(context).copyWith(
                                                                            alwaysUse24HourFormat:
                                                                                true),
                                                                        child:
                                                                            child!,
                                                                      );
                                                                    },
                                                                  );

                                                                  if (pickedTime !=
                                                                      null) {
                                                                    // Format the selected time and update the TextField
                                                                    String
                                                                        formattedTime =
                                                                        '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                                                                    _Reduced_actualstartofnextFDP_UTC
                                                                            .text =
                                                                        formattedTime; // Update the controller's text
                                                                  }
                                                                },
                                                                decoration:
                                                                    InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  contentPadding:
                                                                      EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              10.0),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(0),
                                                          child: Container(
                                                            constraints:
                                                                const BoxConstraints(
                                                              minHeight: 10.0,
                                                              maxHeight: 100.0,
                                                            ),
                                                            child:
                                                                SingleChildScrollView(
                                                              child: TextField(
                                                                autocorrect:
                                                                    false,
                                                                enableSuggestions:
                                                                    false,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16.0,
                                                                    color: AppColor
                                                                        .textColor),
                                                                scrollPhysics:
                                                                    NeverScrollableScrollPhysics(),
                                                                textCapitalization:
                                                                    TextCapitalization
                                                                        .characters,
                                                                controller:
                                                                    _Reduced_actualstartofnextFDP_LT,
                                                                readOnly: true,
                                                                onTap:
                                                                    () async {
                                                                  TimeOfDay?
                                                                      pickedTime =
                                                                      await showTimePicker(
                                                                    context:
                                                                        context,
                                                                    initialTime:
                                                                        TimeOfDay
                                                                            .now(),
                                                                    builder:
                                                                        (context,
                                                                            child) {
                                                                      return MediaQuery(
                                                                        data: MediaQuery.of(context).copyWith(
                                                                            alwaysUse24HourFormat:
                                                                                true),
                                                                        child:
                                                                            child!,
                                                                      );
                                                                    },
                                                                  );

                                                                  if (pickedTime !=
                                                                      null) {
                                                                    // Format the selected time and update the TextField
                                                                    String
                                                                        formattedTime =
                                                                        '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                                                                    _Reduced_actualstartofnextFDP_LT
                                                                            .text =
                                                                        formattedTime; // Update the controller's text
                                                                  }
                                                                },
                                                                decoration:
                                                                    InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  contentPadding:
                                                                      EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              10.0),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ]),
                                                    ],
                                                  ),
                                                  Table(
                                                    border: TableBorder(
                                                        horizontalInside:
                                                            BorderSide(
                                                                color: Colors
                                                                    .black26),
                                                        verticalInside:
                                                            BorderSide(
                                                                color: Colors
                                                                    .black26),
                                                        right: BorderSide(
                                                            color:
                                                                Colors.black26),
                                                        bottom: BorderSide(
                                                            color:
                                                                Colors.black26),
                                                        left: BorderSide(
                                                            color: Colors
                                                                .black26)),
                                                    columnWidths: const {
                                                      0: FixedColumnWidth(
                                                          350.0),
                                                      1: FixedColumnWidth(
                                                          400.0),
                                                    },
                                                    children: [
                                                      TableRow(children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10.0),
                                                          child: Text(
                                                            'Rest Period Reduced By',
                                                            style: TextStyle(
                                                              fontFamily: AppFont
                                                                  .OutfitFont,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(0),
                                                          child: Container(
                                                            constraints:
                                                                const BoxConstraints(
                                                              minHeight: 10.0,
                                                              maxHeight: 100.0,
                                                            ),
                                                            child:
                                                                SingleChildScrollView(
                                                              child: TextField(
                                                                autocorrect:
                                                                    false,
                                                                enableSuggestions:
                                                                    false,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16.0,
                                                                    color: AppColor
                                                                        .textColor),
                                                                scrollPhysics:
                                                                    NeverScrollableScrollPhysics(),
                                                                textCapitalization:
                                                                    TextCapitalization
                                                                        .characters,
                                                                controller:
                                                                    _Reduced_restperiodreducedby,
                                                                decoration:
                                                                    InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  contentPadding:
                                                                      EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              10.0),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ]),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 15),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Commander's Reason For Extension",
                                                              style: TextStyle(
                                                                fontFamily: AppFont
                                                                    .OutfitFont,
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                height: 5),
                                                            Container(
                                                              // height:200,
                                                              constraints:
                                                                  const BoxConstraints(
                                                                minHeight:
                                                                    60.0, // Increased minHeight
                                                                maxHeight:
                                                                    150.0, // Increased maxHeight
                                                              ),
                                                              child:
                                                                  SingleChildScrollView(
                                                                child:
                                                                    TextField(
                                                                  autocorrect:
                                                                      false,
                                                                  enableSuggestions:
                                                                      false,
                                                                  maxLines:
                                                                      3, // Allow the TextField to expand vertically
                                                                  textCapitalization:
                                                                      TextCapitalization
                                                                          .characters,
                                                                  controller:
                                                                      _Reduced_commanders_reason,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    hintStyle:
                                                                        const TextStyle(
                                                                            color:
                                                                                Color(0xFFCACAC9)),
                                                                    border:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              12),
                                                                      borderSide:
                                                                          const BorderSide(
                                                                              color: Color(0xFFCACAC9)),
                                                                    ),
                                                                    focusedBorder:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              12),
                                                                      borderSide:
                                                                          const BorderSide(
                                                                              color: Color(0xFF626262)),
                                                                    ),
                                                                    enabledBorder:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              12),
                                                                      borderSide:
                                                                          const BorderSide(
                                                                              color: Color(0xFFCACAC9)),
                                                                    ),
                                                                    contentPadding:
                                                                        EdgeInsets.all(
                                                                            16), // Add padding inside the TextField
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),

                                                      const SizedBox(
                                                          width:
                                                              16), // Spacing between fields
                                                      // Right Side Fields (Date and Number)
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          const SizedBox(
                                                              height: 20),
                                                          SizedBox(
                                                            width: 120,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                const SizedBox(
                                                                    width: 5),
                                                                Text(
                                                                  'Signature',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        AppFont
                                                                            .OutfitFont,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                                Checkbox(
                                                                  value:
                                                                      _Reduced_Commanders_check,
                                                                  activeColor:
                                                                      AppColor
                                                                          .primaryColor,
                                                                  checkColor:
                                                                      Colors
                                                                          .white,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    side:
                                                                        const BorderSide(
                                                                      color: Colors
                                                                          .grey,
                                                                      width:
                                                                          1.0,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            4.0),
                                                                  ),
                                                                  onChanged:
                                                                      (bool?
                                                                          value) {
                                                                    setState(
                                                                        () {
                                                                      _Reduced_Commanders_check =
                                                                          value ??
                                                                              false;
                                                                    });
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 120,
                                                            child: TextField(
                                                              autocorrect:
                                                                  false,
                                                              enableSuggestions:
                                                                  false,
                                                              readOnly: true,
                                                              textCapitalization:
                                                                  TextCapitalization
                                                                      .characters,
                                                              controller:
                                                                  TextEditingController(
                                                                      text:
                                                                          currentDate),
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    'Date',
                                                                hintStyle: const TextStyle(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12),
                                                                  borderSide:
                                                                      const BorderSide(
                                                                          color:
                                                                              Color(0xFFCACAC9)),
                                                                ),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12),
                                                                  borderSide:
                                                                      const BorderSide(
                                                                          color:
                                                                              Color(0xFF626262)),
                                                                ),
                                                                enabledBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12),
                                                                  borderSide:
                                                                      const BorderSide(
                                                                          color:
                                                                              Color(0xFFCACAC9)),
                                                                ),
                                                                contentPadding:
                                                                    EdgeInsets.symmetric(
                                                                        vertical:
                                                                            8,
                                                                        horizontal:
                                                                            8),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 15),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Operator's Remarks/Actions taken",
                                                              style: TextStyle(
                                                                fontFamily: AppFont
                                                                    .OutfitFont,
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                height: 5),
                                                            Container(
                                                              // height:200,
                                                              constraints:
                                                                  const BoxConstraints(
                                                                minHeight:
                                                                    60.0, // Increased minHeight
                                                                maxHeight:
                                                                    150.0, // Increased maxHeight
                                                              ),
                                                              child:
                                                                  SingleChildScrollView(
                                                                child:
                                                                    TextField(
                                                                  autocorrect:
                                                                      false,
                                                                  enableSuggestions:
                                                                      false,
                                                                  maxLines:
                                                                      3, // Allow the TextField to expand vertically
                                                                  textCapitalization:
                                                                      TextCapitalization
                                                                          .characters,
                                                                  controller:
                                                                      _Reduced_operators_remark,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    hintStyle:
                                                                        const TextStyle(
                                                                            color:
                                                                                Color(0xFFCACAC9)),
                                                                    border:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              12),
                                                                      borderSide:
                                                                          const BorderSide(
                                                                              color: Color(0xFFCACAC9)),
                                                                    ),
                                                                    focusedBorder:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              12),
                                                                      borderSide:
                                                                          const BorderSide(
                                                                              color: Color(0xFF626262)),
                                                                    ),
                                                                    enabledBorder:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              12),
                                                                      borderSide:
                                                                          const BorderSide(
                                                                              color: Color(0xFFCACAC9)),
                                                                    ),
                                                                    contentPadding:
                                                                        EdgeInsets.all(
                                                                            16), // Add padding inside the TextField
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),

                                                      const SizedBox(
                                                          width:
                                                              16), // Spacing between fields
                                                      // Right Side Fields (Date and Number)
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          const SizedBox(
                                                              height: 20),
                                                          SizedBox(
                                                            width: 120,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                const SizedBox(
                                                                    width: 5),
                                                                Text(
                                                                  'Signature',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        AppFont
                                                                            .OutfitFont,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                                Checkbox(
                                                                  value:
                                                                      _Reduced_Operators_check,
                                                                  activeColor:
                                                                      AppColor
                                                                          .primaryColor,
                                                                  checkColor:
                                                                      Colors
                                                                          .white,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    side:
                                                                        const BorderSide(
                                                                      color: Colors
                                                                          .grey,
                                                                      width:
                                                                          1.0,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            4.0),
                                                                  ),
                                                                  onChanged:
                                                                      (bool?
                                                                          value) {
                                                                    setState(
                                                                        () {
                                                                      _Reduced_Operators_check =
                                                                          value ??
                                                                              false;
                                                                    });
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 120,
                                                            child: TextField(
                                                              autocorrect:
                                                                  false,
                                                              enableSuggestions:
                                                                  false,
                                                              readOnly: true,
                                                              textCapitalization:
                                                                  TextCapitalization
                                                                      .characters,
                                                              controller:
                                                                  TextEditingController(
                                                                      text:
                                                                          currentDate),
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    'Date',
                                                                hintStyle: const TextStyle(
                                                                    color: Color(
                                                                        0xFFCACAC9)),
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12),
                                                                  borderSide:
                                                                      const BorderSide(
                                                                          color:
                                                                              Color(0xFFCACAC9)),
                                                                ),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12),
                                                                  borderSide:
                                                                      const BorderSide(
                                                                          color:
                                                                              Color(0xFF626262)),
                                                                ),
                                                                enabledBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12),
                                                                  borderSide:
                                                                      const BorderSide(
                                                                          color:
                                                                              Color(0xFFCACAC9)),
                                                                ),
                                                                contentPadding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                            8,
                                                                        horizontal:
                                                                            8),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),

                                                  SizedBox(height: 20),

                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        "FO/FOR/RW/58",
                                                        style: TextStyle(
                                                          fontFamily: AppFont.OutfitFont,
                                                          color: Colors.black,
                                                          fontSize: 13,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                      Text(
                                                        "Rev.2",
                                                        style: TextStyle(
                                                          fontFamily: AppFont.OutfitFont,
                                                          color: Colors.black,
                                                          fontSize: 13,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                      Text(
                                                        "05 JAN 2024",
                                                        style: TextStyle(
                                                          fontFamily: AppFont.OutfitFont,
                                                          color: Colors.black,
                                                          fontSize: 13,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                  const SizedBox(height: 20),
                                                  if (reducedStatus !=
                                                      'completed') ...[

                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.2,
                                                          child: ElevatedButton(
                                                            onPressed: () {
                                                              Navigator
                                                                  .pushNamed(
                                                                context,
                                                                "/forms",
                                                              );
                                                            },
                                                            style: ButtonStyle(
                                                              foregroundColor:
                                                                  MaterialStateProperty
                                                                      .resolveWith(
                                                                          (states) {
                                                                if (states.contains(
                                                                    MaterialState
                                                                        .pressed)) {
                                                                  return Colors
                                                                      .white; // Text color when pressed
                                                                }
                                                                return Color(
                                                                    0xFFAA182C); // Text color when not pressed
                                                              }),
                                                              backgroundColor:
                                                                  MaterialStateProperty
                                                                      .resolveWith(
                                                                          (states) {
                                                                if (states.contains(
                                                                    MaterialState
                                                                        .pressed)) {
                                                                  return Color(
                                                                      0xFFAA182C); // Background color when pressed
                                                                }
                                                                return Colors
                                                                    .white; // Background color when not pressed
                                                              }),
                                                              side: MaterialStateProperty
                                                                  .all(BorderSide(
                                                                      color: Color(
                                                                          0xFFAA182C),
                                                                      width:
                                                                          1)), // Red outline
                                                              padding: MaterialStateProperty.all(
                                                                  const EdgeInsets
                                                                      .all(
                                                                      13.0)),
                                                              shape:
                                                                  MaterialStateProperty
                                                                      .all(
                                                                RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              'Back',
                                                              style: TextStyle(
                                                                fontFamily: AppFont
                                                                    .OutfitFont,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 10),
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.7,
                                                          child: ElevatedButton(
                                                            onPressed: () {
                                                              if (!_Reduced_Commanders_check) {
                                                                EasyLoading
                                                                    .showInfo(
                                                                        'Please Commanders sign in to continue');
                                                              } else {
                                                                if (!_Reduced_Operators_check) {
                                                                  EasyLoading
                                                                      .showInfo(
                                                                          'Please Operators sign in to continue');
                                                                } else {
                                                                  if (!_Reduced_Commander_Point1) {
                                                                    EasyLoading
                                                                        .showInfo(
                                                                            'Please check in to continue');
                                                                  } else {
                                                                    if (!_Reduced_Commander_Point2) {
                                                                      EasyLoading
                                                                          .showInfo(
                                                                              'Please check in to continue');
                                                                    } else {
                                                                      if (!_Reduced_Commander_Point3) {
                                                                        EasyLoading.showInfo(
                                                                            'Please check in to continue');
                                                                      } else {
                                                                        if (!_Reduced_Commander_Point4) {
                                                                          EasyLoading.showInfo(
                                                                              'Please check in to continue');
                                                                        } else {
                                                                          if (!_Reduced_Commander_Point5) {
                                                                            EasyLoading.showInfo('Please check in to continue');
                                                                          } else {
                                                                            showDialog(
                                                                              context: context,
                                                                              builder: (BuildContext context) {
                                                                                return AlertDialog(
                                                                                  title: Text('Confirmation'),
                                                                                  content: Text('Do you want to save your changes?'),
                                                                                  actions: <Widget>[
                                                                                    TextButton(
                                                                                      onPressed: () {
                                                                                        // Close the dialog without saving
                                                                                        Navigator.of(context).pop();
                                                                                      },
                                                                                      child: Text('No'),
                                                                                    ),
                                                                                    TextButton(
                                                                                      onPressed: () {
                                                                                        _saveExtensionForm('reduced');
                                                                                        Navigator.of(context).pop();
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
                                                                    }
                                                                  }
                                                                }
                                                              }
                                                            },
                                                            style: ButtonStyle(
                                                              foregroundColor:
                                                                  WidgetStateProperty
                                                                      .resolveWith(
                                                                          (states) {
                                                                if (states.contains(
                                                                    WidgetState
                                                                        .pressed)) {
                                                                  return Colors
                                                                      .white70;
                                                                }
                                                                return Colors
                                                                    .white;
                                                              }),
                                                              backgroundColor:
                                                                  WidgetStateProperty
                                                                      .resolveWith(
                                                                          (states) {
                                                                if (states.contains(
                                                                    WidgetState
                                                                        .pressed)) {
                                                                  return (Color(
                                                                      0xFFE8374F));
                                                                }
                                                                return (Color(
                                                                    0xFFAA182C));
                                                              }),
                                                              padding: WidgetStateProperty.all(
                                                                  const EdgeInsets
                                                                      .all(
                                                                      13.0)),
                                                              shape:
                                                                  WidgetStateProperty
                                                                      .all(
                                                                RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              'Save',
                                                              style: TextStyle(
                                                                fontFamily: AppFont
                                                                    .OutfitFont,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ]
                                                ],
                                              ),
                                            ),
                                          ]),
                                      ],
                                    ),
                                  ),
                                ],
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
          ),
        ],
      ),
    );
  }

  Future<void> _saveExtensionForm(String status) async {
    var aircraft = {
      "aircraftId": selectMaingroupId,
      "aircraftType": selectMaingroup,
      "aircraftRegId": selectedGroupId_id,
      "aircraftRegistration": selectedGroupName
    };

    var extension = {
      "extension_commandersname": _Extension_commandersname.text,
      "extension_crew_involved_PIC": _Extension_crew_involved_PIC.text,
      "extension_crew_involved_SIC": _Extension_crew_involved_SIC.text,
      "extension_schedule_flighttype": _Extension_schedule_flighttype.text,
      "extension_schedule_routing": _Extension_schedule_routing.text,
      "extension_schedule_FDP": _Extension_schedule_FDP.text,
      "extension_schedule_FDPstart_UTC": _Extension_schedule_FDPstart_UTC.text,
      "extension_schedule_FDPstart_LT": _Extension_schedule_FDPstart_LT.text,
      "extension_schedule_allowedFDP": _Extension_schedule_allowedFDP.text,
      "extension_actual_FDPstart_place": _Extension_actual_FDPstart_place.text,
      "extension_actual_FDPstart_UTC": _Extension_actual_FDPstart_UTC.text,
      "extension_actual_FDPstart_LT": _Extension_actual_FDPstart_LT.text,
      "extension_actual_FDPend_place": _Extension_actual_FDPend_place.text,
      "extension_actual_FDPend_UTC": _Extension_actual_FDPend_UTC.text,
      "extension_actual_FDPend_LT": _Extension_actual_FDPend_LT.text,
      "extension_actual_actual_FDP": _Extension_actual_actual_FDP.text,
      "extension_actual_FDP_exceed": _Extension_actual_FDP_exceed.text,
      "extension_commanders_reason": _Extension_commanders_reason.text,
      "extension_operators_remark": _Extension_operators_remark.text
    };

    var reduced = {
      "reduced_commandersname": _Reduced_commandersname.text,
      "reduced_crew_involved_PIC": _Reduced_crew_involved_PIC.text,
      "reduced_crew_involved_SIC": _Reduced_crew_involved_SIC.text,
      "reduced_lastdutystarted_UTC": _Reduced_lastdutystarted_UTC.text,
      "reduced_lastdutystarted_LT": _Reduced_lastdutystarted_LT.text,
      "reduced_lastdutyended_UTC": _Reduced_lastdutyended_UTC.text,
      "reduced_lastdutyended_LT": _Reduced_lastdutyended_LT.text,
      "reduced_restEarned": _Reduced_restEarned.text,
      "reduced_actualstartofnextFDP_UTC":
          _Reduced_actualstartofnextFDP_UTC.text,
      "reduced_actualstartofnextFDP_LT": _Reduced_actualstartofnextFDP_LT.text,
      "reduced_restperiodreducedby": _Reduced_restperiodreducedby.text,
      "reduced_commanders_reason": _Reduced_commanders_reason.text,
      "reduced_operators_remark": _Reduced_operators_remark.text,
    };

    if (status == 'extension') {
      extensionStatus = 'completed';
    }
    if (status == 'reduced') {
      reducedStatus = 'completed';
    }

    var data = {
      "customer": fullName,
      "aircraft": aircraft,
      "tableValues": {
        "extension": extension,
        "extension_status": extensionStatus,
        "reduced": reduced,
        "reduced_status": reducedStatus
      }
    };

    try {
      var response = await http.Client().post(
        Uri.parse(
            "${AppUrls.formdata}?formid=$formId&formrefno=$commanders_discretion_report_refno"),
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
        final responseData = json.decode(response.body);
        print(responseData);
        EasyLoading.showToast('Saved Success');

        if (status == 'extension') {
          EasyLoading.showSuccess("Extension form added successfully");
        }
        if (status == 'reduced') {
          EasyLoading.showSuccess("Reduced form Added successfully");
        }

        formdata_pass_backend(UserID, userToken);
      } else {
        EasyLoading.showToast(
            'Something went wrong!\nPlease check again later.');
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
