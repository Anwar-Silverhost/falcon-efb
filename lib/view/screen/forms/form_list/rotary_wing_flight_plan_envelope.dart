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

class RotaryWingFlightPlanEnvelope extends StatefulWidget {
  const RotaryWingFlightPlanEnvelope({super.key});

  @override
  State<RotaryWingFlightPlanEnvelope> createState() =>
      _RotaryWingFlightPlanEnvelopeState();
}

class _RotaryWingFlightPlanEnvelopeState
    extends State<RotaryWingFlightPlanEnvelope> {
  final TextEditingController _Route = TextEditingController();
  final TextEditingController _Capt = TextEditingController();
  final TextEditingController _F_O = TextEditingController();
  final TextEditingController _Client = TextEditingController();
  final TextEditingController _ETD = TextEditingController();
  final TextEditingController _ATD = TextEditingController();

  bool _Pre_FC_flight_plan_ops = false;
  bool _Pre_FC_flight_plan_crew = false;
  bool _Post_FC_leon_update_ops = false;
  bool _Post_FC_leon_update_crew = false;

  bool _Pre_FC_weather_notams_ops = false;
  bool _Pre_FC_weather_notams_crew = false;
  bool _Post_FC_cfr_and_w_b_sheet_ops = false;
  bool _Post_FC_cfr_and_w_b_sheet_crew = false;

  bool _Pre_FC_journy_log_ops = false;
  bool _Pre_FC_journy_log_crew = false;
  bool _Post_FC_journy_log_ops = false;
  bool _Post_FC_journy_log_crew = false;

  bool _Pre_FC_cfr_and_w_b_sheet_ops = false;
  bool _Pre_FC_cfr_and_w_b_sheet_crew = false;
  bool _Post_FC_flight_plan_ops = false;
  bool _Post_FC_flight_plan_crew = false;

  bool _Pre_FC_update_ivll_ops = false;
  bool _Pre_FC_update_ivll_crew = false;
  bool _Post_FC_notams_wx_brief_ops = false;
  bool _Post_FC_notams_wx_brief_crew = false;

  bool _Pre_FC_updated_field_maps_ops = false;
  bool _Pre_FC_updated_field_maps_crew = false;
  bool _Post_FC_fuel_bills_ops = false;
  bool _Post_FC_fuel_bills_crew = false;

  bool _Pre_FC_aircraft_search_checklist_ops = false;
  bool _Pre_FC_aircraft_search_checklist_crew = false;
  bool _Post_FC_reporting_forms_ops = false;
  bool _Post_FC_reporting_forms_crew = false;

  bool _Pre_FC_notoc_ops = false;
  bool _Pre_FC_notoc_crew = false;
  bool _Post_FC_notoc_ops = false;
  bool _Post_FC_notoc_crew = false;

  bool _Pre_FC_license_medical_expiry_crew = false;
  bool _Post_FC_aircraft_search_checklist_ops = false;
  bool _Post_FC_aircraft_search_checklist_crew = false;

  bool _Pre_FC_crew_lounge_docs_ntas_crew = false;
  bool _Post_FC_tech_log_ops = false;
  bool _Post_FC_tech_log_crew = false;

  bool _Pre_FC_pax_manifest_crew = false;
  bool _Post_FC_pax_manifest_ops = false;
  bool _Post_FC_pax_manifest_crew = false;

  bool _crew_briefing_1 = false;
  bool _crew_briefing_2 = false;
  bool _crew_briefing_3 = false;
  bool _crew_briefing_4 = false;
  bool _crew_briefing_5 = false;
  bool _crew_briefing_6 = false;
  bool _crew_briefing_7 = false;
  bool _crew_briefing_8 = false;
  bool _crew_briefing_9 = false;
  bool _crew_briefing_10 = false;

  bool _userSign = false;

  final TextEditingController _Remarks = TextEditingController();

  var formId = 'FAF06';
  var currentDate =
      "${DateTime.now().day.toString().padLeft(2, '0')}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().year}";
  String _formStatus = '';
  String userToken = '';
  String fullName = '';
  String selectedGroupName = '';
  List<dynamic> apps = [];
  String profilePic = '';
  String UserID = '';
  String selectedGroupId_id = '';

  String selectMaingroup = '';
  String selectMaingroupId = '';

  String rotary_wing_flight_plan_envelope = '';

  var profile = dummyProfile;

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
        final responseData = json.decode(response.body);

        setState(() {
          rotary_wing_flight_plan_envelope =
              responseData['data']['form_ref_no'];
        });
        print(rotary_wing_flight_plan_envelope);

        if ((responseData['data']['form_status']) != 'notcomplet') {
          setState(() {
            _formStatus = responseData['data']['form_status'];
            _Route.text =
                responseData['data']['form_data']['flightRoute']['route'] ?? '';
            _Capt.text =
                responseData['data']['form_data']['flightRoute']['capt'] ?? '';
            _F_O.text =
                responseData['data']['form_data']['flightRoute']['f_o'] ?? '';
            _Client.text = responseData['data']['form_data']['flightRoute']
                    ['client'] ??
                '';
            _ETD.text =
                responseData['data']['form_data']['flightRoute']['etd'] ?? '';
            _ATD.text =
                responseData['data']['form_data']['flightRoute']['atd'] ?? '';

            if (responseData['data']['form_status'] == 'completed') {
              _userSign = true;
            }

            if ((responseData['data']['form_data']['pre_flight_checklist']
                    ['1_FLIGHT_PLANS_ops']) ==
                1) {
              _Pre_FC_flight_plan_ops = true;
            } else {
              _Pre_FC_flight_plan_ops = false;
            }

            if ((responseData['data']['form_data']['pre_flight_checklist']
                    ['1_FLIGHT_PLANS_ops']) ==
                1) {
              _Pre_FC_flight_plan_ops = true;
            } else {
              _Pre_FC_flight_plan_ops = false;
            }

            if ((responseData['data']['form_data']['pre_flight_checklist']
                    ['1_FLIGHT_PLANS_crew']) ==
                1) {
              _Pre_FC_flight_plan_crew = true;
            } else {
              _Pre_FC_flight_plan_crew = false;
            }
            if ((responseData['data']['form_data']['pre_flight_checklist']
                    ['2_WEATHER_NOTAMS_ops']) ==
                1) {
              _Pre_FC_weather_notams_ops = true;
            } else {
              _Pre_FC_weather_notams_ops = false;
            }
            if ((responseData['data']['form_data']['pre_flight_checklist']
                    ['2_WEATHER_NOTAMS_crew']) ==
                1) {
              _Pre_FC_weather_notams_crew = true;
            } else {
              _Pre_FC_weather_notams_crew = false;
            }
            if ((responseData['data']['form_data']['pre_flight_checklist']
                    ['3_JOURNEY_LOG_ops']) ==
                1) {
              _Pre_FC_journy_log_ops = true;
            } else {
              _Pre_FC_journy_log_ops = false;
            }
            if ((responseData['data']['form_data']['pre_flight_checklist']
                    ['3_JOURNEY_LOG_crew']) ==
                1) {
              _Pre_FC_journy_log_crew = true;
            } else {
              _Pre_FC_journy_log_crew = false;
            }

            if ((responseData['data']['form_data']['pre_flight_checklist']
                    ['4_CFR_AND_W_B_SHEET_ops']) ==
                1) {
              _Pre_FC_cfr_and_w_b_sheet_ops = true;
            } else {
              _Pre_FC_cfr_and_w_b_sheet_ops = false;
            }
            if ((responseData['data']['form_data']['pre_flight_checklist']
                    ['4_CFR_AND_W_B_SHEET_crew']) ==
                1) {
              _Pre_FC_cfr_and_w_b_sheet_crew = true;
            } else {
              _Pre_FC_cfr_and_w_b_sheet_crew = false;
            }

            if ((responseData['data']['form_data']['pre_flight_checklist']
                    ['5_UPDATED_IVLL_ops']) ==
                1) {
              _Pre_FC_update_ivll_ops = true;
            } else {
              _Pre_FC_update_ivll_ops = false;
            }
            if ((responseData['data']['form_data']['pre_flight_checklist']
                    ['5_UPDATED_IVLL_crew']) ==
                1) {
              _Pre_FC_update_ivll_crew = true;
            } else {
              _Pre_FC_update_ivll_crew = false;
            }
            if ((responseData['data']['form_data']['pre_flight_checklist']
                    ['6_UPDATED_FIELD_MAPS_ops']) ==
                1) {
              _Pre_FC_updated_field_maps_ops = true;
            } else {
              _Pre_FC_updated_field_maps_ops = false;
            }
            if ((responseData['data']['form_data']['pre_flight_checklist']
                    ['6_UPDATED_FIELD_MAPS_crew']) ==
                1) {
              _Pre_FC_updated_field_maps_crew = true;
            } else {
              _Pre_FC_updated_field_maps_crew = false;
            }
            if ((responseData['data']['form_data']['pre_flight_checklist']
                    ['7_AIRCRAFT_SEARCH_CHECKLIST_ops']) ==
                1) {
              _Pre_FC_aircraft_search_checklist_ops = true;
            } else {
              _Pre_FC_aircraft_search_checklist_ops = false;
            }
            if ((responseData['data']['form_data']['pre_flight_checklist']
                    ['7_AIRCRAFT_SEARCH_CHECKLIST_crew']) ==
                1) {
              _Pre_FC_aircraft_search_checklist_crew = true;
            } else {
              _Pre_FC_aircraft_search_checklist_crew = false;
            }
            if ((responseData['data']['form_data']['pre_flight_checklist']
                    ['8_NOTOC_ops']) ==
                1) {
              _Pre_FC_notoc_ops = true;
            } else {
              _Pre_FC_notoc_ops = false;
            }
            if ((responseData['data']['form_data']['pre_flight_checklist']
                    ['8_NOTOC_crew']) ==
                1) {
              _Pre_FC_notoc_crew = true;
            } else {
              _Pre_FC_notoc_crew = false;
            }
            if ((responseData['data']['form_data']['pre_flight_checklist']
                    ['9_LICENSE_MEDICAL_EXPIRY_crew']) ==
                1) {
              _Pre_FC_license_medical_expiry_crew = true;
            } else {
              _Pre_FC_license_medical_expiry_crew = false;
            }
            if ((responseData['data']['form_data']['pre_flight_checklist']
                    ['10_CREW_LOUNGE_DOCS_NTAS_crew']) ==
                1) {
              _Pre_FC_crew_lounge_docs_ntas_crew = true;
            } else {
              _Pre_FC_crew_lounge_docs_ntas_crew = false;
            }
            if ((responseData['data']['form_data']['pre_flight_checklist']
                    ['11_PAX_MANIFEST_crew']) ==
                1) {
              _Pre_FC_pax_manifest_crew = true;
            } else {
              _Pre_FC_pax_manifest_crew = false;
            }

            if ((responseData['data']['form_data']['post_flight_checklist']
                    ['1_LEON_UPDATE_ops']) ==
                1) {
              _Post_FC_leon_update_ops = true;
            } else {
              _Post_FC_leon_update_ops = false;
            }
            if ((responseData['data']['form_data']['post_flight_checklist']
                    ['2_CFR_AND_W_B_SHEET_ops']) ==
                1) {
              _Post_FC_cfr_and_w_b_sheet_ops = true;
            } else {
              _Post_FC_cfr_and_w_b_sheet_ops = false;
            }
            if ((responseData['data']['form_data']['post_flight_checklist']
                    ['2_CFR_AND_W_B_SHEET_crew']) ==
                1) {
              _Post_FC_cfr_and_w_b_sheet_crew = true;
            } else {
              _Post_FC_cfr_and_w_b_sheet_crew = false;
            }
            if ((responseData['data']['form_data']['post_flight_checklist']
                    ['3_JOURNEY_LOG_ops']) ==
                1) {
              _Post_FC_journy_log_ops = true;
            } else {
              _Post_FC_journy_log_ops = false;
            }
            if ((responseData['data']['form_data']['post_flight_checklist']
                    ['3_JOURNEY_LOG_crew']) ==
                1) {
              _Post_FC_journy_log_crew = true;
            } else {
              _Post_FC_journy_log_crew = false;
            }
            if ((responseData['data']['form_data']['post_flight_checklist']
                    ['4_FLIGHT_PLAN_ops']) ==
                1) {
              _Post_FC_flight_plan_ops = true;
            } else {
              _Post_FC_flight_plan_ops = false;
            }
            if ((responseData['data']['form_data']['post_flight_checklist']
                    ['4_FLIGHT_PLAN_crew']) ==
                1) {
              _Post_FC_flight_plan_crew = true;
            } else {
              _Post_FC_flight_plan_crew = false;
            }
            if ((responseData['data']['form_data']['post_flight_checklist']
                    ['5_NOTAMS_WX_BRIEF_ops']) ==
                1) {
              _Post_FC_notams_wx_brief_ops = true;
            } else {
              _Post_FC_notams_wx_brief_ops = false;
            }
            if ((responseData['data']['form_data']['post_flight_checklist']
                    ['5_NOTAMS_WX_BRIEF_crew']) ==
                1) {
              _Post_FC_notams_wx_brief_crew = true;
            } else {
              _Post_FC_notams_wx_brief_crew = false;
            }
            if ((responseData['data']['form_data']['post_flight_checklist']
                    ['6_FUEL_BILLS_ops']) ==
                1) {
              _Post_FC_fuel_bills_ops = true;
            } else {
              _Post_FC_fuel_bills_ops = false;
            }
            if ((responseData['data']['form_data']['post_flight_checklist']
                    ['6_FUEL_BILLS_crew']) ==
                1) {
              _Post_FC_fuel_bills_crew = true;
            } else {
              _Post_FC_fuel_bills_crew = false;
            }
            if ((responseData['data']['form_data']['post_flight_checklist']
                    ['7_REPORTING_FORM_IF_ANY_ops']) ==
                1) {
              _Post_FC_reporting_forms_ops = true;
            } else {
              _Post_FC_reporting_forms_ops = false;
            }
            if ((responseData['data']['form_data']['post_flight_checklist']
                    ['7_REPORTING_FORM_IF_ANY_crew']) ==
                1) {
              _Post_FC_reporting_forms_crew = true;
            } else {
              _Post_FC_reporting_forms_crew = false;
            }
            if ((responseData['data']['form_data']['post_flight_checklist']
                    ['8_NOTOC_ops']) ==
                1) {
              _Post_FC_notoc_ops = true;
            } else {
              _Post_FC_notoc_ops = false;
            }
            if ((responseData['data']['form_data']['post_flight_checklist']
                    ['8_NOTOC_crew']) ==
                1) {
              _Post_FC_notoc_crew = true;
            } else {
              _Post_FC_notoc_crew = false;
            }
            if ((responseData['data']['form_data']['post_flight_checklist']
                    ['9_AIRCRAFT_SEARCH_CHECKLIST_ops']) ==
                1) {
              _Post_FC_aircraft_search_checklist_ops = true;
            } else {
              _Post_FC_aircraft_search_checklist_ops = false;
            }
            if ((responseData['data']['form_data']['post_flight_checklist']
                    ['9_AIRCRAFT_SEARCH_CHECKLIST_crew']) ==
                1) {
              _Post_FC_aircraft_search_checklist_crew = true;
            } else {
              _Post_FC_aircraft_search_checklist_crew = false;
            }
            if ((responseData['data']['form_data']['post_flight_checklist']
                    ['10_TECH_LOG_ops']) ==
                1) {
              _Post_FC_tech_log_ops = true;
            } else {
              _Post_FC_tech_log_ops = false;
            }
            if ((responseData['data']['form_data']['post_flight_checklist']
                    ['10_TECH_LOG_crew']) ==
                1) {
              _Post_FC_tech_log_crew = true;
            } else {
              _Post_FC_tech_log_crew = false;
            }
            if ((responseData['data']['form_data']['post_flight_checklist']
                    ['11_PAX_MANIFEST_ops']) ==
                1) {
              _Post_FC_pax_manifest_ops = true;
            } else {
              _Post_FC_pax_manifest_ops = false;
            }

            if ((responseData['data']['form_data']['post_flight_checklist']
                    ['11_PAX_MANIFEST_crew']) ==
                1) {
              _Post_FC_pax_manifest_crew = true;
            } else {
              _Post_FC_pax_manifest_crew = false;
            }

            if ((responseData['data']['form_data']['crew_briefing']
                    ['CREW_BRIEFING_1']) ==
                1) {
              _crew_briefing_1 = true;
            } else {
              _crew_briefing_1 = false;
            }

            if ((responseData['data']['form_data']['crew_briefing']
                    ['CREW_BRIEFING_2']) ==
                1) {
              _crew_briefing_2 = true;
            } else {
              _crew_briefing_2 = false;
            }
            if ((responseData['data']['form_data']['crew_briefing']
                    ['CREW_BRIEFING_3']) ==
                1) {
              _crew_briefing_3 = true;
            } else {
              _crew_briefing_3 = false;
            }
            if ((responseData['data']['form_data']['crew_briefing']
                    ['CREW_BRIEFING_4']) ==
                1) {
              _crew_briefing_4 = true;
            } else {
              _crew_briefing_4 = false;
            }
            if ((responseData['data']['form_data']['crew_briefing']
                    ['CREW_BRIEFING_5']) ==
                1) {
              _crew_briefing_5 = true;
            } else {
              _crew_briefing_5 = false;
            }

            if ((responseData['data']['form_data']['crew_briefing']
                    ['CREW_BRIEFING_6']) ==
                1) {
              _crew_briefing_6 = true;
            } else {
              _crew_briefing_6 = false;
            }
            if ((responseData['data']['form_data']['crew_briefing']
                    ['CREW_BRIEFING_7']) ==
                1) {
              _crew_briefing_7 = true;
            } else {
              _crew_briefing_7 = false;
            }
            if ((responseData['data']['form_data']['crew_briefing']
                    ['CREW_BRIEFING_8']) ==
                1) {
              _crew_briefing_8 = true;
            } else {
              _crew_briefing_8 = false;
            }
            if ((responseData['data']['form_data']['crew_briefing']
                    ['CREW_BRIEFING_9']) ==
                1) {
              _crew_briefing_9 = true;
            } else {
              _crew_briefing_9 = false;
            }
            if ((responseData['data']['form_data']['crew_briefing']
                    ['CREW_BRIEFING_10']) ==
                1) {
              _crew_briefing_10 = true;
            } else {
              _crew_briefing_10 = false;
            }

            _Remarks.text = responseData['data']['form_data']['remarks'] ?? '';
          });
        }
        ;
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
                                        "ROTARY WING FLIGHT PLAN ENVELOPE"
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

                            Column(
                              children: [
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
                                                  const EdgeInsets.all(10.0),
                                              child: Text(
                                                'DATE',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: Container(
                                                constraints:
                                                    const BoxConstraints(
                                                  minHeight: 10.0,
                                                  maxHeight: 100.0,
                                                ),
                                                child: SingleChildScrollView(
                                                  child: TextField(
                                                    autocorrect: false,
                                                    enableSuggestions: false,
                                                    style: const TextStyle(
                                                        fontSize: 16.0,
                                                        color:
                                                            AppColor.textColor),
                                                    scrollPhysics:
                                                        const NeverScrollableScrollPhysics(),
                                                    readOnly: true,
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .characters,
                                                    controller:
                                                        TextEditingController(
                                                            text: currentDate),
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
                                                'A/C REG.',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: Container(
                                                constraints:
                                                    const BoxConstraints(
                                                  minHeight: 10.0,
                                                  maxHeight: 100.0,
                                                ),
                                                child: SingleChildScrollView(
                                                  child: TextField(
                                                    autocorrect: false,
                                                    enableSuggestions: false,
                                                    style: const TextStyle(
                                                        fontSize: 16.0,
                                                        color:
                                                            AppColor.textColor),
                                                    scrollPhysics:
                                                        const NeverScrollableScrollPhysics(),
                                                    readOnly: true,
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .characters,
                                                    controller:
                                                        TextEditingController(
                                                            text:
                                                                selectedGroupName),
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
                                                'CALL SIGN',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: Container(
                                                constraints:
                                                    const BoxConstraints(
                                                  minHeight: 10.0,
                                                  maxHeight: 100.0,
                                                ),
                                                child: SingleChildScrollView(
                                                  child: TextField(
                                                    autocorrect: false,
                                                    enableSuggestions: false,
                                                    style: const TextStyle(
                                                        fontSize: 16.0,
                                                        color:
                                                            AppColor.textColor),
                                                    scrollPhysics:
                                                        const NeverScrollableScrollPhysics(),
                                                    readOnly: true,
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .characters,
                                                    controller:
                                                        TextEditingController(
                                                            text:
                                                                selectedGroupName),
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
                                      Table(
                                        border: TableBorder(
                                            horizontalInside: BorderSide(
                                                color: Colors.black26),
                                            verticalInside: BorderSide(
                                                color: Colors.black26),
                                            right: BorderSide(
                                                color: Colors.black26),
                                            left: BorderSide(
                                                color: Colors.black26)),
                                        columnWidths: const {
                                          0: FixedColumnWidth(90.0),
                                          1: FixedColumnWidth(200.0),
                                          2: FixedColumnWidth(110.0),
                                          3: FixedColumnWidth(110.0),
                                          4: FixedColumnWidth(120.0),
                                          5: FixedColumnWidth(120.0),
                                        },
                                        children: [
                                          TableRow(children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Text(
                                                'ROUTE',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: Container(
                                                constraints:
                                                    const BoxConstraints(
                                                  minHeight: 10.0,
                                                  maxHeight: 100.0,
                                                ),
                                                child: SingleChildScrollView(
                                                  child: TextField(
                                                    autocorrect: false,
                                                    enableSuggestions: false,
                                                    style: const TextStyle(
                                                        fontSize: 16.0,
                                                        color:
                                                            AppColor.textColor),
                                                    scrollPhysics:
                                                        const NeverScrollableScrollPhysics(),
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .characters,
                                                    controller: _Route,
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
                                                'ETD',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: Container(
                                                constraints:
                                                    const BoxConstraints(
                                                  minHeight: 10.0,
                                                  maxHeight: 100.0,
                                                ),
                                                child: SingleChildScrollView(
                                                  child: TextField(
                                                    autocorrect: false,
                                                    enableSuggestions: false,
                                                    style: const TextStyle(
                                                        fontSize: 16.0,
                                                        color:
                                                            AppColor.textColor),
                                                    scrollPhysics:
                                                        const NeverScrollableScrollPhysics(),
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .characters,
                                                    controller: _ETD,
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
                                                        _ETD.text =
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
                                                'ATD',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: Container(
                                                constraints:
                                                    const BoxConstraints(
                                                  minHeight: 10.0,
                                                  maxHeight: 100.0,
                                                ),
                                                child: SingleChildScrollView(
                                                  child: TextField(
                                                    autocorrect: false,
                                                    enableSuggestions: false,
                                                    style: const TextStyle(
                                                        fontSize: 16.0,
                                                        color:
                                                            AppColor.textColor),
                                                    scrollPhysics:
                                                        const NeverScrollableScrollPhysics(),
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .characters,
                                                    controller: _ATD,
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
                                                        _ATD.text =
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

                                      Table(
                                        border: TableBorder.all(
                                            color: Colors.black26),
                                        columnWidths: const {
                                          0: FixedColumnWidth(120.0),
                                          1: FixedColumnWidth(130.0),
                                          2: FixedColumnWidth(120.0),
                                          3: FixedColumnWidth(130.0),
                                          4: FixedColumnWidth(120.0),
                                          5: FixedColumnWidth(130.0),
                                        },
                                        children: [
                                          TableRow(children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Text(
                                                'CAPT',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: Container(
                                                constraints:
                                                    const BoxConstraints(
                                                  minHeight: 10.0,
                                                  maxHeight: 100.0,
                                                ),
                                                child: SingleChildScrollView(
                                                  child: TextField(
                                                    autocorrect: false,
                                                    enableSuggestions: false,
                                                    style: const TextStyle(
                                                        fontSize: 16.0,
                                                        color:
                                                            AppColor.textColor),
                                                    controller: _Capt,
                                                    scrollPhysics:
                                                        const NeverScrollableScrollPhysics(),
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .characters,
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
                                                'F/O',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: Container(
                                                constraints:
                                                    const BoxConstraints(
                                                  minHeight: 10.0,
                                                  maxHeight: 100.0,
                                                ),
                                                child: SingleChildScrollView(
                                                  child: TextField(
                                                    autocorrect: false,
                                                    enableSuggestions: false,
                                                    style: const TextStyle(
                                                        fontSize: 16.0,
                                                        color:
                                                            AppColor.textColor),
                                                    scrollPhysics:
                                                        const NeverScrollableScrollPhysics(),
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .characters,
                                                    controller: _F_O,
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
                                                'CLIENT',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: Container(
                                                constraints:
                                                    const BoxConstraints(
                                                  minHeight: 10.0,
                                                  maxHeight: 100.0,
                                                ),
                                                child: SingleChildScrollView(
                                                  child: TextField(
                                                    autocorrect: false,
                                                    enableSuggestions: false,
                                                    style: const TextStyle(
                                                        fontSize: 16.0,
                                                        color:
                                                            AppColor.textColor),
                                                    controller: _Client,
                                                    scrollPhysics:
                                                        const NeverScrollableScrollPhysics(),
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .characters,
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

                                      const SizedBox(height: 10),

                                      // Table(
                                      //   border: const TableBorder(
                                      //     top: BorderSide(color: Colors.black26),
                                      //     left: BorderSide(color: Colors.black26),
                                      //     right: BorderSide(color: Colors.black26),
                                      //     horizontalInside:
                                      //     BorderSide(color: Colors.black26),
                                      //     verticalInside:
                                      //     BorderSide(color: Colors.black26),
                                      //   ),
                                      //   columnWidths: const {
                                      //     0: FixedColumnWidth(150.0),
                                      //     1: FixedColumnWidth(200.0),
                                      //     2: FixedColumnWidth(200.0),
                                      //     3: FixedColumnWidth(200.0),
                                      //   },
                                      //   children: [
                                      //     TableRow(children: [
                                      //       Padding(
                                      //           padding: EdgeInsets.all(10.0),
                                      //           child: Container()),
                                      //       Padding(
                                      //         padding: EdgeInsets.all(10.0),
                                      //         child: Text(
                                      //           'DEPARTURE TIME (LT) '.toUpperCase(),
                                      //           textAlign: TextAlign.center,
                                      //           style: TextStyle(
                                      //             fontFamily: AppFont.OutfitFont,
                                      //             color: Colors.black,
                                      //             fontSize: 14,
                                      //             fontWeight: FontWeight.w600,
                                      //           ),
                                      //         ),
                                      //       ),
                                      //       Padding(
                                      //         padding: EdgeInsets.all(10.0),
                                      //         child: Text(
                                      //           'CRUISING '.toUpperCase(),
                                      //           textAlign: TextAlign.center,
                                      //           style: TextStyle(
                                      //             fontFamily: AppFont.OutfitFont,
                                      //             color: Colors.black,
                                      //             fontSize: 14,
                                      //             fontWeight: FontWeight.w600,
                                      //           ),
                                      //         ),
                                      //       ),
                                      //       Padding(
                                      //         padding: EdgeInsets.all(10.0),
                                      //         child: Text(
                                      //           'FUEL ON BOARD'.toUpperCase(),
                                      //           textAlign: TextAlign.center,
                                      //           style: TextStyle(
                                      //             fontFamily: AppFont.OutfitFont,
                                      //             color: Colors.black,
                                      //             fontSize: 14,
                                      //             fontWeight: FontWeight.w600,
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     ]),
                                      //   ],
                                      // ),
                                      //

                                      Table(
                                        border: const TableBorder(
                                          top:
                                              BorderSide(color: Colors.black26),
                                          left:
                                              BorderSide(color: Colors.black26),
                                          right:
                                              BorderSide(color: Colors.black26),
                                          horizontalInside:
                                              BorderSide(color: Colors.black26),
                                          verticalInside:
                                              BorderSide(color: Colors.black26),
                                        ),
                                        columnWidths: const {
                                          0: FixedColumnWidth(375.0),
                                          1: FixedColumnWidth(375.0),
                                        },
                                        children: [
                                          TableRow(children: [
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                'PRE-FLIGHT CHECKLIST'
                                                    .toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                'POST-FLIGHT CHECKLIST '
                                                    .toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
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
                                          0: FixedColumnWidth(50.0),
                                          1: FixedColumnWidth(185.0),
                                          2: FixedColumnWidth(70.0),
                                          3: FixedColumnWidth(70.0),
                                          4: FixedColumnWidth(50.0),
                                          5: FixedColumnWidth(185.0),
                                          6: FixedColumnWidth(70.0),
                                          7: FixedColumnWidth(70.0),
                                        },
                                        children: [
                                          TableRow(children: [
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                ''.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                ' '.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                'OPS'.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                'CREW'.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                ' '.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                ' '.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                'OPS'.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                'CREW'.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                '1'.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                'FLIGHT PLANS  '.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Checkbox(
                                                value: _Pre_FC_flight_plan_ops,
                                                activeColor:
                                                    AppColor.primaryColor,
                                                checkColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _Pre_FC_flight_plan_ops =
                                                        value ?? false;
                                                  });
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Checkbox(
                                                value: _Pre_FC_flight_plan_crew,
                                                activeColor:
                                                    AppColor.primaryColor,
                                                checkColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _Pre_FC_flight_plan_crew =
                                                        value ?? false;
                                                  });
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                '1'.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                'LEON UPDATE'.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Checkbox(
                                                value: _Post_FC_leon_update_ops,
                                                activeColor:
                                                    AppColor.primaryColor,
                                                checkColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _Post_FC_leon_update_ops =
                                                        value ?? false;
                                                  });
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                              // child: Checkbox(
                                              //   value:
                                              //       _Post_FC_leon_update_crew,
                                              //   activeColor:
                                              //       AppColor.primaryColor,
                                              //   checkColor: Colors.white,
                                              //   shape: RoundedRectangleBorder(
                                              //     side: const BorderSide(
                                              //       color: Colors.grey,
                                              //       width: 1.0,
                                              //     ),
                                              //     borderRadius:
                                              //         BorderRadius.circular(
                                              //             4.0),
                                              //   ),
                                              //   onChanged: (bool? value) {
                                              //     setState(() {
                                              //       _Post_FC_leon_update_crew =
                                              //           value ?? false;
                                              //     });
                                              //   },
                                              // ),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                '2'.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                'WEATHER/NOTAMS  '
                                                    .toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Checkbox(
                                                value:
                                                    _Pre_FC_weather_notams_ops,
                                                activeColor:
                                                    AppColor.primaryColor,
                                                checkColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _Pre_FC_weather_notams_ops =
                                                        value ?? false;
                                                  });
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Checkbox(
                                                value:
                                                    _Pre_FC_weather_notams_crew,
                                                activeColor:
                                                    AppColor.primaryColor,
                                                checkColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _Pre_FC_weather_notams_crew =
                                                        value ?? false;
                                                  });
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                '2'.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                'CFR AND W_B SHEET'
                                                    .toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Checkbox(
                                                value:
                                                    _Post_FC_cfr_and_w_b_sheet_ops,
                                                activeColor:
                                                    AppColor.primaryColor,
                                                checkColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _Post_FC_cfr_and_w_b_sheet_ops =
                                                        value ?? false;
                                                  });
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Checkbox(
                                                value:
                                                    _Post_FC_cfr_and_w_b_sheet_crew,
                                                activeColor:
                                                    AppColor.primaryColor,
                                                checkColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _Post_FC_cfr_and_w_b_sheet_crew =
                                                        value ?? false;
                                                  });
                                                },
                                              ),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                '3'.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                'JOURNEY LOG'.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Checkbox(
                                                value: _Pre_FC_journy_log_ops,
                                                activeColor:
                                                    AppColor.primaryColor,
                                                checkColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _Pre_FC_journy_log_ops =
                                                        value ?? false;
                                                  });
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Checkbox(
                                                value: _Pre_FC_journy_log_crew,
                                                activeColor:
                                                    AppColor.primaryColor,
                                                checkColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _Pre_FC_journy_log_crew =
                                                        value ?? false;
                                                  });
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                '3'.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                'JOURNEY LOG'.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Checkbox(
                                                value: _Post_FC_journy_log_ops,
                                                activeColor:
                                                    AppColor.primaryColor,
                                                checkColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _Post_FC_journy_log_ops =
                                                        value ?? false;
                                                  });
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Checkbox(
                                                value: _Post_FC_journy_log_crew,
                                                activeColor:
                                                    AppColor.primaryColor,
                                                checkColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _Post_FC_journy_log_crew =
                                                        value ?? false;
                                                  });
                                                },
                                              ),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                '4'.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                'CFR AND W_B SHEET '
                                                    .toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Checkbox(
                                                value:
                                                    _Pre_FC_cfr_and_w_b_sheet_ops,
                                                activeColor:
                                                    AppColor.primaryColor,
                                                checkColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _Pre_FC_cfr_and_w_b_sheet_ops =
                                                        value ?? false;
                                                  });
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Checkbox(
                                                value:
                                                    _Pre_FC_cfr_and_w_b_sheet_crew,
                                                activeColor:
                                                    AppColor.primaryColor,
                                                checkColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _Pre_FC_cfr_and_w_b_sheet_crew =
                                                        value ?? false;
                                                  });
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                '4'.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                'FLIGHT PLAN'.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Checkbox(
                                                value: _Post_FC_flight_plan_ops,
                                                activeColor:
                                                    AppColor.primaryColor,
                                                checkColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _Post_FC_flight_plan_ops =
                                                        value ?? false;
                                                  });
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Checkbox(
                                                value:
                                                    _Post_FC_flight_plan_crew,
                                                activeColor:
                                                    AppColor.primaryColor,
                                                checkColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _Post_FC_flight_plan_crew =
                                                        value ?? false;
                                                  });
                                                },
                                              ),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                '5'.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                'UPDATED IVLL'.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Checkbox(
                                                value: _Pre_FC_update_ivll_ops,
                                                activeColor:
                                                    AppColor.primaryColor,
                                                checkColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _Pre_FC_update_ivll_ops =
                                                        value ?? false;
                                                  });
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Checkbox(
                                                value: _Pre_FC_update_ivll_crew,
                                                activeColor:
                                                    AppColor.primaryColor,
                                                checkColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _Pre_FC_update_ivll_crew =
                                                        value ?? false;
                                                  });
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                '5'.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                'NOTAMS & WX BRIEF'
                                                    .toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Checkbox(
                                                value:
                                                    _Post_FC_notams_wx_brief_ops,
                                                activeColor:
                                                    AppColor.primaryColor,
                                                checkColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _Post_FC_notams_wx_brief_ops =
                                                        value ?? false;
                                                  });
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Checkbox(
                                                value:
                                                    _Post_FC_notams_wx_brief_crew,
                                                activeColor:
                                                    AppColor.primaryColor,
                                                checkColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _Post_FC_notams_wx_brief_crew =
                                                        value ?? false;
                                                  });
                                                },
                                              ),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                '6'.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                'UPDATED FIELD MAPS '
                                                    .toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Checkbox(
                                                value:
                                                    _Pre_FC_updated_field_maps_ops,
                                                activeColor:
                                                    AppColor.primaryColor,
                                                checkColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _Pre_FC_updated_field_maps_ops =
                                                        value ?? false;
                                                  });
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Checkbox(
                                                value:
                                                    _Pre_FC_updated_field_maps_crew,
                                                activeColor:
                                                    AppColor.primaryColor,
                                                checkColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _Pre_FC_updated_field_maps_crew =
                                                        value ?? false;
                                                  });
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                '6'.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                'FUEL BILLS'.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Checkbox(
                                                value: _Post_FC_fuel_bills_ops,
                                                activeColor:
                                                    AppColor.primaryColor,
                                                checkColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _Post_FC_fuel_bills_ops =
                                                        value ?? false;
                                                  });
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Checkbox(
                                                value: _Post_FC_fuel_bills_crew,
                                                activeColor:
                                                    AppColor.primaryColor,
                                                checkColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _Post_FC_fuel_bills_crew =
                                                        value ?? false;
                                                  });
                                                },
                                              ),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                '7'.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                'AIRCRAFT SEARCH CHECKLIST'
                                                    .toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Checkbox(
                                                value:
                                                    _Pre_FC_aircraft_search_checklist_ops,
                                                activeColor:
                                                    AppColor.primaryColor,
                                                checkColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _Pre_FC_aircraft_search_checklist_ops =
                                                        value ?? false;
                                                  });
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Checkbox(
                                                value:
                                                    _Pre_FC_aircraft_search_checklist_crew,
                                                activeColor:
                                                    AppColor.primaryColor,
                                                checkColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _Pre_FC_aircraft_search_checklist_crew =
                                                        value ?? false;
                                                  });
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                '7'.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                'REPORTING FORM (IF ANY)'
                                                    .toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Checkbox(
                                                value:
                                                    _Post_FC_reporting_forms_ops,
                                                activeColor:
                                                    AppColor.primaryColor,
                                                checkColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _Post_FC_reporting_forms_ops =
                                                        value ?? false;
                                                  });
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Checkbox(
                                                value:
                                                    _Post_FC_reporting_forms_crew,
                                                activeColor:
                                                    AppColor.primaryColor,
                                                checkColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _Post_FC_reporting_forms_crew =
                                                        value ?? false;
                                                  });
                                                },
                                              ),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                '8'.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                'NOTOC'.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Checkbox(
                                                value: _Pre_FC_notoc_ops,
                                                activeColor:
                                                    AppColor.primaryColor,
                                                checkColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _Pre_FC_notoc_ops =
                                                        value ?? false;
                                                  });
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Checkbox(
                                                value: _Pre_FC_notoc_crew,
                                                activeColor:
                                                    AppColor.primaryColor,
                                                checkColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _Pre_FC_notoc_crew =
                                                        value ?? false;
                                                  });
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                '8'.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                'NOTOC'.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Checkbox(
                                                value: _Post_FC_notoc_ops,
                                                activeColor:
                                                    AppColor.primaryColor,
                                                checkColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _Post_FC_notoc_ops =
                                                        value ?? false;
                                                  });
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Checkbox(
                                                value: _Post_FC_notoc_crew,
                                                activeColor:
                                                    AppColor.primaryColor,
                                                checkColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _Post_FC_notoc_crew =
                                                        value ?? false;
                                                  });
                                                },
                                              ),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                '9'.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                'LICENSE & MEDICAL EXPIRY'
                                                    .toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Checkbox(
                                                value:
                                                    _Pre_FC_license_medical_expiry_crew,
                                                activeColor:
                                                    AppColor.primaryColor,
                                                checkColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _Pre_FC_license_medical_expiry_crew =
                                                        value ?? false;
                                                  });
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                '9'.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                'AIRCRAFT SEARCH CHECKLIST'
                                                    .toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Checkbox(
                                                value:
                                                    _Post_FC_aircraft_search_checklist_ops,
                                                activeColor:
                                                    AppColor.primaryColor,
                                                checkColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _Post_FC_aircraft_search_checklist_ops =
                                                        value ?? false;
                                                  });
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Checkbox(
                                                value:
                                                    _Post_FC_aircraft_search_checklist_crew,
                                                activeColor:
                                                    AppColor.primaryColor,
                                                checkColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _Post_FC_aircraft_search_checklist_crew =
                                                        value ?? false;
                                                  });
                                                },
                                              ),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                '10'.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                'CREW LOUNGE DOCS/NTAS'
                                                    .toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Checkbox(
                                                value:
                                                    _Pre_FC_crew_lounge_docs_ntas_crew,
                                                activeColor:
                                                    AppColor.primaryColor,
                                                checkColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _Pre_FC_crew_lounge_docs_ntas_crew =
                                                        value ?? false;
                                                  });
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                '10'.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                'TECH LOG'.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Checkbox(
                                                value: _Post_FC_tech_log_ops,
                                                activeColor:
                                                    AppColor.primaryColor,
                                                checkColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _Post_FC_tech_log_ops =
                                                        value ?? false;
                                                  });
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Checkbox(
                                                value: _Post_FC_tech_log_crew,
                                                activeColor:
                                                    AppColor.primaryColor,
                                                checkColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _Post_FC_tech_log_crew =
                                                        value ?? false;
                                                  });
                                                },
                                              ),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                '11'.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                'PAX MANIFEST'.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Checkbox(
                                                value:
                                                    _Pre_FC_pax_manifest_crew,
                                                activeColor:
                                                    AppColor.primaryColor,
                                                checkColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _Pre_FC_pax_manifest_crew =
                                                        value ?? false;
                                                  });
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                '11'.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                'PAX MANIFEST'.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Checkbox(
                                                value:
                                                    _Post_FC_pax_manifest_ops,
                                                activeColor:
                                                    AppColor.primaryColor,
                                                checkColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _Post_FC_pax_manifest_ops =
                                                        value ?? false;
                                                  });
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Checkbox(
                                                value:
                                                    _Post_FC_pax_manifest_crew,
                                                activeColor:
                                                    AppColor.primaryColor,
                                                checkColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _Post_FC_pax_manifest_crew =
                                                        value ?? false;
                                                  });
                                                },
                                              ),
                                            ),
                                          ]),
                                        ],
                                      ),

                                      SizedBox(height: 30),
                                      Row(
                                        children: [
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '* * CREW BRIEFING MUST BE PERFORMED AS PART OF THE PREFLIGHT DUTIES. IT IS THE ',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily:
                                                        AppFont.OutfitFont,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                                Text(
                                                  'RESPONSIBILITY OF THE DESIGNATED P1 (PILOT IN COMMAND) TO INFORM THE DESIGNATED P2  ',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily:
                                                        AppFont.OutfitFont,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                                Text(
                                                  '(FIRST OFFICER) OF THE DUTIES RELATED TO THE MISSION. THIS WILL INCLUDE BUT IS NOT LIMITED TO :',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily:
                                                        AppFont.OutfitFont,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: 30),

                                      Table(
                                        border: TableBorder(
                                            horizontalInside: BorderSide(
                                                color: Colors.black26),
                                            verticalInside: BorderSide(
                                                color: Colors.black26),
                                            right: BorderSide(
                                                color: Colors.black26),
                                            top: BorderSide(
                                                color: Colors.black26),
                                            left: BorderSide(
                                                color: Colors.black26)),
                                        columnWidths: const {
                                          0: FixedColumnWidth(680.0),
                                          1: FixedColumnWidth(70.0),
                                        },
                                        children: [
                                          TableRow(children: [
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                ''.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                'CREW'.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
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
                                          0: FixedColumnWidth(50.0),
                                          1: FixedColumnWidth(630.0),
                                          2: FixedColumnWidth(70.0),
                                        },
                                        children: [
                                          TableRow(children: [
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                '1.'.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                'P1 DUTIES AND P2 DUTIES DURING THE MISSION'
                                                    .toUpperCase(),
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Checkbox(
                                                value: _crew_briefing_1,
                                                activeColor:
                                                    AppColor.primaryColor,
                                                checkColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _crew_briefing_1 =
                                                        value ?? false;
                                                  });
                                                },
                                              ),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                '2.'.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                'USE OF CHECKLIST'
                                                    .toUpperCase(),
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Checkbox(
                                                value: _crew_briefing_2,
                                                activeColor:
                                                    AppColor.primaryColor,
                                                checkColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _crew_briefing_2 =
                                                        value ?? false;
                                                  });
                                                },
                                              ),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                '3.'.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                'OPERATION OFFSHORE AND ABBREVIATED BRIEFINGS FOR FIELD OPERATION T/O AND LDGS.'
                                                    .toUpperCase(),
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Checkbox(
                                                value: _crew_briefing_3,
                                                activeColor:
                                                    AppColor.primaryColor,
                                                checkColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _crew_briefing_3 =
                                                        value ?? false;
                                                  });
                                                },
                                              ),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                '4.'.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                'POSITIVE IDENTIFICATION OF RIGS AND LANDINGS ZONES (BOTH PILOT/VERBALIZED)'
                                                    .toUpperCase(),
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Checkbox(
                                                value: _crew_briefing_4,
                                                activeColor:
                                                    AppColor.primaryColor,
                                                checkColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _crew_briefing_4 =
                                                        value ?? false;
                                                  });
                                                },
                                              ),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                '5.'.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                'THUMB UP RULES AND DECK MANAGEMENT '
                                                    .toUpperCase(),
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Checkbox(
                                                value: _crew_briefing_5,
                                                activeColor:
                                                    AppColor.primaryColor,
                                                checkColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _crew_briefing_5 =
                                                        value ?? false;
                                                  });
                                                },
                                              ),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                '6.'.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                'CALL GO-AROUND RULE (* anybody can call go-around and should be executed without hesitation)',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Checkbox(
                                                value: _crew_briefing_6,
                                                activeColor:
                                                    AppColor.primaryColor,
                                                checkColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _crew_briefing_6 =
                                                        value ?? false;
                                                  });
                                                },
                                              ),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                '7.'.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                'OPERATION OF SWITCHES IN FLIGHT'
                                                    .toUpperCase(),
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Checkbox(
                                                value: _crew_briefing_7,
                                                activeColor:
                                                    AppColor.primaryColor,
                                                checkColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _crew_briefing_7 =
                                                        value ?? false;
                                                  });
                                                },
                                              ),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                '8.'.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                'STERILE COCKPIT RULES FOR TAKE OF AND LDGS. AND/OR ANYTIME BELOW 300’ AMSL'
                                                    .toUpperCase(),
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Checkbox(
                                                value: _crew_briefing_8,
                                                activeColor:
                                                    AppColor.primaryColor,
                                                checkColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _crew_briefing_8 =
                                                        value ?? false;
                                                  });
                                                },
                                              ),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                '9.'.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                'IVLL AND MAPS USE'
                                                    .toUpperCase(),
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Checkbox(
                                                value: _crew_briefing_9,
                                                activeColor:
                                                    AppColor.primaryColor,
                                                checkColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _crew_briefing_9 =
                                                        value ?? false;
                                                  });
                                                },
                                              ),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                '10.'.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                'WEATHER BRIEFING AND VFR/IFR CLEARANCE/OPERATION '
                                                    .toUpperCase(),
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Checkbox(
                                                value: _crew_briefing_10,
                                                activeColor:
                                                    AppColor.primaryColor,
                                                checkColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _crew_briefing_10 =
                                                        value ?? false;
                                                  });
                                                },
                                              ),
                                            ),
                                          ]),
                                        ],
                                      ),

                                      SizedBox(height: 20),
                                      Table(
                                        border: TableBorder.all(
                                            color: Colors.black26),
                                        columnWidths: const {
                                          0: FixedColumnWidth(150.0),
                                          1: FixedColumnWidth(225.0),
                                          2: FixedColumnWidth(150.0),
                                          3: FixedColumnWidth(225.0),
                                        },
                                        children: [
                                          TableRow(children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Text(
                                                'Prepared by :',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: Container(
                                                constraints:
                                                    const BoxConstraints(
                                                  minHeight: 10.0,
                                                  maxHeight: 100.0,
                                                ),
                                                child: SingleChildScrollView(
                                                  child: TextField(
                                                    autocorrect: false,
                                                    enableSuggestions: false,
                                                    controller:
                                                        TextEditingController(
                                                            text: "OCC"),
                                                    readOnly: true,
                                                    style: const TextStyle(
                                                        fontSize: 16.0,
                                                        color:
                                                            AppColor.textColor),
                                                    scrollPhysics:
                                                        const NeverScrollableScrollPhysics(),
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .characters,
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
                                                'Received by:',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: Container(
                                                constraints:
                                                    const BoxConstraints(
                                                  minHeight: 10.0,
                                                  maxHeight: 100.0,
                                                ),
                                                child: SingleChildScrollView(
                                                  child: TextField(
                                                    autocorrect: false,
                                                    enableSuggestions: false,
                                                    controller:
                                                        TextEditingController(
                                                            text: "OCC"),
                                                    readOnly: true,
                                                    style: const TextStyle(
                                                        fontSize: 16.0,
                                                        color:
                                                            AppColor.textColor),
                                                    scrollPhysics:
                                                        const NeverScrollableScrollPhysics(),
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .characters,
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
                                      Table(
                                        border: const TableBorder(
                                          bottom:
                                              BorderSide(color: Colors.black26),
                                          left:
                                              BorderSide(color: Colors.black26),
                                          right:
                                              BorderSide(color: Colors.black26),
                                          horizontalInside:
                                              BorderSide(color: Colors.black26),
                                          verticalInside:
                                              BorderSide(color: Colors.black26),
                                        ),
                                        columnWidths: const {
                                          0: FixedColumnWidth(200.0),
                                          1: FixedColumnWidth(550.0),
                                        },
                                        children: [
                                          TableRow(children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Text(
                                                'Received by Captain:',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: Container(
                                                constraints:
                                                    const BoxConstraints(
                                                  minHeight: 10.0,
                                                  maxHeight: 100.0,
                                                ),
                                                child: SingleChildScrollView(
                                                  child: Checkbox(
                                                    value: _userSign,
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
                                                        _userSign =
                                                            value ?? false;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ]),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Table(
                                        border: TableBorder.all(
                                            color: Colors.black26),
                                        columnWidths: const {
                                          0: FixedColumnWidth(200.0),
                                          1: FixedColumnWidth(555.0),
                                        },
                                        children: [
                                          TableRow(children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Text(
                                                'REMARKS:',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppFont.OutfitFont,
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: Container(
                                                constraints:
                                                    const BoxConstraints(
                                                  minHeight: 10.0,
                                                  maxHeight: 100.0,
                                                ),
                                                child: SingleChildScrollView(
                                                  child: TextField(
                                                    autocorrect: false,
                                                    enableSuggestions: false,
                                                    style: const TextStyle(
                                                        fontSize: 16.0,
                                                        color:
                                                            AppColor.textColor),
                                                    controller: _Remarks,
                                                    scrollPhysics:
                                                        const NeverScrollableScrollPhysics(),
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .characters,
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



                                      SizedBox(height: 10),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "OCC-FOR-07",
                                            style: TextStyle(
                                              fontFamily: AppFont.OutfitFont,
                                              color: Colors.black,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            "Rev.6",
                                            style: TextStyle(
                                              fontFamily: AppFont.OutfitFont,
                                              color: Colors.black,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            "04 JUL 2024",
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
                                              width: MediaQuery.of(context)
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
                                                          color:
                                                              Color(0xFFAA182C),
                                                          width:
                                                              1)), // Red outline
                                                  padding:
                                                      MaterialStateProperty.all(
                                                          const EdgeInsets.all(
                                                              13.0)),
                                                  shape:
                                                      MaterialStateProperty.all(
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                ),
                                                child: Text(
                                                  'Back',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        AppFont.OutfitFont,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.7,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  10), // Rounded corners
                                                          side: BorderSide(
                                                              color: Color(
                                                                  0xFFAA182C),
                                                              width:
                                                                  2), // Red border
                                                        ),
                                                        backgroundColor: Colors
                                                            .white, // White background
                                                        title: Text(
                                                          'Choose an action:',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        24,
                                                                    vertical:
                                                                        16),
                                                        actions: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              TextButton(
                                                                onPressed: () {
                                                                  saveformdata(
                                                                      "partialy");
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                style: TextButton
                                                                    .styleFrom(
                                                                  side: BorderSide(
                                                                      color: Color(
                                                                          0xFFAA182C),
                                                                      width:
                                                                          1), // Green border
                                                                  foregroundColor:
                                                                      Colors
                                                                          .black, // Green text
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              12,
                                                                          vertical:
                                                                              8),
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10), // Rounded corners
                                                                  ),
                                                                ),
                                                                child: Text(
                                                                    'Save Form Data'),
                                                              ),
                                                              SizedBox(
                                                                  width:
                                                                      14), // Space between buttons
                                                              TextButton(
                                                                onPressed: () {
                                                                  if (!_userSign) {
                                                                    EasyLoading
                                                                        .showInfo(
                                                                            'Please Sign in to continue');
                                                                  } else {
                                                                    saveformdata(
                                                                        "completed");
                                                                  }
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                style: TextButton
                                                                    .styleFrom(
                                                                  side: BorderSide(
                                                                      color: Color(
                                                                          0xFFAA182C),
                                                                      width:
                                                                          1), // Green border
                                                                  foregroundColor:
                                                                      Colors
                                                                          .black, // Green text
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              12,
                                                                          vertical:
                                                                              8),
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10), // Rounded corners
                                                                  ),
                                                                ),
                                                                child: Text(
                                                                    'Upload Complete Data'),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                                style: ButtonStyle(
                                                  foregroundColor:
                                                      WidgetStateProperty
                                                          .resolveWith(
                                                              (states) {
                                                    if (states.contains(
                                                        WidgetState.pressed)) {
                                                      return Colors.white;
                                                    }
                                                    return Colors.white70;
                                                  }),
                                                  backgroundColor:
                                                      WidgetStateProperty
                                                          .resolveWith(
                                                              (states) {
                                                    if (states.contains(
                                                        WidgetState.pressed)) {
                                                      return (Color(
                                                          0xFFE8374F));
                                                    }
                                                    return (Color(0xFFAA182C));
                                                  }),
                                                  padding:
                                                      WidgetStateProperty.all(
                                                          const EdgeInsets.all(
                                                              13.0)),
                                                  shape:
                                                      WidgetStateProperty.all(
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                ),
                                                child: Text(
                                                  'Save',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        AppFont.OutfitFont,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                      const SizedBox(height: 50.0),
                                    ],
                                  ),
                                )
                              ],
                            )
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

  Future<void> saveformdata(String status) async {
    EasyLoading.show(status: 'Saving...');
    var flightRoute = {
      "date": currentDate,
      "aircraft": selectedGroupName,
      "callsign": selectedGroupName,
      "route": _Route.text,
      "etd": _ETD.text,
      "atd": _ATD.text,
      "capt": _Capt.text,
      "f_o": _F_O.text,
      "client": _Client.text
    };

    var pre_flight_checklist = {
      "1_FLIGHT_PLANS_ops": _Pre_FC_flight_plan_ops ? 1 : 0,
      "1_FLIGHT_PLANS_crew": _Pre_FC_flight_plan_crew ? 1 : 0,
      "2_WEATHER_NOTAMS_ops": _Pre_FC_weather_notams_ops ? 1 : 0,
      "2_WEATHER_NOTAMS_crew": _Pre_FC_weather_notams_crew ? 1 : 0,
      "3_JOURNEY_LOG_ops": _Pre_FC_journy_log_ops ? 1 : 0,
      "3_JOURNEY_LOG_crew": _Pre_FC_journy_log_crew ? 1 : 0,
      "4_CFR_AND_W_B_SHEET_ops": _Pre_FC_cfr_and_w_b_sheet_ops ? 1 : 0,
      "4_CFR_AND_W_B_SHEET_crew": _Pre_FC_cfr_and_w_b_sheet_crew ? 1 : 0,
      "5_UPDATED_IVLL_ops": _Pre_FC_update_ivll_ops ? 1 : 0,
      "5_UPDATED_IVLL_crew": _Pre_FC_update_ivll_crew ? 1 : 0,
      "6_UPDATED_FIELD_MAPS_ops": _Pre_FC_updated_field_maps_ops ? 1 : 0,
      "6_UPDATED_FIELD_MAPS_crew": _Pre_FC_updated_field_maps_crew ? 1 : 0,
      "7_AIRCRAFT_SEARCH_CHECKLIST_ops":
          _Pre_FC_aircraft_search_checklist_ops ? 1 : 0,
      "7_AIRCRAFT_SEARCH_CHECKLIST_crew":
          _Pre_FC_aircraft_search_checklist_crew ? 1 : 0,
      "8_NOTOC_ops": _Pre_FC_notoc_ops ? 1 : 0,
      "8_NOTOC_crew": _Pre_FC_notoc_crew ? 1 : 0,
      "9_LICENSE_MEDICAL_EXPIRY_crew":
          _Pre_FC_license_medical_expiry_crew ? 1 : 0,
      "10_CREW_LOUNGE_DOCS_NTAS_crew":
          _Pre_FC_crew_lounge_docs_ntas_crew ? 1 : 0,
      "11_PAX_MANIFEST_crew": _Pre_FC_pax_manifest_crew ? 1 : 0,
    };

    var post_flight_checklist = {
      "1_LEON_UPDATE_ops": _Post_FC_leon_update_ops ? 1 : 0,
      "2_CFR_AND_W_B_SHEET_ops": _Post_FC_cfr_and_w_b_sheet_ops ? 1 : 0,
      "2_CFR_AND_W_B_SHEET_crew": _Post_FC_cfr_and_w_b_sheet_crew ? 1 : 0,
      "3_JOURNEY_LOG_ops": _Post_FC_journy_log_ops ? 1 : 0,
      "3_JOURNEY_LOG_crew": _Post_FC_journy_log_crew ? 1 : 0,
      "4_FLIGHT_PLAN_ops": _Post_FC_flight_plan_ops ? 1 : 0,
      "4_FLIGHT_PLAN_crew": _Post_FC_flight_plan_crew ? 1 : 0,
      "5_NOTAMS_WX_BRIEF_ops": _Post_FC_notams_wx_brief_ops ? 1 : 0,
      "5_NOTAMS_WX_BRIEF_crew": _Post_FC_notams_wx_brief_crew ? 1 : 0,
      "6_FUEL_BILLS_ops": _Post_FC_fuel_bills_ops ? 1 : 0,
      "6_FUEL_BILLS_crew": _Post_FC_fuel_bills_crew ? 1 : 0,
      "7_REPORTING_FORM_IF_ANY_ops": _Post_FC_reporting_forms_ops ? 1 : 0,
      "7_REPORTING_FORM_IF_ANY_crew": _Post_FC_reporting_forms_crew ? 1 : 0,
      "8_NOTOC_ops": _Post_FC_notoc_ops ? 1 : 0,
      "8_NOTOC_crew": _Post_FC_notoc_crew ? 1 : 0,
      "9_AIRCRAFT_SEARCH_CHECKLIST_ops":
          _Post_FC_aircraft_search_checklist_ops ? 1 : 0,
      "9_AIRCRAFT_SEARCH_CHECKLIST_crew":
          _Post_FC_aircraft_search_checklist_crew ? 1 : 0,
      "10_TECH_LOG_ops": _Post_FC_tech_log_ops ? 1 : 0,
      "10_TECH_LOG_crew": _Post_FC_tech_log_crew ? 1 : 0,
      "11_PAX_MANIFEST_ops": _Post_FC_pax_manifest_ops ? 1 : 0,
      "11_PAX_MANIFEST_crew": _Post_FC_pax_manifest_crew ? 1 : 0,
    };

    var crew_briefing = {
      "CREW_BRIEFING_1": _crew_briefing_1 ? 1 : 0,
      "CREW_BRIEFING_2": _crew_briefing_2 ? 1 : 0,
      "CREW_BRIEFING_3": _crew_briefing_3 ? 1 : 0,
      "CREW_BRIEFING_4": _crew_briefing_4 ? 1 : 0,
      "CREW_BRIEFING_5": _crew_briefing_5 ? 1 : 0,
      "CREW_BRIEFING_6": _crew_briefing_6 ? 1 : 0,
      "CREW_BRIEFING_7": _crew_briefing_7 ? 1 : 0,
      "CREW_BRIEFING_8": _crew_briefing_8 ? 1 : 0,
      "CREW_BRIEFING_9": _crew_briefing_9 ? 1 : 0,
      "CREW_BRIEFING_10": _crew_briefing_10 ? 1 : 0,
    };

    var data = {
      "flightRoute": flightRoute,
      "pre_flight_checklist": pre_flight_checklist,
      "post_flight_checklist": post_flight_checklist,
      "crew_briefing": crew_briefing,
      "remarks": _Remarks.text,
    };

    try {
      var response = await http.Client().post(
        Uri.parse(
            "${AppUrls.formdata}?formid=$formId&formrefno=$rotary_wing_flight_plan_envelope"),
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
        print(responseData);

        EasyLoading.showSuccess("Saved");

        if (status == 'completed') {
          formdata_pass_backend(UserID, userToken);
        }

        // if (status == 'extension') {
        //   EasyLoading.showSuccess("Extension form added successfully");
        // }
        // if (status == 'reduced') {
        //   EasyLoading.showSuccess("Reduced form Added successfully");
        // }

        //formdata_pass_backend(UserID, userToken);
      } else {
        EasyLoading.dismiss();
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
