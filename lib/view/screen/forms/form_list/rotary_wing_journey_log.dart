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

class RotaryWingJourneyLog extends StatefulWidget {
  const RotaryWingJourneyLog({super.key});

  @override
  State<RotaryWingJourneyLog> createState() => _RotaryWingJourneyLogState();
}

class _RotaryWingJourneyLogState extends State<RotaryWingJourneyLog> {
  List<Map<String, TextEditingController>> rows = [];
  int maxTripNo = 6;

  void addRowWithValues(Map<String, dynamic> flightDetail) {
    rows.add({
      'flight_type':
          TextEditingController(text: flightDetail['flight_type'] ?? ''),
      'a_c_type': TextEditingController(text: flightDetail['a_c_type'] ?? ''),
      'a_c_registration':
          TextEditingController(text: flightDetail['a_c_registration'] ?? ''),
      'departure_station':
          TextEditingController(text: flightDetail['departure_station'] ?? ''),
      'arrival_station':
          TextEditingController(text: flightDetail['arrival_station'] ?? ''),
      'start_up_time':
          TextEditingController(text: flightDetail['start_up_time'] ?? ''),
      'shutdown_time':
          TextEditingController(text: flightDetail['shutdown_time'] ?? ''),
      'block_time':
          TextEditingController(text: flightDetail['block_time'] ?? ''),
      'no_of_landings':
          TextEditingController(text: flightDetail['no_of_landings'] ?? ''),
      'contact_type':
          TextEditingController(text: flightDetail['contact_type'] ?? ''),
    });
  }

  void addNewRow(int tripNo) {
    if (tripNo <= maxTripNo) {
      rows.add({
        'flight_type': TextEditingController(),
        'a_c_type': TextEditingController(),
        'a_c_registration': TextEditingController(),
        'departure_station': TextEditingController(),
        'arrival_station': TextEditingController(),
        'start_up_time': TextEditingController(),
        'shutdown_time': TextEditingController(),
        'block_time': TextEditingController(),
        'no_of_landings': TextEditingController(),
        'contact_type': TextEditingController(),
      });
    }
  }

  void removeLastRow() {
    if (rows.length > 1) {
      rows.removeLast();
    }
  }

  String _formStatus = '';

  bool _isCheckedx = false;
  var formId = 'FAF02';
  String userToken = '';
  String fullName = '';
  String selectedGroupName = '';
  List<dynamic> apps = [];
  String profilePic = '';
  String UserID = '';
  String selectedGroupId_id = '';

  String selectMaingroup = '';
  String selectMaingroupId = '';

  String tableletestdata = "";

  String rotery_wing_journey_log = '';

  var profile = dummyProfile;
  var currentDate =
      "${DateTime.now().day.toString().padLeft(2, '0')}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().year}";

  final TextEditingController _crewnames_PIC = TextEditingController();
  final TextEditingController _crewnames_SIC = TextEditingController();
  final TextEditingController _crewnames_SIM_SIME = TextEditingController();

  final TextEditingController _crewnames_PIC_allowed_FDP =
      TextEditingController();
  final TextEditingController _crewnames_SIC_allowed_FDP =
      TextEditingController();
  final TextEditingController _crewnames_SIM_SIME_allowed_FDP =
      TextEditingController();

  final TextEditingController _crewnames_PIC_actual_FDP_FDP_start =
      TextEditingController(); //A
  final TextEditingController _crewnames_SIC_actual_FDP_FDP_start =
      TextEditingController();
  final TextEditingController _crewnames_SIM_SIME_actual_FDP_FDP_start =
      TextEditingController();

  final TextEditingController _crewnames_PIC_actual_FDP_FDP_finish =
      TextEditingController(); //B
  final TextEditingController _crewnames_SIC_actual_FDP_FDP_finish =
      TextEditingController();
  final TextEditingController _crewnames_SIM_SIME_actual_FDP_FDP_finish =
      TextEditingController();

  final TextEditingController _crewnames_PIC_actual_FDP_total_FDP =
      TextEditingController();
  final TextEditingController _crewnames_SIC_actual_FDP_total_FDP =
      TextEditingController();
  final TextEditingController _crewnames_SIM_SIME_actual_FDP_total_FDP =
      TextEditingController();

  final TextEditingController _crewnames_PIC_actual_duty_DP_start =
      TextEditingController();
  final TextEditingController _crewnames_SIC_actual_duty_DP_start =
      TextEditingController();
  final TextEditingController _crewnames_SIM_SIME_actual_duty_DP_start =
      TextEditingController();

  final TextEditingController _crewnames_PIC_actual_FDP_DP_finish =
      TextEditingController();
  final TextEditingController _crewnames_SIC_actual_FDP_DP_finish =
      TextEditingController();
  final TextEditingController _crewnames_SIM_SIME_actual_FDP_DP_finish =
      TextEditingController();

  final TextEditingController _crewnames_PIC_actual_FDP_toatl_DP =
      TextEditingController();
  final TextEditingController _crewnames_SIC_actual_FDP_toatl_DP =
      TextEditingController();
  final TextEditingController _crewnames_SIM_SIME_actual_FDP_toatl_DP =
      TextEditingController();

  final TextEditingController _crewnames_PIC_duty_type =
      TextEditingController();
  final TextEditingController _crewnames_SIC_duty_type =
      TextEditingController();
  final TextEditingController _crewnames_SIM_SIME_duty_type =
      TextEditingController();

  bool _commanders_discretion_report_filed = false;
  bool _type_of_discretion_extending = false;
  bool _type_of_discretion_reducing = false;

  // final TextEditingController _flight_type = TextEditingController();
  // final TextEditingController _a_c_type = TextEditingController();
  // final TextEditingController _a_c_registration = TextEditingController();
  // final TextEditingController _departure_station = TextEditingController();
  // final TextEditingController _arrival_station  = TextEditingController();
  // final TextEditingController _start_up_time = TextEditingController();
  // final TextEditingController _shutdown_time = TextEditingController();
  // final TextEditingController _block_time = TextEditingController();
  // final TextEditingController _no_of_landings = TextEditingController();
  // final TextEditingController _contact_type = TextEditingController();

  final TextEditingController _total_block_time = TextEditingController();
  final TextEditingController _total_no_of_landings = TextEditingController();
  final TextEditingController _total_no_of_ifr_approaches =
      TextEditingController();

  final TextEditingController _sdr_time_of = TextEditingController();
  final TextEditingController _sdr_time_on = TextEditingController();
  final TextEditingController _sdr_rest = TextEditingController();
  final TextEditingController _sdr_credit = TextEditingController();
  final TextEditingController _sdr_max_FDP = TextEditingController();
  final TextEditingController _sdr_actual_FDP = TextEditingController();

  bool _userSign = false;

  final TextEditingController _crew_comments = TextEditingController();
  final TextEditingController _reviewd_by_ops = TextEditingController();
  final TextEditingController _electronically_recorded =
      TextEditingController();

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
        setState(() {
          rotery_wing_journey_log = responseData['data']['form_ref_no'];
        });

        List<dynamic> flightDetails = responseData['data']['form_data']
                ?['tableValues']?['flightDetails'] ??
            [];

        setState(() {
          rows.clear();
          if (flightDetails.isNotEmpty) {
            for (var flightDetail in flightDetails) {
              addRowWithValues(flightDetail);
            }
          } else {
            addNewRow(1);
          }
        });

        setState(() {
          _formStatus = responseData['data']['form_status'];

          if (_formStatus != "notcompleted") {
            _crewnames_PIC.text = responseData['data']['form_data']['crewnames']
                    ['crewnames_PIC'] ??
                '';
            _crewnames_SIC.text = responseData['data']['form_data']['crewnames']
                    ['crewnames_SIC'] ??
                '';
            _crewnames_SIM_SIME.text = responseData['data']['form_data']
                    ['crewnames']['crewnames_SIM_SIME'] ??
                '';
            _crewnames_PIC_allowed_FDP.text = responseData['data']['form_data']
                    ['crewnames']['crewnames_PIC_allowed_FDP'] ??
                '';
            _crewnames_SIC_allowed_FDP.text = responseData['data']['form_data']
                    ['crewnames']['crewnames_SIC_allowed_FDP'] ??
                '';
            _crewnames_SIM_SIME_allowed_FDP.text = responseData['data']
                        ['form_data']['crewnames']
                    ['crewnames_SIM_SIME_allowed_FDP'] ??
                '';
            _crewnames_PIC_actual_FDP_FDP_start.text = responseData['data']
                        ['form_data']['crewnames']
                    ['crewnames_PIC_actual_FDP_FDP_start'] ??
                '';
            _crewnames_SIC_actual_FDP_FDP_start.text = responseData['data']
                        ['form_data']['crewnames']
                    ['crewnames_SIC_actual_FDP_FDP_start'] ??
                '';
            _crewnames_SIM_SIME_actual_FDP_FDP_start.text = responseData['data']
                        ['form_data']['crewnames']
                    ['crewnames_SIM_SIME_actual_FDP_FDP_start'] ??
                '';
            _crewnames_PIC_actual_FDP_FDP_finish.text = responseData['data']
                        ['form_data']['crewnames']
                    ['crewnames_PIC_actual_FDP_FDP_finish'] ??
                '';
            _crewnames_SIC_actual_FDP_FDP_finish.text = responseData['data']
                        ['form_data']['crewnames']
                    ['crewnames_SIC_actual_FDP_FDP_finish'] ??
                '';
            _crewnames_SIM_SIME_actual_FDP_FDP_finish.text =
                responseData['data']['form_data']['crewnames']
                        ['crewnames_SIM_SIME_actual_FDP_FDP_finish'] ??
                    '';
            _crewnames_PIC_actual_FDP_total_FDP.text = responseData['data']
                        ['form_data']['crewnames']
                    ['crewnames_PIC_actual_FDP_total_FDP'] ??
                '';
            _crewnames_SIC_actual_FDP_total_FDP.text = responseData['data']
                        ['form_data']['crewnames']
                    ['crewnames_SIC_actual_FDP_total_FDP'] ??
                '';
            _crewnames_SIM_SIME_actual_FDP_total_FDP.text = responseData['data']
                        ['form_data']['crewnames']
                    ['crewnames_SIM_SIME_actual_FDP_total_FDP'] ??
                '';
            _crewnames_PIC_actual_duty_DP_start.text = responseData['data']
                        ['form_data']['crewnames']
                    ['crewnames_PIC_actual_duty_DP_start'] ??
                '';
            _crewnames_SIC_actual_duty_DP_start.text = responseData['data']
                        ['form_data']['crewnames']
                    ['crewnames_SIC_actual_duty_DP_start'] ??
                '';
            _crewnames_SIM_SIME_actual_duty_DP_start.text = responseData['data']
                        ['form_data']['crewnames']
                    ['crewnames_SIM_SIME_actual_duty_DP_start'] ??
                '';
            _crewnames_PIC_actual_FDP_DP_finish.text = responseData['data']
                        ['form_data']['crewnames']
                    ['crewnames_PIC_actual_FDP_DP_finish'] ??
                '';
            _crewnames_SIC_actual_FDP_DP_finish.text = responseData['data']
                        ['form_data']['crewnames']
                    ['crewnames_SIC_actual_FDP_DP_finish'] ??
                '';
            _crewnames_SIM_SIME_actual_FDP_DP_finish.text = responseData['data']
                        ['form_data']['crewnames']
                    ['crewnames_SIM_SIME_actual_FDP_DP_finish'] ??
                '';
            _crewnames_PIC_actual_FDP_toatl_DP.text = responseData['data']
                        ['form_data']['crewnames']
                    ['crewnames_PIC_actual_FDP_toatl_DP'] ??
                '';
            _crewnames_SIC_actual_FDP_toatl_DP.text = responseData['data']
                        ['form_data']['crewnames']
                    ['crewnames_SIC_actual_FDP_toatl_DP'] ??
                '';
            _crewnames_SIM_SIME_actual_FDP_toatl_DP.text = responseData['data']
                        ['form_data']['crewnames']
                    ['crewnames_SIM_SIME_actual_FDP_toatl_DP'] ??
                '';
            _crewnames_PIC_duty_type.text = responseData['data']['form_data']
                    ['crewnames']['crewnames_PIC_duty_type'] ??
                '';
            _crewnames_SIC_duty_type.text = responseData['data']['form_data']
                    ['crewnames']['crewnames_SIC_duty_type'] ??
                '';
            _crewnames_SIM_SIME_duty_type.text = responseData['data']
                        ['form_data']['crewnames']
                    ['crewnames_SIM_SIME_duty_type'] ??
                '';

            if ((responseData['data']['form_data']['sign']
                    ['commanders_discretion_report_filed']) ==
                1) {
              _commanders_discretion_report_filed = true;
            } else {
              _commanders_discretion_report_filed = false;
            }
            if ((responseData['data']['form_data']['sign']
                    ['type_of_discretion_extending']) ==
                1) {
              _type_of_discretion_extending = true;
            } else {
              _type_of_discretion_extending = false;
            }
            if ((responseData['data']['form_data']['sign']
                    ['type_of_discretion_reducing']) ==
                1) {
              _type_of_discretion_reducing = true;
            } else {
              _type_of_discretion_reducing = false;
            }
            if ((responseData['data']['form_data']['sign']['userSign']) == 1) {
              _userSign = true;
            } else {
              _userSign = false;
            }

            _total_block_time.text =
                responseData['data']['form_data']['total_block_time'] ?? '';
            _total_no_of_landings.text =
                responseData['data']['form_data']['total_no_of_landings'] ?? '';
            _total_no_of_ifr_approaches.text = responseData['data']['form_data']
                    ['total_no_of_ifr_approaches'] ??
                '';
            _sdr_time_of.text =
                responseData['data']['form_data']['sdr_time_of'] ?? '';
            _sdr_time_on.text =
                responseData['data']['form_data']['sdr_time_on'] ?? '';
            _sdr_rest.text =
                responseData['data']['form_data']['sdr_rest'] ?? '';
            _sdr_credit.text =
                responseData['data']['form_data']['sdr_credit'] ?? '';
            _sdr_max_FDP.text =
                responseData['data']['form_data']['sdr_max_FDP'] ?? '';
            _sdr_actual_FDP.text =
                responseData['data']['form_data']['sdr_actual_FDP'] ?? '';
            _crew_comments.text =
                responseData['data']['form_data']['crew_comments'] ?? '';
            _reviewd_by_ops.text =
                responseData['data']['form_data']['reviewd_by_ops'] ?? '';
            _electronically_recorded.text = responseData['data']['form_data']
                    ['electronically_recorded'] ??
                '';
          }
        });
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

  void _calculateBlockTime(
      TextEditingController startUpController,
      TextEditingController shutdownController,
      TextEditingController blockTimeController) {
    String startTime = startUpController.text;
    String shutdownTime = shutdownController.text;

    if (startTime.isNotEmpty && shutdownTime.isNotEmpty) {
      try {
        // Parse Startup and Shutdown times
        List<String> startParts = startTime.split(":");
        List<String> shutdownParts = shutdownTime.split(":");

        int startHour = int.parse(startParts[0]);
        int startMinute = int.parse(startParts[1]);

        int shutdownHour = int.parse(shutdownParts[0]);
        int shutdownMinute = int.parse(shutdownParts[1]);

        Duration startDuration =
            Duration(hours: startHour, minutes: startMinute);
        Duration shutdownDuration =
            Duration(hours: shutdownHour, minutes: shutdownMinute);

        // Calculate Block Time
        Duration blockDuration = shutdownDuration - startDuration;

        // Format Block Time
        String formattedBlockTime =
            "${blockDuration.inHours.toString().padLeft(2, '0')}:${(blockDuration.inMinutes % 60).toString().padLeft(2, '0')}";

        blockTimeController.text = formattedBlockTime;
      } catch (e) {
        blockTimeController.text = "Error";
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
                                            'Rotary Wing Journey Log'
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
                            const SizedBox(height: 20),
                            Center(
                              child: Table(
                                border: TableBorder.all(color: Colors.grey),
                                columnWidths: const {
                                  0: FixedColumnWidth(120.0),
                                  1: FixedColumnWidth(80.0),
                                  2: FixedColumnWidth(220.0),
                                  3: FixedColumnWidth(220.0),
                                  4: FixedColumnWidth(100.0),
                                },
                                children: [
                                  TableRow(children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        'Crew Names',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: AppFont.OutfitFont,
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        'Allowed',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: AppFont.OutfitFont,
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        'Actual FDP',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: AppFont.OutfitFont,
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        'Actual Duty',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: AppFont.OutfitFont,
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        'Duty type *',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: AppFont.OutfitFont,
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    const Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text(' ',
                                          textAlign: TextAlign.center),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Dialog(
                                                insetPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                backgroundColor:
                                                    Colors.transparent,
                                                child: Stack(
                                                  children: [
                                                    // Set width and height for the dialog box
                                                    SizedBox(
                                                      width:
                                                          600, // Set desired width
                                                      height:
                                                          400, // Set desired height
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          image:
                                                              DecorationImage(
                                                            image: AssetImage(
                                                                ftltable),
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    // Close button positioned at top right
                                                    Positioned(
                                                      right: 0,
                                                      top: 0,
                                                      child: IconButton(
                                                        icon: Icon(Icons.close,
                                                            color: Colors
                                                                .transparent),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: Text(
                                          'FDP',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            fontFamily: 'Outfit',
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ),

                                    // Padding(
                                    //   padding: EdgeInsets.all(10),
                                    //   child: Text(
                                    //     'FDP',
                                    //     textAlign: TextAlign.center,
                                    //     style: TextStyle(
                                    //       fontFamily: AppFont.OutfitFont,
                                    //       color: Colors.black,
                                    //       fontSize: 12,
                                    //       fontWeight: FontWeight.normal,
                                    //     ),
                                    //   ),
                                    // ),

                                    Table(
                                      border: TableBorder(
                                        verticalInside:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      children: [
                                        TableRow(children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Text(
                                              'FDP Start',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: AppFont.OutfitFont,
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Text(
                                              'FDP Finish',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: AppFont.OutfitFont,
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Text(
                                              'Total FDP',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: AppFont.OutfitFont,
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ]),
                                      ],
                                    ),
                                    Table(
                                      border: TableBorder(
                                        verticalInside: BorderSide(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      children: [
                                        TableRow(children: [
                                          Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Text(
                                              'DP Start',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: AppFont.OutfitFont,
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Text(
                                              'DP Finish',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: AppFont.OutfitFont,
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Text(
                                              'Total DP',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: AppFont.OutfitFont,
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ]),
                                      ],
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text(' ',
                                          textAlign: TextAlign.center),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'PIC',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: AppFont.OutfitFont,
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              constraints: BoxConstraints(
                                                minHeight: 10.0,
                                                maxHeight: 100.0,
                                              ),
                                              child: SingleChildScrollView(
                                                child: TextField(
                                                  autocorrect: false,
                                                  enableSuggestions: false,
                                                  style: TextStyle(
                                                    fontSize: 14.0,
                                                    color: AppColor.textColor,
                                                  ),
                                                  maxLines: null,
                                                  textCapitalization:
                                                      TextCapitalization
                                                          .characters,
                                                  controller: _crewnames_PIC,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 4.0,
                                                            horizontal: 5.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Container(
                                        constraints: BoxConstraints(
                                          minHeight: 10.0,
                                          maxHeight: 100.0,
                                        ),
                                        child: SingleChildScrollView(
                                          child: TextField(
                                            autocorrect: false,
                                            enableSuggestions: false,
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                color: AppColor.textColor),
                                            maxLines: null,
                                            textCapitalization:
                                                TextCapitalization.characters,
                                            controller:
                                                _crewnames_PIC_allowed_FDP,
                                            decoration: InputDecoration(
                                              border: InputBorder
                                                  .none, // Remove underline
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 4.0,
                                                      horizontal: 5.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Table(
                                      border: TableBorder(
                                        verticalInside:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      children: [
                                        TableRow(children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Container(
                                              constraints: BoxConstraints(
                                                minHeight: 10.0,
                                                maxHeight: 100.0,
                                              ),
                                              child: SingleChildScrollView(
                                                child: TextField(
                                                  autocorrect: false,
                                                  enableSuggestions: false,
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color:
                                                          AppColor.textColor),
                                                  maxLines: null,
                                                  textCapitalization:
                                                      TextCapitalization
                                                          .characters,
                                                  controller:
                                                      _crewnames_PIC_actual_FDP_FDP_start,
                                                  readOnly: true,
                                                  onTap: () async {
                                                    TimeOfDay? pickedTime =
                                                        await showTimePicker(
                                                      context: context,
                                                      initialTime:
                                                          TimeOfDay.now(),
                                                      builder:
                                                          (context, child) {
                                                        return MediaQuery(
                                                          data: MediaQuery.of(
                                                                  context)
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
                                                      _crewnames_PIC_actual_FDP_FDP_start
                                                              .text =
                                                          formattedTime; // Update the controller's text
                                                      _calculateTotalTime(
                                                        _crewnames_PIC_actual_FDP_FDP_start
                                                            .text,
                                                        _crewnames_PIC_actual_FDP_FDP_finish
                                                            .text,
                                                        _crewnames_PIC_actual_FDP_total_FDP,
                                                      );
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                    border: InputBorder
                                                        .none, // Remove underline
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 4.0,
                                                            horizontal: 5.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Container(
                                              constraints: BoxConstraints(
                                                minHeight: 10.0,
                                                maxHeight: 100.0,
                                              ),
                                              child: SingleChildScrollView(
                                                child: TextField(
                                                  autocorrect: false,
                                                  enableSuggestions: false,
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color:
                                                          AppColor.textColor),
                                                  maxLines: null,
                                                  textCapitalization:
                                                      TextCapitalization
                                                          .characters,
                                                  controller:
                                                      _crewnames_PIC_actual_FDP_FDP_finish,
                                                  readOnly: true,
                                                  onTap: () async {
                                                    TimeOfDay? pickedTime =
                                                        await showTimePicker(
                                                      context: context,
                                                      initialTime:
                                                          TimeOfDay.now(),
                                                      builder:
                                                          (context, child) {
                                                        return MediaQuery(
                                                          data: MediaQuery.of(
                                                                  context)
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
                                                      _crewnames_PIC_actual_FDP_FDP_finish
                                                              .text =
                                                          formattedTime; // Update the controller's text

                                                      _calculateTotalTime(
                                                        _crewnames_PIC_actual_FDP_FDP_start
                                                            .text,
                                                        _crewnames_PIC_actual_FDP_FDP_finish
                                                            .text,
                                                        _crewnames_PIC_actual_FDP_total_FDP,
                                                      );
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                    border: InputBorder
                                                        .none, // Remove underline
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 4.0,
                                                            horizontal: 5.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Container(
                                              constraints: BoxConstraints(
                                                minHeight: 10.0,
                                                maxHeight: 100.0,
                                              ),
                                              child: SingleChildScrollView(
                                                child: TextField(
                                                  autocorrect: false,
                                                  enableSuggestions: false,
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color:
                                                          AppColor.textColor),
                                                  maxLines: null,
                                                  textCapitalization:
                                                      TextCapitalization
                                                          .characters,
                                                  controller:
                                                      _crewnames_PIC_actual_FDP_total_FDP,
                                                  readOnly: true,
                                                  // onTap: () async {
                                                  //   TimeOfDay? pickedTime = await showTimePicker(
                                                  //     context: context,
                                                  //     initialTime: TimeOfDay.now(),
                                                  //     builder: (context, child) {
                                                  //       return MediaQuery(
                                                  //         data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                                  //         child: child!,
                                                  //       );
                                                  //     },
                                                  //   );
                                                  //
                                                  //   if (pickedTime != null) {
                                                  //     // Format the selected time and update the TextField
                                                  //     String formattedTime =
                                                  //         '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                                                  //     _crewnames_PIC_actual_FDP_total_FDP.text = formattedTime; // Update the controller's text
                                                  //   }
                                                  // },
                                                  decoration: InputDecoration(
                                                    border: InputBorder
                                                        .none, // Remove underline
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 4.0,
                                                            horizontal: 5.0),
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
                                        verticalInside:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      children: [
                                        TableRow(children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Container(
                                              constraints: BoxConstraints(
                                                minHeight: 10.0,
                                                maxHeight: 100.0,
                                              ),
                                              child: SingleChildScrollView(
                                                child: TextField(
                                                  autocorrect: false,
                                                  enableSuggestions: false,
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color:
                                                          AppColor.textColor),
                                                  maxLines: null,
                                                  textCapitalization:
                                                      TextCapitalization
                                                          .characters,
                                                  controller:
                                                      _crewnames_PIC_actual_duty_DP_start,
                                                  readOnly: true,
                                                  onTap: () async {
                                                    TimeOfDay? pickedTime =
                                                        await showTimePicker(
                                                      context: context,
                                                      initialTime:
                                                          TimeOfDay.now(),
                                                      builder:
                                                          (context, child) {
                                                        return MediaQuery(
                                                          data: MediaQuery.of(
                                                                  context)
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
                                                      _crewnames_PIC_actual_duty_DP_start
                                                              .text =
                                                          formattedTime; // Update the controller's text
                                                      _calculateTotalTime(
                                                        _crewnames_PIC_actual_duty_DP_start
                                                            .text,
                                                        _crewnames_PIC_actual_FDP_DP_finish
                                                            .text,
                                                        _crewnames_PIC_actual_FDP_toatl_DP,
                                                      );
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                    border: InputBorder
                                                        .none, // Remove underline

                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 4.0,
                                                            horizontal: 5.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Container(
                                              constraints: BoxConstraints(
                                                minHeight: 10.0,
                                                maxHeight: 100.0,
                                              ),
                                              child: SingleChildScrollView(
                                                child: TextField(
                                                  autocorrect: false,
                                                  enableSuggestions: false,
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color:
                                                          AppColor.textColor),
                                                  maxLines: null,
                                                  textCapitalization:
                                                      TextCapitalization
                                                          .characters,
                                                  controller:
                                                      _crewnames_PIC_actual_FDP_DP_finish,
                                                  readOnly: true,
                                                  onTap: () async {
                                                    TimeOfDay? pickedTime =
                                                        await showTimePicker(
                                                      context: context,
                                                      initialTime:
                                                          TimeOfDay.now(),
                                                      builder:
                                                          (context, child) {
                                                        return MediaQuery(
                                                          data: MediaQuery.of(
                                                                  context)
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
                                                      _crewnames_PIC_actual_FDP_DP_finish
                                                              .text =
                                                          formattedTime; // Update the controller's text

                                                      _calculateTotalTime(
                                                        _crewnames_PIC_actual_duty_DP_start
                                                            .text,
                                                        _crewnames_PIC_actual_FDP_DP_finish
                                                            .text,
                                                        _crewnames_PIC_actual_FDP_toatl_DP,
                                                      );
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                    border: InputBorder
                                                        .none, // Remove underline

                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 4.0,
                                                            horizontal: 5.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Container(
                                              constraints: BoxConstraints(
                                                minHeight: 10.0,
                                                maxHeight: 100.0,
                                              ),
                                              child: SingleChildScrollView(
                                                child: TextField(
                                                  autocorrect: false,
                                                  enableSuggestions: false,
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color:
                                                          AppColor.textColor),
                                                  maxLines: null,
                                                  textCapitalization:
                                                      TextCapitalization
                                                          .characters,
                                                  controller:
                                                      _crewnames_PIC_actual_FDP_toatl_DP,
                                                  readOnly: true,
                                                  // onTap: () async {
                                                  //   TimeOfDay? pickedTime = await showTimePicker(
                                                  //     context: context,
                                                  //     initialTime: TimeOfDay.now(),
                                                  //     builder: (context, child) {
                                                  //       return MediaQuery(
                                                  //         data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                                  //         child: child!,
                                                  //       );
                                                  //     },
                                                  //   );
                                                  //
                                                  //   if (pickedTime != null) {
                                                  //     // Format the selected time and update the TextField
                                                  //     String formattedTime =
                                                  //         '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                                                  //     _crewnames_PIC_actual_FDP_toatl_DP.text = formattedTime; // Update the controller's text
                                                  //   }
                                                  // },
                                                  decoration: InputDecoration(
                                                    border: InputBorder
                                                        .none, // Remove underline

                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 4.0,
                                                            horizontal: 5.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Container(
                                        constraints: BoxConstraints(
                                          minHeight: 10.0,
                                          maxHeight: 100.0,
                                        ),
                                        child: SingleChildScrollView(
                                          child: TextField(
                                            autocorrect: false,
                                            enableSuggestions: false,
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                color: AppColor.textColor),
                                            maxLines: null,
                                            textCapitalization:
                                                TextCapitalization.characters,
                                            controller:
                                                _crewnames_PIC_duty_type,
                                            decoration: InputDecoration(
                                              border: InputBorder
                                                  .none, // Remove underline

                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 4.0,
                                                      horizontal: 5.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'SIC',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: AppFont.OutfitFont,
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              constraints: BoxConstraints(
                                                minHeight: 10.0,
                                                maxHeight: 100.0,
                                              ),
                                              child: SingleChildScrollView(
                                                child: TextField(
                                                  autocorrect: false,
                                                  enableSuggestions: false,
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color:
                                                          AppColor.textColor),
                                                  maxLines: null,
                                                  textCapitalization:
                                                      TextCapitalization
                                                          .characters,
                                                  controller: _crewnames_SIC,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 4.0,
                                                            horizontal: 5.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Container(
                                        constraints: BoxConstraints(
                                          minHeight: 10.0,
                                          maxHeight: 100.0,
                                        ),
                                        child: SingleChildScrollView(
                                          child: TextField(
                                            autocorrect: false,
                                            enableSuggestions: false,
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                color: AppColor.textColor),
                                            maxLines: null,
                                            textCapitalization:
                                                TextCapitalization.characters,
                                            controller:
                                                _crewnames_SIC_allowed_FDP,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 4.0,
                                                      horizontal: 5.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Table(
                                      border: TableBorder(
                                        verticalInside:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      children: [
                                        TableRow(children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Container(
                                              constraints: BoxConstraints(
                                                minHeight: 10.0,
                                                maxHeight: 100.0,
                                              ),
                                              child: SingleChildScrollView(
                                                child: TextField(
                                                  autocorrect: false,
                                                  enableSuggestions: false,
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color:
                                                          AppColor.textColor),
                                                  maxLines: null,
                                                  textCapitalization:
                                                      TextCapitalization
                                                          .characters,
                                                  controller:
                                                      _crewnames_SIC_actual_FDP_FDP_start,
                                                  readOnly: true,
                                                  onTap: () async {
                                                    TimeOfDay? pickedTime =
                                                        await showTimePicker(
                                                      context: context,
                                                      initialTime:
                                                          TimeOfDay.now(),
                                                      builder:
                                                          (context, child) {
                                                        return MediaQuery(
                                                          data: MediaQuery.of(
                                                                  context)
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
                                                      _crewnames_SIC_actual_FDP_FDP_start
                                                              .text =
                                                          formattedTime; // Update the controller's text
                                                      _calculateTotalTime(
                                                        _crewnames_SIC_actual_FDP_FDP_start
                                                            .text,
                                                        _crewnames_SIC_actual_FDP_FDP_finish
                                                            .text,
                                                        _crewnames_SIC_actual_FDP_total_FDP,
                                                      );
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                    border: InputBorder
                                                        .none, // Remove underline

                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 4.0,
                                                            horizontal: 5.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Container(
                                              constraints: BoxConstraints(
                                                minHeight: 10.0,
                                                maxHeight: 100.0,
                                              ),
                                              child: SingleChildScrollView(
                                                child: TextField(
                                                  autocorrect: false,
                                                  enableSuggestions: false,
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color:
                                                          AppColor.textColor),
                                                  maxLines: null,
                                                  textCapitalization:
                                                      TextCapitalization
                                                          .characters,
                                                  controller:
                                                      _crewnames_SIC_actual_FDP_FDP_finish,
                                                  readOnly: true,
                                                  onTap: () async {
                                                    TimeOfDay? pickedTime =
                                                        await showTimePicker(
                                                      context: context,
                                                      initialTime:
                                                          TimeOfDay.now(),
                                                      builder:
                                                          (context, child) {
                                                        return MediaQuery(
                                                          data: MediaQuery.of(
                                                                  context)
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
                                                      _crewnames_SIC_actual_FDP_FDP_finish
                                                              .text =
                                                          formattedTime; // Update the controller's text

                                                      _calculateTotalTime(
                                                        _crewnames_SIC_actual_FDP_FDP_start
                                                            .text,
                                                        _crewnames_SIC_actual_FDP_FDP_finish
                                                            .text,
                                                        _crewnames_SIC_actual_FDP_total_FDP,
                                                      );
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                    border: InputBorder
                                                        .none, // Remove underline

                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 4.0,
                                                            horizontal: 5.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Container(
                                              constraints: BoxConstraints(
                                                minHeight: 10.0,
                                                maxHeight: 100.0,
                                              ),
                                              child: SingleChildScrollView(
                                                child: TextField(
                                                  autocorrect: false,
                                                  enableSuggestions: false,
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color:
                                                          AppColor.textColor),
                                                  maxLines: null,
                                                  textCapitalization:
                                                      TextCapitalization
                                                          .characters,
                                                  controller:
                                                      _crewnames_SIC_actual_FDP_total_FDP,
                                                  readOnly: true,
                                                  // onTap: () async {
                                                  //   TimeOfDay? pickedTime = await showTimePicker(
                                                  //     context: context,
                                                  //     initialTime: TimeOfDay.now(),
                                                  //     builder: (context, child) {
                                                  //       return MediaQuery(
                                                  //         data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                                  //         child: child!,
                                                  //       );
                                                  //     },
                                                  //   );
                                                  //
                                                  //   if (pickedTime != null) {
                                                  //     // Format the selected time and update the TextField
                                                  //     String formattedTime =
                                                  //         '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                                                  //     _crewnames_SIC_actual_FDP_total_FDP.text = formattedTime; // Update the controller's text
                                                  //   }
                                                  // },
                                                  decoration: InputDecoration(
                                                    border: InputBorder
                                                        .none, // Remove underline

                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 4.0,
                                                            horizontal: 5.0),
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
                                        verticalInside:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      children: [
                                        TableRow(children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Container(
                                              constraints: BoxConstraints(
                                                minHeight: 10.0,
                                                maxHeight: 100.0,
                                              ),
                                              child: SingleChildScrollView(
                                                child: TextField(
                                                  autocorrect: false,
                                                  enableSuggestions: false,
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color:
                                                          AppColor.textColor),
                                                  maxLines: null,
                                                  textCapitalization:
                                                      TextCapitalization
                                                          .characters,
                                                  controller:
                                                      _crewnames_SIC_actual_duty_DP_start,
                                                  readOnly: true,
                                                  onTap: () async {
                                                    TimeOfDay? pickedTime =
                                                        await showTimePicker(
                                                      context: context,
                                                      initialTime:
                                                          TimeOfDay.now(),
                                                      builder:
                                                          (context, child) {
                                                        return MediaQuery(
                                                          data: MediaQuery.of(
                                                                  context)
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
                                                      _crewnames_SIC_actual_duty_DP_start
                                                              .text =
                                                          formattedTime; // Update the controller's text
                                                      _calculateTotalTime(
                                                        _crewnames_SIC_actual_duty_DP_start
                                                            .text,
                                                        _crewnames_SIC_actual_FDP_DP_finish
                                                            .text,
                                                        _crewnames_SIC_actual_FDP_toatl_DP,
                                                      );
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                    border: InputBorder
                                                        .none, // Remove underline

                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 4.0,
                                                            horizontal: 5.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Container(
                                              constraints: BoxConstraints(
                                                minHeight: 10.0,
                                                maxHeight: 100.0,
                                              ),
                                              child: SingleChildScrollView(
                                                child: TextField(
                                                  autocorrect: false,
                                                  enableSuggestions: false,
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color:
                                                          AppColor.textColor),
                                                  maxLines: null,
                                                  textCapitalization:
                                                      TextCapitalization
                                                          .characters,
                                                  controller:
                                                      _crewnames_SIC_actual_FDP_DP_finish,
                                                  readOnly: true,
                                                  onTap: () async {
                                                    TimeOfDay? pickedTime =
                                                        await showTimePicker(
                                                      context: context,
                                                      initialTime:
                                                          TimeOfDay.now(),
                                                      builder:
                                                          (context, child) {
                                                        return MediaQuery(
                                                          data: MediaQuery.of(
                                                                  context)
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
                                                      _crewnames_SIC_actual_FDP_DP_finish
                                                              .text =
                                                          formattedTime; // Update the controller's text

                                                      _calculateTotalTime(
                                                        _crewnames_SIC_actual_duty_DP_start
                                                            .text,
                                                        _crewnames_SIC_actual_FDP_DP_finish
                                                            .text,
                                                        _crewnames_SIC_actual_FDP_toatl_DP,
                                                      );
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 4.0,
                                                            horizontal: 5.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Container(
                                              constraints: BoxConstraints(
                                                minHeight: 10.0,
                                                maxHeight: 100.0,
                                              ),
                                              child: SingleChildScrollView(
                                                child: TextField(
                                                  autocorrect: false,
                                                  enableSuggestions: false,
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color:
                                                          AppColor.textColor),
                                                  maxLines: null,
                                                  textCapitalization:
                                                      TextCapitalization
                                                          .characters,
                                                  controller:
                                                      _crewnames_SIC_actual_FDP_toatl_DP,
                                                  readOnly: true,
                                                  // onTap: () async {
                                                  //   TimeOfDay? pickedTime = await showTimePicker(
                                                  //     context: context,
                                                  //     initialTime: TimeOfDay.now(),
                                                  //     builder: (context, child) {
                                                  //       return MediaQuery(
                                                  //         data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                                  //         child: child!,
                                                  //       );
                                                  //     },
                                                  //   );
                                                  //
                                                  //   if (pickedTime != null) {
                                                  //     // Format the selected time and update the TextField
                                                  //     String formattedTime =
                                                  //         '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                                                  //     _crewnames_SIC_actual_FDP_toatl_DP.text = formattedTime; // Update the controller's text
                                                  //   }
                                                  // },
                                                  decoration: InputDecoration(
                                                    border: InputBorder
                                                        .none, // Remove underline

                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 4.0,
                                                            horizontal: 5.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Container(
                                        constraints: BoxConstraints(
                                          minHeight: 10.0,
                                          maxHeight: 100.0,
                                        ),
                                        child: SingleChildScrollView(
                                          child: TextField(
                                            autocorrect: false,
                                            enableSuggestions: false,
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                color: AppColor.textColor),
                                            maxLines: null,
                                            textCapitalization:
                                                TextCapitalization.characters,
                                            controller:
                                                _crewnames_SIC_duty_type,
                                            decoration: InputDecoration(
                                              border: InputBorder
                                                  .none, // Remove underline

                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 4.0,
                                                      horizontal: 5.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'SIMI/SIME',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: AppFont.OutfitFont,
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              constraints: BoxConstraints(
                                                minHeight: 10.0,
                                                maxHeight: 100.0,
                                              ),
                                              child: SingleChildScrollView(
                                                child: TextField(
                                                  autocorrect: false,
                                                  enableSuggestions: false,
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color:
                                                          AppColor.textColor),
                                                  maxLines: null,
                                                  textCapitalization:
                                                      TextCapitalization
                                                          .characters,
                                                  controller:
                                                      _crewnames_SIM_SIME,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 4.0,
                                                            horizontal: 5.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Container(
                                        constraints: BoxConstraints(
                                          minHeight: 10.0,
                                          maxHeight: 100.0,
                                        ),
                                        child: SingleChildScrollView(
                                          child: TextField(
                                            autocorrect: false,
                                            enableSuggestions: false,
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                color: AppColor.textColor),
                                            maxLines: null,
                                            textCapitalization:
                                                TextCapitalization.characters,
                                            controller:
                                                _crewnames_SIM_SIME_allowed_FDP,
                                            decoration: InputDecoration(
                                              border: InputBorder
                                                  .none, // Remove underline

                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 4.0,
                                                      horizontal: 5.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Table(
                                      border: TableBorder(
                                        verticalInside:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      children: [
                                        TableRow(children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Container(
                                              constraints: BoxConstraints(
                                                minHeight: 10.0,
                                                maxHeight: 100.0,
                                              ),
                                              child: SingleChildScrollView(
                                                child: TextField(
                                                  autocorrect: false,
                                                  enableSuggestions: false,
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color:
                                                          AppColor.textColor),
                                                  maxLines: null,
                                                  textCapitalization:
                                                      TextCapitalization
                                                          .characters,
                                                  controller:
                                                      _crewnames_SIM_SIME_actual_FDP_FDP_start,
                                                  readOnly: true,
                                                  onTap: () async {
                                                    TimeOfDay? pickedTime =
                                                        await showTimePicker(
                                                      context: context,
                                                      initialTime:
                                                          TimeOfDay.now(),
                                                      builder:
                                                          (context, child) {
                                                        return MediaQuery(
                                                          data: MediaQuery.of(
                                                                  context)
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
                                                      _crewnames_SIM_SIME_actual_FDP_FDP_start
                                                              .text =
                                                          formattedTime; // Update the controller's text
                                                      _calculateTotalTime(
                                                        _crewnames_SIM_SIME_actual_FDP_FDP_start
                                                            .text,
                                                        _crewnames_SIM_SIME_actual_FDP_FDP_finish
                                                            .text,
                                                        _crewnames_SIM_SIME_actual_FDP_total_FDP,
                                                      );
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                    border: InputBorder
                                                        .none, // Remove underline

                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 4.0,
                                                            horizontal: 5.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Container(
                                              constraints: BoxConstraints(
                                                minHeight: 10.0,
                                                maxHeight: 100.0,
                                              ),
                                              child: SingleChildScrollView(
                                                child: TextField(
                                                  autocorrect: false,
                                                  enableSuggestions: false,
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color:
                                                          AppColor.textColor),
                                                  maxLines: null,
                                                  textCapitalization:
                                                      TextCapitalization
                                                          .characters,
                                                  controller:
                                                      _crewnames_SIM_SIME_actual_FDP_FDP_finish,
                                                  readOnly: true,
                                                  onTap: () async {
                                                    TimeOfDay? pickedTime =
                                                        await showTimePicker(
                                                      context: context,
                                                      initialTime:
                                                          TimeOfDay.now(),
                                                      builder:
                                                          (context, child) {
                                                        return MediaQuery(
                                                          data: MediaQuery.of(
                                                                  context)
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
                                                      _crewnames_SIM_SIME_actual_FDP_FDP_finish
                                                              .text =
                                                          formattedTime; // Update the controller's text

                                                      _calculateTotalTime(
                                                        _crewnames_SIM_SIME_actual_FDP_FDP_start
                                                            .text,
                                                        _crewnames_SIM_SIME_actual_FDP_FDP_finish
                                                            .text,
                                                        _crewnames_SIM_SIME_actual_FDP_total_FDP,
                                                      );
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                    border: InputBorder
                                                        .none, // Remove underline

                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 4.0,
                                                            horizontal: 5.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Container(
                                              constraints: BoxConstraints(
                                                minHeight: 10.0,
                                                maxHeight: 100.0,
                                              ),
                                              child: SingleChildScrollView(
                                                child: TextField(
                                                  autocorrect: false,
                                                  enableSuggestions: false,
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color:
                                                          AppColor.textColor),
                                                  maxLines: null,
                                                  textCapitalization:
                                                      TextCapitalization
                                                          .characters,
                                                  controller:
                                                      _crewnames_SIM_SIME_actual_FDP_total_FDP,
                                                  readOnly: true,
                                                  // onTap: () async {
                                                  //   TimeOfDay? pickedTime = await showTimePicker(
                                                  //     context: context,
                                                  //     initialTime: TimeOfDay.now(),
                                                  //     builder: (context, child) {
                                                  //       return MediaQuery(
                                                  //         data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                                  //         child: child!,
                                                  //       );
                                                  //     },
                                                  //   );
                                                  //
                                                  //   if (pickedTime != null) {
                                                  //     // Format the selected time and update the TextField
                                                  //     String formattedTime =
                                                  //         '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                                                  //     _crewnames_SIM_SIME_actual_FDP_total_FDP.text = formattedTime; // Update the controller's text
                                                  //   }
                                                  // },
                                                  decoration: InputDecoration(
                                                    border: InputBorder
                                                        .none, // Remove underline

                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 4.0,
                                                            horizontal: 5.0),
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
                                        verticalInside:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      children: [
                                        TableRow(children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Container(
                                              constraints: BoxConstraints(
                                                minHeight: 10.0,
                                                maxHeight: 100.0,
                                              ),
                                              child: SingleChildScrollView(
                                                child: TextField(
                                                  autocorrect: false,
                                                  enableSuggestions: false,
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color:
                                                          AppColor.textColor),
                                                  maxLines: null,
                                                  textCapitalization:
                                                      TextCapitalization
                                                          .characters,
                                                  controller:
                                                      _crewnames_SIM_SIME_actual_duty_DP_start,
                                                  readOnly: true,
                                                  onTap: () async {
                                                    TimeOfDay? pickedTime =
                                                        await showTimePicker(
                                                      context: context,
                                                      initialTime:
                                                          TimeOfDay.now(),
                                                      builder:
                                                          (context, child) {
                                                        return MediaQuery(
                                                          data: MediaQuery.of(
                                                                  context)
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
                                                      _crewnames_SIM_SIME_actual_duty_DP_start
                                                              .text =
                                                          formattedTime; // Update the controller's text
                                                      _calculateTotalTime(
                                                        _crewnames_SIM_SIME_actual_duty_DP_start
                                                            .text,
                                                        _crewnames_SIM_SIME_actual_FDP_DP_finish
                                                            .text,
                                                        _crewnames_SIM_SIME_actual_FDP_toatl_DP,
                                                      );
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                    border: InputBorder
                                                        .none, // Remove underline

                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 4.0,
                                                            horizontal: 5.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Container(
                                              constraints: BoxConstraints(
                                                minHeight: 10.0,
                                                maxHeight: 100.0,
                                              ),
                                              child: SingleChildScrollView(
                                                child: TextField(
                                                  autocorrect: false,
                                                  enableSuggestions: false,
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color:
                                                          AppColor.textColor),
                                                  maxLines: null,
                                                  textCapitalization:
                                                      TextCapitalization
                                                          .characters,
                                                  controller:
                                                      _crewnames_SIM_SIME_actual_FDP_DP_finish,
                                                  readOnly: true,
                                                  onTap: () async {
                                                    TimeOfDay? pickedTime =
                                                        await showTimePicker(
                                                      context: context,
                                                      initialTime:
                                                          TimeOfDay.now(),
                                                      builder:
                                                          (context, child) {
                                                        return MediaQuery(
                                                          data: MediaQuery.of(
                                                                  context)
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
                                                      _crewnames_SIM_SIME_actual_FDP_DP_finish
                                                              .text =
                                                          formattedTime; // Update the controller's text
                                                      _calculateTotalTime(
                                                        _crewnames_SIM_SIME_actual_duty_DP_start
                                                            .text,
                                                        _crewnames_SIM_SIME_actual_FDP_DP_finish
                                                            .text,
                                                        _crewnames_SIM_SIME_actual_FDP_toatl_DP,
                                                      );
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                    border: InputBorder
                                                        .none, // Remove underline

                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 4.0,
                                                            horizontal: 5.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Container(
                                              constraints: BoxConstraints(
                                                minHeight: 10.0,
                                                maxHeight: 100.0,
                                              ),
                                              child: SingleChildScrollView(
                                                child: TextField(
                                                  autocorrect: false,
                                                  enableSuggestions: false,
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color:
                                                          AppColor.textColor),
                                                  maxLines: null,
                                                  textCapitalization:
                                                      TextCapitalization
                                                          .characters,
                                                  controller:
                                                      _crewnames_SIM_SIME_actual_FDP_toatl_DP,
                                                  readOnly: true,
                                                  // onTap: () async {
                                                  //   TimeOfDay? pickedTime = await showTimePicker(
                                                  //     context: context,
                                                  //     initialTime: TimeOfDay.now(),
                                                  //     builder: (context, child) {
                                                  //       return MediaQuery(
                                                  //         data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                                  //         child: child!,
                                                  //       );
                                                  //     },
                                                  //   );
                                                  //
                                                  //   if (pickedTime != null) {
                                                  //     // Format the selected time and update the TextField
                                                  //     String formattedTime =
                                                  //         '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                                                  //     _crewnames_SIM_SIME_actual_FDP_toatl_DP.text = formattedTime; // Update the controller's text
                                                  //   }
                                                  // },
                                                  decoration: InputDecoration(
                                                    border: InputBorder
                                                        .none, // Remove underline

                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 4.0,
                                                            horizontal: 5.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Container(
                                        constraints: BoxConstraints(
                                          minHeight: 10.0,
                                          maxHeight: 100.0,
                                        ),
                                        child: SingleChildScrollView(
                                          child: TextField(
                                            autocorrect: false,
                                            enableSuggestions: false,
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                color: AppColor.textColor),
                                            maxLines: null,
                                            textCapitalization:
                                                TextCapitalization.characters,
                                            controller:
                                                _crewnames_SIM_SIME_duty_type,
                                            decoration: InputDecoration(
                                              border: InputBorder
                                                  .none, // Remove underline

                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 4.0,
                                                      horizontal: 5.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.all(0),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black12),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    // Left Side Section
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'Commander`s Discretion Report Filed?',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily:
                                                        AppFont.OutfitFont,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Checkbox(
                                                  value:
                                                      _commanders_discretion_report_filed,
                                                  activeColor:
                                                      AppColor.primaryColor,
                                                  checkColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                      color: Colors.grey,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4.0),
                                                  ),
                                                  onChanged: (bool? value) {
                                                    setState(() {
                                                      _commanders_discretion_report_filed =
                                                          value ?? false;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'Type of Discretion',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily:
                                                        AppFont.OutfitFont,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                const SizedBox(width: 20),
                                                Text(
                                                  'Extending',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily:
                                                        AppFont.OutfitFont,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Checkbox(
                                                  value:
                                                      _type_of_discretion_extending,
                                                  activeColor:
                                                      AppColor.primaryColor,
                                                  checkColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                      color: Colors.grey,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4.0),
                                                  ),
                                                  onChanged: (bool? value) {
                                                    setState(() {
                                                      _type_of_discretion_extending =
                                                          value ?? false;
                                                    });
                                                  },
                                                ),
                                                Text(
                                                  '/Reducing',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily:
                                                        AppFont.OutfitFont,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Checkbox(
                                                  value:
                                                      _type_of_discretion_reducing,
                                                  activeColor:
                                                      AppColor.primaryColor,
                                                  checkColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                      color: Colors.grey,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4.0),
                                                  ),
                                                  onChanged: (bool? value) {
                                                    setState(() {
                                                      _type_of_discretion_reducing =
                                                          value ?? false;
                                                    });
                                                  },
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
                            const SizedBox(height: 20),

                            Center(
                              child: Container(
                                child: SingleChildScrollView(
                                  primary: false,
                                  scrollDirection: Axis.horizontal,
                                  child: Table(
                                    border:
                                        TableBorder.all(color: Colors.black26),
                                    columnWidths: const {
                                      0: FixedColumnWidth(180.0),
                                      1: FixedColumnWidth(120.0),
                                      2: FixedColumnWidth(120.0),
                                      3: FixedColumnWidth(140.0),
                                      4: FixedColumnWidth(140.0),
                                      5: FixedColumnWidth(140.0),
                                      6: FixedColumnWidth(140.0),
                                      7: FixedColumnWidth(140.0),
                                      8: FixedColumnWidth(150.0),
                                      9: FixedColumnWidth(180.0),
                                      10: FixedColumnWidth(50.0),
                                    },
                                    children: [
                                      TableRow(children: [
                                        Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Text(
                                            'Flight Type**',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: AppFont.OutfitFont,
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Text(
                                            'A/C Type',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: AppFont.OutfitFont,
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Text(
                                            'A/C Registration',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: AppFont.OutfitFont,
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Text(
                                            'Departure Station',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: AppFont.OutfitFont,
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Text(
                                            'Arrival Station',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: AppFont.OutfitFont,
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Text(
                                            'Start up time',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: AppFont.OutfitFont,
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Text(
                                            'Shutdown time',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: AppFont.OutfitFont,
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Text(
                                            'Block Time',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: AppFont.OutfitFont,
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Text(
                                            'No. of Landings',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: AppFont.OutfitFont,
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Text(
                                            'Contract Type***',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: AppFont.OutfitFont,
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ]),

                                      // TableRow(children: [
                                      //   Padding(
                                      //     padding: const EdgeInsets.all(0),
                                      //     child: Container(
                                      //       constraints: const BoxConstraints(
                                      //         minHeight: 10.0,
                                      //         maxHeight: 100.0,
                                      //       ),
                                      //       child: SingleChildScrollView(
                                      //         child: TextField(
//                                       autocorrect: false,
// enableSuggestions: false,
                                      //           style: const TextStyle(
                                      //               fontSize: 16.0,
                                      //               color: AppColor.textColor),
                                      //           scrollPhysics:
                                      //               const NeverScrollableScrollPhysics(),
                                      //textCapitalization: TextCapitalization .characters,
                                      //controller: _flight_type,
                                      //           decoration: const InputDecoration(
                                      //             border: InputBorder.none,
                                      //
                                      //             contentPadding:
                                      //                 EdgeInsets.symmetric(
                                      //                     horizontal: 10.0),
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ),
                                      //   Padding(
                                      //     padding: const EdgeInsets.all(0),
                                      //     child: Container(
                                      //       constraints: const BoxConstraints(
                                      //         minHeight: 10.0,
                                      //         maxHeight: 100.0,
                                      //       ),
                                      //       child: SingleChildScrollView(
                                      //         child: TextField(
//                                       autocorrect: false,
// enableSuggestions: false,
                                      //           style: const TextStyle(
                                      //               fontSize: 16.0,
                                      //               color: AppColor.textColor),
                                      //           scrollPhysics:
                                      //               const NeverScrollableScrollPhysics(),
                                      //textCapitalization: TextCapitalization .characters,
                                      //controller: _a_c_type,
                                      //           decoration: const InputDecoration(
                                      //             border: InputBorder.none,
                                      //
                                      //             contentPadding:
                                      //                 EdgeInsets.symmetric(
                                      //                     horizontal: 10.0),
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ),
                                      //   Padding(
                                      //     padding: const EdgeInsets.all(0),
                                      //     child: Container(
                                      //       constraints: const BoxConstraints(
                                      //         minHeight: 10.0,
                                      //         maxHeight: 100.0,
                                      //       ),
                                      //       child: SingleChildScrollView(
                                      //         child: TextField(
//                                       autocorrect: false,
// enableSuggestions: false,
                                      //           style: const TextStyle(
                                      //               fontSize: 16.0,
                                      //               color: AppColor.textColor),
                                      //           scrollPhysics:
                                      //               const NeverScrollableScrollPhysics(),
                                      //textCapitalization: TextCapitalization .characters,
                                      //controller: _a_c_registration,
                                      //           decoration: const InputDecoration(
                                      //             border: InputBorder.none,
                                      //             contentPadding:
                                      //                 EdgeInsets.symmetric(
                                      //                     horizontal: 10.0),
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ),
                                      //   Padding(
                                      //     padding: const EdgeInsets.all(0),
                                      //     child: Container(
                                      //       constraints: const BoxConstraints(
                                      //         minHeight: 10.0,
                                      //         maxHeight: 100.0,
                                      //       ),
                                      //       child: SingleChildScrollView(
                                      //         child: TextField(
//                                       autocorrect: false,
// enableSuggestions: false,
                                      //           style: const TextStyle(
                                      //               fontSize: 16.0,
                                      //               color: AppColor.textColor),
                                      //           scrollPhysics:
                                      //               const NeverScrollableScrollPhysics(),
                                      //textCapitalization: TextCapitalization .characters,
                                      //controller: _departure_station,
                                      //           decoration: const InputDecoration(
                                      //             border: InputBorder.none,
                                      //             contentPadding:
                                      //                 EdgeInsets.symmetric(
                                      //                     horizontal: 10.0),
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ),
                                      //   Padding(
                                      //     padding: const EdgeInsets.all(0),
                                      //     child: Container(
                                      //       constraints: const BoxConstraints(
                                      //         minHeight: 10.0,
                                      //         maxHeight: 100.0,
                                      //       ),
                                      //       child: SingleChildScrollView(
                                      //         child: TextField(
//                                       autocorrect: false,
// enableSuggestions: false,
                                      //           style: const TextStyle(
                                      //               fontSize: 16.0,
                                      //               color: AppColor.textColor),
                                      //           scrollPhysics:
                                      //               const NeverScrollableScrollPhysics(),
                                      //textCapitalization: TextCapitalization .characters,
                                      //controller: _arrival_station ,
                                      //           decoration: const InputDecoration(
                                      //             border: InputBorder.none,
                                      //             contentPadding:
                                      //                 EdgeInsets.symmetric(
                                      //                     horizontal: 10.0),
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ),
                                      //   Padding(
                                      //     padding: const EdgeInsets.all(0),
                                      //     child: Container(
                                      //       constraints: const BoxConstraints(
                                      //         minHeight: 10.0,
                                      //         maxHeight: 100.0,
                                      //       ),
                                      //       child: SingleChildScrollView(
                                      //         child: TextField(
//                                       autocorrect: false,
// enableSuggestions: false,
                                      //           style: const TextStyle(
                                      //               fontSize: 16.0,
                                      //               color: AppColor.textColor),
                                      //           scrollPhysics:
                                      //               const NeverScrollableScrollPhysics(),
                                      //textCapitalization: TextCapitalization .characters,
                                      //controller: _start_up_time,
                                      //           decoration: const InputDecoration(
                                      //             border: InputBorder.none,
                                      //             contentPadding:
                                      //                 EdgeInsets.symmetric(
                                      //                     horizontal: 10.0),
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ),
                                      //   Padding(
                                      //     padding: const EdgeInsets.all(0),
                                      //     child: Container(
                                      //       constraints: const BoxConstraints(
                                      //         minHeight: 10.0,
                                      //         maxHeight: 100.0,
                                      //       ),
                                      //       child: SingleChildScrollView(
                                      //         child: TextField(
//                                       autocorrect: false,
// enableSuggestions: false,
                                      //           style: const TextStyle(
                                      //               fontSize: 16.0,
                                      //               color: AppColor.textColor),
                                      //           scrollPhysics:
                                      //               const NeverScrollableScrollPhysics(),
                                      //textCapitalization: TextCapitalization .characters,
                                      //controller: _shutdown_time,
                                      //           decoration: const InputDecoration(
                                      //             border: InputBorder.none,
                                      //             contentPadding:
                                      //                 EdgeInsets.symmetric(
                                      //                     horizontal: 10.0),
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ),
                                      //   Padding(
                                      //     padding: const EdgeInsets.all(0),
                                      //     child: Container(
                                      //       constraints: const BoxConstraints(
                                      //         minHeight: 10.0,
                                      //         maxHeight: 100.0,
                                      //       ),
                                      //       child: SingleChildScrollView(
                                      //         child: TextField(
//                                       autocorrect: false,
// enableSuggestions: false,
                                      //           style: const TextStyle(
                                      //               fontSize: 16.0,
                                      //               color: AppColor.textColor),
                                      //           scrollPhysics:
                                      //               const NeverScrollableScrollPhysics(),
                                      //textCapitalization: TextCapitalization .characters,
                                      //controller: _block_time,
                                      //           decoration: const InputDecoration(
                                      //             border: InputBorder.none,
                                      //             contentPadding:
                                      //                 EdgeInsets.symmetric(
                                      //                     horizontal: 10.0),
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ),
                                      //   Padding(
                                      //     padding: const EdgeInsets.all(0),
                                      //     child: Container(
                                      //       constraints: const BoxConstraints(
                                      //         minHeight: 10.0,
                                      //         maxHeight: 100.0,
                                      //       ),
                                      //       child: SingleChildScrollView(
                                      //         child: TextField(
//                                       autocorrect: false,
// enableSuggestions: false,
                                      //           style: const TextStyle(
                                      //               fontSize: 16.0,
                                      //               color: AppColor.textColor),
                                      //           scrollPhysics:
                                      //               const NeverScrollableScrollPhysics(),
                                      //textCapitalization: TextCapitalization .characters,
                                      //controller: _no_of_landings,
                                      //           decoration: const InputDecoration(
                                      //             border: InputBorder.none,
                                      //             contentPadding:
                                      //                 EdgeInsets.symmetric(
                                      //                     horizontal: 10.0),
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ),
                                      //   Padding(
                                      //     padding: const EdgeInsets.all(0),
                                      //     child: Container(
                                      //       constraints: const BoxConstraints(
                                      //         minHeight: 10.0,
                                      //         maxHeight: 100.0,
                                      //       ),
                                      //       child: SingleChildScrollView(
                                      //         child: TextField(
//                                       autocorrect: false,
// enableSuggestions: false,
                                      //           style: const TextStyle(
                                      //               fontSize: 16.0,
                                      //               color: AppColor.textColor),
                                      //           scrollPhysics:
                                      //               const NeverScrollableScrollPhysics(),
                                      //textCapitalization: TextCapitalization .characters,
                                      //controller: _contact_type,
                                      //           decoration: const InputDecoration(
                                      //             border: InputBorder.none,
                                      //             contentPadding:
                                      //                 EdgeInsets.symmetric(
                                      //                     horizontal: 10.0),
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ]),  tableDataCell2(row['takeofftime']!, isTimefield: true),

                                      // ...rows.map((row) {
                                      //   return TableRow(
                                      //     children: [
                                      //       tableDataCell(row['flight_type']!),
                                      //       tableDataCell(row['a_c_type']!),
                                      //       tableDataCell(row['a_c_registration']!),
                                      //       tableDataCell(row['departure_station']!),
                                      //       tableDataCell(row['arrival_station']!),
                                      //       tableDataCell(row['start_up_time']!, isTimefield: true),
                                      //       tableDataCell(row['shutdown_time']!, isTimefield: true),
                                      //       tableDataCell(row['block_time']!, isTimefield: true),
                                      //       tableDataCell(row['no_of_landings']!),
                                      //       tableDataCell(row['contact_type']!),
                                      //     ],
                                      //   );
                                      // }).toList(),

                                      ...rows.map((row) {
                                        return TableRow(
                                          children: [
                                            tableDataCell(row['flight_type']!),
                                            tableDataCell(row['a_c_type']!),
                                            tableDataCell(
                                                row['a_c_registration']!),
                                            tableDataCell(
                                                row['departure_station']!),
                                            tableDataCell(
                                                row['arrival_station']!),
                                            tableDataCell(row['start_up_time']!,
                                                isTimefield: true,
                                                row: row), // Pass row map
                                            tableDataCell(row['shutdown_time']!,
                                                isTimefield: true,
                                                row: row), // Pass row map
                                            tableDataCell(row['block_time']!,
                                                readOnly:
                                                    true), // No tap required
                                            tableDataCell(
                                                row['no_of_landings']!),
                                            tableDataCell(row['contact_type']!),
                                          ],
                                        );
                                      }).toList(),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 15),
                            // Action buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (_formStatus != 'completed') ...[
                                  ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Are you sure?'),
                                            content: Text(
                                                'Do you want to remove the row?'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  // Close the dialog and do not remove the row
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('No'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  // Close the dialog and remove the row
                                                  setState(() {
                                                    removeLastRow();
                                                  });
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('Yes'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: CircleBorder(),
                                      backgroundColor: Colors.grey,
                                      padding: EdgeInsets.all(5),
                                      minimumSize: Size(15, 15),
                                    ),
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 13,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  ElevatedButton(
                                    onPressed: () {
                                      // saveLocally();

                                      // setState(() {
                                      //   tableletestdata = '';
                                      // });
                                      // List<Map<String, String>> table1Data = [];
                                      // for (var row in rows) {
                                      //   Map<String, String> rowData = {};
                                      //   row.forEach((key, controller) {
                                      //     rowData[key] = controller.text;
                                      //   });
                                      //   table1Data.add(rowData);
                                      // }
                                      // Map<String, dynamic> jsonResponse = {
                                      //   'flightDetails': table1Data,
                                      // };
                                      // String tableDatejsonString = jsonEncode(jsonResponse);
                                      // setState(() {
                                      //   tableletestdata = tableDatejsonString;
                                      // });

                                      savetheformdata('partialy');

                                      if (rows.length < maxTripNo) {
                                        setState(() {
                                          addNewRow(rows.length + 1);
                                        });
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: CircleBorder(),
                                      backgroundColor: AppColor.primaryColor,
                                      padding: EdgeInsets.all(5),
                                      minimumSize: Size(15, 15),
                                    ),
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 13,
                                    ),
                                  ),
                                ]
                              ],
                            ),

                            const SizedBox(height: 10),
                            Center(
                              child: Container(
                                child: SingleChildScrollView(
                                  primary: false,
                                  scrollDirection: Axis.horizontal,
                                  child: Table(
                                    border:
                                        TableBorder.all(color: Colors.black26),
                                    columnWidths: const {
                                      0: FixedColumnWidth(250.0),
                                      1: FixedColumnWidth(250.0),
                                      2: FixedColumnWidth(250.0),
                                    },
                                    children: [
                                      TableRow(children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Total Block Time:',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Container(
                                                constraints:
                                                    const BoxConstraints(
                                                  minHeight: 10.0,
                                                  maxHeight: 100.0,
                                                ),
                                                child: TextField(
                                                  autocorrect: false,
                                                  enableSuggestions: false,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    fontSize: 16.0,
                                                    color: AppColor.textColor,
                                                  ),
                                                  scrollPhysics:
                                                      const NeverScrollableScrollPhysics(),
                                                  textCapitalization:
                                                      TextCapitalization
                                                          .characters,
                                                  controller: _total_block_time,
                                                  readOnly: true,
                                                  // onTap: () async {
                                                  //   TimeOfDay? pickedTime = await showTimePicker(
                                                  //     context: context,
                                                  //     initialTime: TimeOfDay.now(),
                                                  //     builder: (context, child) {
                                                  //       return MediaQuery(
                                                  //         data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                                  //         child: child!,
                                                  //       );
                                                  //     },
                                                  //   );
                                                  //
                                                  //   if (pickedTime != null) {
                                                  //     // Format the selected time and update the TextField
                                                  //     String formattedTime =
                                                  //         '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                                                  //     _total_block_time.text = formattedTime; // Update the controller's text
                                                  //   }
                                                  // },
                                                  decoration:
                                                      const InputDecoration(
                                                    border: InputBorder.none,
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10.0),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Total No of Landings:',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Container(
                                                constraints:
                                                    const BoxConstraints(
                                                  minHeight: 10.0,
                                                  maxHeight: 100.0,
                                                ),
                                                child: TextField(
                                                  autocorrect: false,
                                                  enableSuggestions: false,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    fontSize: 16.0,
                                                    color: AppColor.textColor,
                                                  ),
                                                  scrollPhysics:
                                                      const NeverScrollableScrollPhysics(),
                                                  textCapitalization:
                                                      TextCapitalization
                                                          .characters,
                                                  controller:
                                                      _total_no_of_landings,
                                                  readOnly: true,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration:
                                                      const InputDecoration(
                                                    border: InputBorder.none,
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10.0),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Total No. of IFR Approaches',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Container(
                                                constraints:
                                                    const BoxConstraints(
                                                  minHeight: 10.0,
                                                  maxHeight: 100.0,
                                                ),
                                                child: TextField(
                                                  autocorrect: false,
                                                  enableSuggestions: false,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    fontSize: 16.0,
                                                    color: AppColor.textColor,
                                                  ),
                                                  scrollPhysics:
                                                      const NeverScrollableScrollPhysics(),
                                                  textCapitalization:
                                                      TextCapitalization
                                                          .characters,
                                                  controller:
                                                      _total_no_of_ifr_approaches,
                                                  decoration:
                                                      const InputDecoration(
                                                    border: InputBorder.none,
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10.0),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            const SizedBox(height: 20),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Split Duty Record',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: AppFont.OutfitFont,
                                          color: AppColor.primaryColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            Center(
                              child: Container(
                                child: SingleChildScrollView(
                                  primary: false,
                                  scrollDirection: Axis.horizontal,
                                  child: Table(
                                    border:
                                        TableBorder.all(color: Colors.black26),
                                    columnWidths: const {
                                      0: FixedColumnWidth(250.0),
                                      1: FixedColumnWidth(150.0),
                                      2: FixedColumnWidth(200.0),
                                      3: FixedColumnWidth(140.0),
                                      4: FixedColumnWidth(140.0),
                                      5: FixedColumnWidth(140.0),
                                    },
                                    children: [
                                      TableRow(children: [
                                        Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Text(
                                            'Time Of (After 15 min post flight)',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: AppFont.OutfitFont,
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: Container(
                                            constraints: const BoxConstraints(
                                              minHeight: 10.0,
                                              maxHeight: 100.0,
                                            ),
                                            child: SingleChildScrollView(
                                              child: TextField(
                                                autocorrect: false,
                                                enableSuggestions: false,
                                                style: const TextStyle(
                                                    fontSize: 16.0,
                                                    color: AppColor.textColor),
                                                scrollPhysics:
                                                    const NeverScrollableScrollPhysics(),
                                                textCapitalization:
                                                    TextCapitalization
                                                        .characters,
                                                controller: _sdr_time_of,
                                                readOnly: true,
                                                onTap: () async {
                                                  TimeOfDay? pickedTime =
                                                      await showTimePicker(
                                                    context: context,
                                                    initialTime:
                                                        TimeOfDay.now(),
                                                    builder: (context, child) {
                                                      return MediaQuery(
                                                        data: MediaQuery.of(
                                                                context)
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
                                                    _sdr_time_of.text =
                                                        formattedTime; // Update the controller's text
                                                  }
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                  border: InputBorder.none,
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 10.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Text(
                                            'Time On (Incl 30 min Pre Flight)',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: AppFont.OutfitFont,
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: Container(
                                            constraints: const BoxConstraints(
                                              minHeight: 10.0,
                                              maxHeight: 100.0,
                                            ),
                                            child: SingleChildScrollView(
                                              child: TextField(
                                                autocorrect: false,
                                                enableSuggestions: false,
                                                style: const TextStyle(
                                                    fontSize: 16.0,
                                                    color: AppColor.textColor),
                                                scrollPhysics:
                                                    const NeverScrollableScrollPhysics(),
                                                textCapitalization:
                                                    TextCapitalization
                                                        .characters,
                                                controller: _sdr_time_on,
                                                readOnly: true,
                                                onTap: () async {
                                                  TimeOfDay? pickedTime =
                                                      await showTimePicker(
                                                    context: context,
                                                    initialTime:
                                                        TimeOfDay.now(),
                                                    builder: (context, child) {
                                                      return MediaQuery(
                                                        data: MediaQuery.of(
                                                                context)
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
                                                    _sdr_time_on.text =
                                                        formattedTime; // Update the controller's text
                                                  }
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                  border: InputBorder.none,
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 10.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Text(
                                            'Rest (HRS)',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: AppFont.OutfitFont,
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: Container(
                                            constraints: const BoxConstraints(
                                              minHeight: 10.0,
                                              maxHeight: 100.0,
                                            ),
                                            child: SingleChildScrollView(
                                              child: TextField(
                                                autocorrect: false,
                                                enableSuggestions: false,
                                                style: const TextStyle(
                                                    fontSize: 16.0,
                                                    color: AppColor.textColor),
                                                scrollPhysics:
                                                    const NeverScrollableScrollPhysics(),
                                                textCapitalization:
                                                    TextCapitalization
                                                        .characters,
                                                controller: _sdr_rest,
                                                readOnly: true,
                                                onTap: () async {
                                                  TimeOfDay? pickedTime =
                                                      await showTimePicker(
                                                    context: context,
                                                    initialTime:
                                                        TimeOfDay.now(),
                                                    builder: (context, child) {
                                                      return MediaQuery(
                                                        data: MediaQuery.of(
                                                                context)
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
                                                    _sdr_rest.text =
                                                        formattedTime; // Update the controller's text
                                                  }
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                  border: InputBorder.none,
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 10.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Text(
                                            'Credit (HRS)',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: AppFont.OutfitFont,
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: Container(
                                            constraints: const BoxConstraints(
                                              minHeight: 10.0,
                                              maxHeight: 100.0,
                                            ),
                                            child: SingleChildScrollView(
                                              child: TextField(
                                                autocorrect: false,
                                                enableSuggestions: false,
                                                style: const TextStyle(
                                                    fontSize: 16.0,
                                                    color: AppColor.textColor),
                                                scrollPhysics:
                                                    const NeverScrollableScrollPhysics(),
                                                textCapitalization:
                                                    TextCapitalization
                                                        .characters,
                                                controller: _sdr_credit,
                                                readOnly: true,
                                                onTap: () async {
                                                  TimeOfDay? pickedTime =
                                                      await showTimePicker(
                                                    context: context,
                                                    initialTime:
                                                        TimeOfDay.now(),
                                                    builder: (context, child) {
                                                      return MediaQuery(
                                                        data: MediaQuery.of(
                                                                context)
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
                                                    _sdr_credit.text =
                                                        formattedTime; // Update the controller's text
                                                  }
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                  border: InputBorder.none,
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 10.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Text(
                                            'Max FDP (With Split)',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: AppFont.OutfitFont,
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: Container(
                                            constraints: const BoxConstraints(
                                              minHeight: 10.0,
                                              maxHeight: 100.0,
                                            ),
                                            child: SingleChildScrollView(
                                              child: TextField(
                                                autocorrect: false,
                                                enableSuggestions: false,
                                                style: const TextStyle(
                                                    fontSize: 16.0,
                                                    color: AppColor.textColor),
                                                scrollPhysics:
                                                    const NeverScrollableScrollPhysics(),
                                                textCapitalization:
                                                    TextCapitalization
                                                        .characters,
                                                controller: _sdr_max_FDP,
                                                readOnly: true,
                                                onTap: () async {
                                                  TimeOfDay? pickedTime =
                                                      await showTimePicker(
                                                    context: context,
                                                    initialTime:
                                                        TimeOfDay.now(),
                                                    builder: (context, child) {
                                                      return MediaQuery(
                                                        data: MediaQuery.of(
                                                                context)
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
                                                    _sdr_max_FDP.text =
                                                        formattedTime; // Update the controller's text
                                                  }
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                  border: InputBorder.none,
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 10.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Text(
                                            'Actual FDP',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: AppFont.OutfitFont,
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: Container(
                                            constraints: const BoxConstraints(
                                              minHeight: 10.0,
                                              maxHeight: 100.0,
                                            ),
                                            child: SingleChildScrollView(
                                              child: TextField(
                                                autocorrect: false,
                                                enableSuggestions: false,
                                                style: const TextStyle(
                                                    fontSize: 16.0,
                                                    color: AppColor.textColor),
                                                scrollPhysics:
                                                    const NeverScrollableScrollPhysics(),
                                                textCapitalization:
                                                    TextCapitalization
                                                        .characters,
                                                controller: _sdr_actual_FDP,
                                                readOnly: true,
                                                onTap: () async {
                                                  TimeOfDay? pickedTime =
                                                      await showTimePicker(
                                                    context: context,
                                                    initialTime:
                                                        TimeOfDay.now(),
                                                    builder: (context, child) {
                                                      return MediaQuery(
                                                        data: MediaQuery.of(
                                                                context)
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
                                                    _sdr_actual_FDP.text =
                                                        formattedTime; // Update the controller's text
                                                  }
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                  border: InputBorder.none,
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 10.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]),
                                    ],
                                  ),
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
                                      Text('Crew Comments : ',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: AppFont.OutfitFont,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                          )),
                                      const SizedBox(width: 25),
                                      Expanded(
                                        child: TextField(
                                          autocorrect: false,
                                          enableSuggestions: false,
                                          textCapitalization:
                                              TextCapitalization.characters,
                                          controller: _crew_comments,
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

                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text('Owner Signature :',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: AppFont.OutfitFont,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                          )),
                                      const SizedBox(width: 0),
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
                                // const SizedBox(width: 5),
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                          'Reviewed\nby OPS : ', // Label for the first text field
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: AppFont.OutfitFont,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                          )),
                                      const SizedBox(width: 5),
                                      Expanded(
                                        child: TextField(
                                          autocorrect: false,
                                          enableSuggestions: false,
                                          textCapitalization:
                                              TextCapitalization.characters,
                                          controller: _reviewd_by_ops,
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
                                      Text(
                                          'Electronically \n Recorded : ', // Label for the first text field
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: AppFont.OutfitFont,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                          )),
                                      const SizedBox(width: 5),
                                      Expanded(
                                        child: TextField(
                                          autocorrect: false,
                                          enableSuggestions: false,
                                          textCapitalization:
                                              TextCapitalization.characters,
                                          controller: _electronically_recorded,
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

                            SizedBox(height: 15),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "OCC/FOR/14",
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


                            const SizedBox(height: 25),

                            if (_formStatus != 'completed') ...[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
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
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // EasyLoading.show( status: 'Updating...');
                                        // SaveFuntioning();

                                        print('this is sithe fom data');

                                        if (!_userSign) {
                                          EasyLoading.showInfo(
                                              'Please Sign in to continue');
                                        } else {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text('Confirmation'),
                                                content: Text(
                                                    'Do you want to save your changes?'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      // Close the dialog without saving
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text('No'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      EasyLoading.show(
                                                          status: 'Saving...');
                                                      savetheformdata(
                                                          'completed');
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text('Yes'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }
                                      },
                                      style: ButtonStyle(
                                        foregroundColor:
                                            WidgetStateProperty.resolveWith(
                                                (states) {
                                          if (states
                                              .contains(WidgetState.pressed)) {
                                            return Colors.white;
                                          }
                                          return Colors.white70;
                                        }),
                                        backgroundColor:
                                            WidgetStateProperty.resolveWith(
                                                (states) {
                                          if (states
                                              .contains(WidgetState.pressed)) {
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
    );
  }

  //
  // Widget tableDataCell( dynamic value,{ bool isTimefield = false}) {
  //   return Padding(
  //     padding: const EdgeInsets.all(0),
  //     child: Container(
  //       constraints: const BoxConstraints(minHeight: 10.0, maxHeight: 100.0),
  //       child: SingleChildScrollView(
  //         child: TextField(
//   autocorrect: false,
// enableSuggestions: false,
  //           textCapitalization: TextCapitalization .characters,
  //           controller: value as TextEditingController,
  //           // readOnly: isReadOnly,
  //           style: const TextStyle(fontSize: 16.0, color: Colors.black),
  //           decoration: const InputDecoration(
  //             border: InputBorder.none,
  //             contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
  //           ),
  //
  //           onTap: isTimefield
  //               ? () async {
  //             TimeOfDay? pickedTime = await showTimePicker(
  //               context: context,
  //               initialTime: TimeOfDay.now(),
  //               builder: (context, child) {
  //                 return MediaQuery(
  //                   data: MediaQuery.of(context)
  //                       .copyWith(alwaysUse24HourFormat: true),
  //                   child: child!,
  //                 );
  //               },
  //             );
  //             if (pickedTime != null) {
  //               String formattedTime =
  //                   '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
  //               (value as TextEditingController).text =
  //                   formattedTime;
  //             }
  //           }
  //               : null,
  //
  //
  //
  //         ),
  //       ),
  //     ),
  //   );
  // }
  //

  Widget tableDataCell(
    dynamic value, {
    bool isTimefield = false,
    Map<String, TextEditingController>? row,
    bool readOnly = false,
  }) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Container(
        constraints: const BoxConstraints(minHeight: 10.0, maxHeight: 100.0),
        child: SingleChildScrollView(
          child: TextField(
            autocorrect: false,
            enableSuggestions: false,
            textCapitalization: TextCapitalization.characters,
            controller: value as TextEditingController,
            readOnly: readOnly || isTimefield, // Make it read-only if specified
            style: const TextStyle(fontSize: 16.0, color: Colors.black),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
            ),
            onTap: isTimefield && !readOnly && row != null
                ? () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                      builder: (context, child) {
                        return MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(alwaysUse24HourFormat: true),
                          child: child!,
                        );
                      },
                    );
                    if (pickedTime != null) {
                      String formattedTime =
                          '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                      (value as TextEditingController).text = formattedTime;

                      // Recalculate Block Time if required
                      if (row?['start_up_time'] != null &&
                          row?['shutdown_time'] != null &&
                          row?['block_time'] != null) {
                        _calculateBlockTime(
                          row!['start_up_time']!,
                          row['shutdown_time']!,
                          row['block_time']!,
                        );
                      }
                    }
                  }
                : null,
          ),
        ),
      ),
    );
  }

  //updata time.

  void __sumOfTotalsFields() {
    Duration totalDuration = Duration();
    int totalLandings = 0;
    for (final row in rows) {
      if (row['block_time']?.text.isNotEmpty ?? false) {
        final blockTimeParts = row['block_time']!.text.split(':');
        final blockTime = Duration(
          hours: int.parse(blockTimeParts[0]),
          minutes: int.parse(blockTimeParts[1]),
        );
        totalDuration += blockTime;
      }

      if (row['no_of_landings']?.text.isNotEmpty ?? false) {
        totalLandings += int.parse(row['no_of_landings']!.text);
      }
    }

    final int totalHours = totalDuration.inHours;
    final int totalMinutes = totalDuration.inMinutes % 60;
    final String formattedTime =
        '${totalHours.toString().padLeft(2, '0')}:${totalMinutes.toString().padLeft(2, '0')}';

    print('Total Block Time: $formattedTime');
    print('Total Landings: $totalLandings');
    _total_block_time.text = formattedTime;
    _total_no_of_landings.text = totalLandings
        .toString(); // Assuming a TextEditingController exists for total landings
  }

  Future<void> savetheformdata(String status) async {
    __sumOfTotalsFields();

    setState(() {
      tableletestdata = '';
    });
    List<Map<String, String>> table1Data = [];
    for (var row in rows) {
      Map<String, String> rowData = {};
      row.forEach((key, controller) {
        rowData[key] = controller.text;
      });
      table1Data.add(rowData);
    }
    Map<String, dynamic> jsonResponse = {
      'flightDetails': table1Data,
    };
    String tableDatejsonString = jsonEncode(jsonResponse);
    setState(() {
      tableletestdata = tableDatejsonString;
    });

    var aircraft = {
      "aircraftId": selectMaingroupId,
      "aircraftType": selectMaingroup,
      "aircraftRegId": selectedGroupId_id,
      "aircraftRegistration": selectedGroupName
    };

    var crewnames = {
      "crewnames_PIC": _crewnames_PIC.text,
      "crewnames_SIC": _crewnames_SIC.text,
      "crewnames_SIM_SIME": _crewnames_SIM_SIME.text,
      "crewnames_PIC_allowed_FDP": _crewnames_PIC_allowed_FDP.text,
      "crewnames_SIC_allowed_FDP": _crewnames_SIC_allowed_FDP.text,
      "crewnames_SIM_SIME_allowed_FDP": _crewnames_SIM_SIME_allowed_FDP.text,
      "crewnames_PIC_actual_FDP_FDP_start":
          _crewnames_PIC_actual_FDP_FDP_start.text,
      "crewnames_SIC_actual_FDP_FDP_start":
          _crewnames_SIC_actual_FDP_FDP_start.text,
      "crewnames_SIM_SIME_actual_FDP_FDP_start":
          _crewnames_SIM_SIME_actual_FDP_FDP_start.text,
      "crewnames_PIC_actual_FDP_FDP_finish":
          _crewnames_PIC_actual_FDP_FDP_finish.text,
      "crewnames_SIC_actual_FDP_FDP_finish":
          _crewnames_SIC_actual_FDP_FDP_finish.text,
      "crewnames_SIM_SIME_actual_FDP_FDP_finish":
          _crewnames_SIM_SIME_actual_FDP_FDP_finish.text,
      "crewnames_PIC_actual_FDP_total_FDP":
          _crewnames_PIC_actual_FDP_total_FDP.text,
      "crewnames_SIC_actual_FDP_total_FDP":
          _crewnames_SIC_actual_FDP_total_FDP.text,
      "crewnames_SIM_SIME_actual_FDP_total_FDP":
          _crewnames_SIM_SIME_actual_FDP_total_FDP.text,
      "crewnames_PIC_actual_duty_DP_start":
          _crewnames_PIC_actual_duty_DP_start.text,
      "crewnames_SIC_actual_duty_DP_start":
          _crewnames_SIC_actual_duty_DP_start.text,
      "crewnames_SIM_SIME_actual_duty_DP_start":
          _crewnames_SIM_SIME_actual_duty_DP_start.text,
      "crewnames_PIC_actual_FDP_DP_finish":
          _crewnames_PIC_actual_FDP_DP_finish.text,
      "crewnames_SIC_actual_FDP_DP_finish":
          _crewnames_SIC_actual_FDP_DP_finish.text,
      "crewnames_SIM_SIME_actual_FDP_DP_finish":
          _crewnames_SIM_SIME_actual_FDP_DP_finish.text,
      "crewnames_PIC_actual_FDP_toatl_DP":
          _crewnames_PIC_actual_FDP_toatl_DP.text,
      "crewnames_SIC_actual_FDP_toatl_DP":
          _crewnames_SIC_actual_FDP_toatl_DP.text,
      "crewnames_SIM_SIME_actual_FDP_toatl_DP":
          _crewnames_SIM_SIME_actual_FDP_toatl_DP.text,
      "crewnames_PIC_duty_type": _crewnames_PIC_duty_type.text,
      "crewnames_SIC_duty_type": _crewnames_SIC_duty_type.text,
      "crewnames_SIM_SIME_duty_type": _crewnames_SIM_SIME_duty_type.text,
    };

    var sign = {
      "commanders_discretion_report_filed":
          _commanders_discretion_report_filed ? 1 : 0,
      "type_of_discretion_extending": _type_of_discretion_extending ? 1 : 0,
      "type_of_discretion_reducing": _type_of_discretion_reducing ? 1 : 0,
      "userSign": _userSign ? 1 : 0,
    };

    var data = {
      "customer": fullName,
      "aircraft": aircraft,
      "crewnames": crewnames,
      "sign": sign,
      "tableValues": tableletestdata,
      "total_block_time": _total_block_time.text,
      "total_no_of_landings": _total_no_of_landings.text,
      "total_no_of_ifr_approaches": _total_no_of_ifr_approaches.text,
      "sdr_time_of": _sdr_time_of.text,
      "sdr_time_on": _sdr_time_on.text,
      "sdr_rest": _sdr_rest.text,
      "sdr_credit": _sdr_credit.text,
      "sdr_max_FDP": _sdr_max_FDP.text,
      "sdr_actual_FDP": _sdr_actual_FDP.text,
      "crew_comments": _crew_comments.text,
      "reviewd_by_ops": _reviewd_by_ops.text,
      "electronically_recorded": _electronically_recorded.text,
    };

    print(data);

    try {
      var response = await http.Client().post(
        Uri.parse(
            "${AppUrls.formdata}?formid=$formId&formrefno=$rotery_wing_journey_log"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $userToken"
        },
        body: jsonEncode({"data": data, "status": status}),
      );

      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        final responseData = json.decode(response.body);

        print('------------3-3-3-3-3-3');
        print(responseData);
        EasyLoading.showToast('Saved Success');

        if (status == 'completed') {
          formdata_pass_backend(UserID, userToken);
        }
      } else {
        EasyLoading.dismiss();
        final responseData = json.decode(response.body);
        print(responseData);
        EasyLoading.showToast('Something went wrong');
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
