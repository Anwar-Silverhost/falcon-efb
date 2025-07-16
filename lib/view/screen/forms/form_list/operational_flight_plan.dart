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

class OperationalFlightPlan extends StatefulWidget {
  const OperationalFlightPlan({super.key});

  @override
  State<OperationalFlightPlan> createState() => _OperationalFlightPlanState();
}

class _OperationalFlightPlanState extends State<OperationalFlightPlan> {

  var formId = 'FAF03';
  var currentDate =
      "${DateTime.now().day.toString().padLeft(2, '0')}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().year}";

  String commercial_flight_report_refno = '';


  final TextEditingController _flight_plan_flight = TextEditingController();
  bool _flight_rules_VFR = false;
  bool _flight_rules_IFR = false;
  bool _flight_rules_SVFR = false;
  final TextEditingController _flight_plan_departure_base = TextEditingController();
  final TextEditingController _flight_plan_departure_time_LT_estimated = TextEditingController();
  final TextEditingController _flight_plan_departure_time_LT_actual = TextEditingController();
  final TextEditingController _flight_plan_crusing_speed = TextEditingController();
  final TextEditingController _flight_plan_crusing_alt = TextEditingController();
  final TextEditingController _flight_plan_speed_HRS = TextEditingController();
  final TextEditingController _flight_plan_speed_MIN = TextEditingController();

  final TextEditingController _flight_plan_route_of_flight = TextEditingController();
  final TextEditingController _flight_plan_alternative = TextEditingController();
  final TextEditingController _flight_plan_pilot_in_command = TextEditingController();
  final TextEditingController _flight_plan_co_pilot = TextEditingController();



  //flight 1
  final TextEditingController _flightlog_flight_1__from = TextEditingController();
  final TextEditingController _flightlog_flight_1__to = TextEditingController();
  final TextEditingController _flightlog_flight_1__dist = TextEditingController();
  final TextEditingController _flightlog_flight_1__gs = TextEditingController();
  final TextEditingController _flightlog_flight_1__est_fit_time = TextEditingController();
  final TextEditingController _flightlog_flight_1__est_fuel_req = TextEditingController();
  final TextEditingController _flightlog_flight_1__empty_weight = TextEditingController();
  final TextEditingController _flightlog_flight_1__crew = TextEditingController();
  final TextEditingController _flightlog_flight_1__pax_fwd = TextEditingController();
  final TextEditingController _flightlog_flight_1__pax_aft = TextEditingController();
  final TextEditingController _flightlog_flight_1__baggage_cargo = TextEditingController();
  final TextEditingController _flightlog_flight_1__fuel_on_dep = TextEditingController();
  final TextEditingController _flightlog_flight_1__take_of_weight = TextEditingController();
  final TextEditingController _flightlog_flight_1__cof_g = TextEditingController();
  bool _flightlog_flight_1__w_b_in_limits_pilot_initials = false;
  final TextEditingController _flightlog_flight_1__lmc___pax = TextEditingController();
  final TextEditingController _flightlog_flight_1__lmc___cargo = TextEditingController();
  final TextEditingController _flightlog_flight_1__lmc___tow = TextEditingController();
  final TextEditingController _flightlog_flight_1__burn_rate = TextEditingController();
  bool _flightlog_flight_1__15_min_fuel_check1 = false;
  bool _flightlog_flight_1__15_min_fuel_check2 = false;
  final TextEditingController _flightlog_flight_1__landing_fuel = TextEditingController();
  final TextEditingController _flightlog_flight_1__consumption = TextEditingController();
  final TextEditingController _flightlog_flight_1__fuel_uplift = TextEditingController();
  final TextEditingController _flightlog_flight_1__take_off_time = TextEditingController();
  final TextEditingController _flightlog_flight_1__landing_time = TextEditingController();
  final TextEditingController _flightlog_flight_1__act_fit_time = TextEditingController();




//flight 2
  final TextEditingController _flightlog_flight_2__from = TextEditingController();
  final TextEditingController _flightlog_flight_2__to = TextEditingController();
  final TextEditingController _flightlog_flight_2__dist = TextEditingController();
  final TextEditingController _flightlog_flight_2__gs = TextEditingController();
  final TextEditingController _flightlog_flight_2__est_fit_time = TextEditingController();
  final TextEditingController _flightlog_flight_2__est_fuel_req = TextEditingController();
  final TextEditingController _flightlog_flight_2__empty_weight = TextEditingController();
  final TextEditingController _flightlog_flight_2__crew = TextEditingController();
  final TextEditingController _flightlog_flight_2__pax_fwd = TextEditingController();
  final TextEditingController _flightlog_flight_2__pax_aft = TextEditingController();
  final TextEditingController _flightlog_flight_2__baggage_cargo = TextEditingController();
  final TextEditingController _flightlog_flight_2__fuel_on_dep = TextEditingController();
  final TextEditingController _flightlog_flight_2__take_of_weight = TextEditingController();
  final TextEditingController _flightlog_flight_2__cof_g = TextEditingController();
  bool _flightlog_flight_2__w_b_in_limits_pilot_initials = false;
  final TextEditingController _flightlog_flight_2__lmc___pax = TextEditingController();
  final TextEditingController _flightlog_flight_2__lmc___cargo = TextEditingController();
  final TextEditingController _flightlog_flight_2__lmc___tow = TextEditingController();
  final TextEditingController _flightlog_flight_2__burn_rate = TextEditingController();
  bool _flightlog_flight_2__15_min_fuel_check1 = false;
  bool _flightlog_flight_2__15_min_fuel_check2 = false;
  final TextEditingController _flightlog_flight_2__landing_fuel = TextEditingController();
  final TextEditingController _flightlog_flight_2__consumption = TextEditingController();
  final TextEditingController _flightlog_flight_2__fuel_uplift = TextEditingController();
  final TextEditingController _flightlog_flight_2__take_off_time = TextEditingController();
  final TextEditingController _flightlog_flight_2__landing_time = TextEditingController();
  final TextEditingController _flightlog_flight_2__act_fit_time = TextEditingController();


  //flight3
  final TextEditingController _flightlog_flight_3__from = TextEditingController();
  final TextEditingController _flightlog_flight_3__to = TextEditingController();
  final TextEditingController _flightlog_flight_3__dist = TextEditingController();
  final TextEditingController _flightlog_flight_3__gs = TextEditingController();
  final TextEditingController _flightlog_flight_3__est_fit_time = TextEditingController();
  final TextEditingController _flightlog_flight_3__est_fuel_req = TextEditingController();
  final TextEditingController _flightlog_flight_3__empty_weight = TextEditingController();
  final TextEditingController _flightlog_flight_3__crew = TextEditingController();
  final TextEditingController _flightlog_flight_3__pax_fwd = TextEditingController();
  final TextEditingController _flightlog_flight_3__pax_aft = TextEditingController();
  final TextEditingController _flightlog_flight_3__baggage_cargo = TextEditingController();
  final TextEditingController _flightlog_flight_3__fuel_on_dep = TextEditingController();
  final TextEditingController _flightlog_flight_3__take_of_weight = TextEditingController();
  final TextEditingController _flightlog_flight_3__cof_g = TextEditingController();
  bool _flightlog_flight_3__w_b_in_limits_pilot_initials = false;
  final TextEditingController _flightlog_flight_3__lmc___pax = TextEditingController();
  final TextEditingController _flightlog_flight_3__lmc___cargo = TextEditingController();
  final TextEditingController _flightlog_flight_3__lmc___tow = TextEditingController();
  final TextEditingController _flightlog_flight_3__burn_rate = TextEditingController();
  bool _flightlog_flight_3__15_min_fuel_check1 = false;
  bool _flightlog_flight_3__15_min_fuel_check2 = false;
  final TextEditingController _flightlog_flight_3__landing_fuel = TextEditingController();
  final TextEditingController _flightlog_flight_3__consumption = TextEditingController();
  final TextEditingController _flightlog_flight_3__fuel_uplift = TextEditingController();
  final TextEditingController _flightlog_flight_3__take_off_time = TextEditingController();
  final TextEditingController _flightlog_flight_3__landing_time = TextEditingController();
  final TextEditingController _flightlog_flight_3__act_fit_time = TextEditingController();

  //flight 4
  final TextEditingController _flightlog_flight_4__from = TextEditingController();
  final TextEditingController _flightlog_flight_4__to = TextEditingController();
  final TextEditingController _flightlog_flight_4__dist = TextEditingController();
  final TextEditingController _flightlog_flight_4__gs = TextEditingController();
  final TextEditingController _flightlog_flight_4__est_fit_time = TextEditingController();
  final TextEditingController _flightlog_flight_4__est_fuel_req = TextEditingController();
  final TextEditingController _flightlog_flight_4__empty_weight = TextEditingController();
  final TextEditingController _flightlog_flight_4__crew = TextEditingController();
  final TextEditingController _flightlog_flight_4__pax_fwd = TextEditingController();
  final TextEditingController _flightlog_flight_4__pax_aft = TextEditingController();
  final TextEditingController _flightlog_flight_4__baggage_cargo = TextEditingController();
  final TextEditingController _flightlog_flight_4__fuel_on_dep = TextEditingController();
  final TextEditingController _flightlog_flight_4__take_of_weight = TextEditingController();
  final TextEditingController _flightlog_flight_4__cof_g = TextEditingController();
  bool _flightlog_flight_4__w_b_in_limits_pilot_initials = false;
  final TextEditingController _flightlog_flight_4__lmc___pax = TextEditingController();
  final TextEditingController _flightlog_flight_4__lmc___cargo = TextEditingController();
  final TextEditingController _flightlog_flight_4__lmc___tow = TextEditingController();
  final TextEditingController _flightlog_flight_4__burn_rate = TextEditingController();
  bool _flightlog_flight_4__15_min_fuel_check1 = false;
  bool _flightlog_flight_4__15_min_fuel_check2 = false;
  final TextEditingController _flightlog_flight_4__landing_fuel = TextEditingController();
  final TextEditingController _flightlog_flight_4__consumption = TextEditingController();
  final TextEditingController _flightlog_flight_4__fuel_uplift = TextEditingController();
  final TextEditingController _flightlog_flight_4__take_off_time = TextEditingController();
  final TextEditingController _flightlog_flight_4__landing_time = TextEditingController();
  final TextEditingController _flightlog_flight_4__act_fit_time = TextEditingController();


  final TextEditingController _comments = TextEditingController();
  final TextEditingController _total_flt_time = TextEditingController();


  String flight1_status = 'notcomplete';
  String flight2_status = 'notcomplete';
  String flight3_status = 'notcomplete';
  String flight4_status = 'notcomplete';


  bool _isCheckedx = false;


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


  String? selectedCustomer; // Holds the selected customer
  String? nameofCustomer = '';
  TextEditingController otherCustomerController = TextEditingController();

  final List<String> customers = [
    'ADNOC',
    'PAKISTAN INTERNATIONAL OIL LIMITED (PIOL)',
    'NATIONAL GUARD',
    'BUNDUQ',
    'OTHER CUSTOMERS'
  ];











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
    EasyLoading.show();
    print(
        "${AppUrls.formdata}?formid=$formId&userid=$userID&date=$currentDate");
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
          commercial_flight_report_refno = responseData['data']['form_ref_no'];
        });
        // print(responseData['data']['form_data']['flightlog']['flight1_status']);
        // print(responseData['data']['form_data']['flightlog']['flight1']['flightlog_flight_1__from']);



        String customerName = responseData['data']['form_data']['customer'];

        setState(() {
          // Preselect the customer in the dropdown
          if (customers.contains(customerName)) {
            selectedCustomer = customerName;
          } else {
            // Handle case if customer is not in the predefined list
            selectedCustomer = 'OTHER CUSTOMERS';
            otherCustomerController.text = customerName;
          }
        });




        if ((responseData['data']['form_status']) == 'completed') {
          setState(() {
            _formStatus = 'completed';
            _isCheckedx = true;
          });

        }

        setState(() {

          _flight_plan_flight.text = responseData['data']['form_data']['flightplan']['flight_plan_flight'] ?? '';
          _flight_rules_VFR = responseData['data']['form_data']['flightplan']['flight_rules_VFR'] ?? '';
          _flight_rules_IFR = responseData['data']['form_data']['flightplan']['flight_rules_IFR'] ?? '';
          _flight_rules_SVFR = responseData['data']['form_data']['flightplan']['flight_rules_SVFR'] ?? '';
          _flight_plan_departure_base.text = responseData['data']['form_data']['flightplan']['flight_plan_departure_base'] ?? '';
          _flight_plan_departure_time_LT_estimated.text = responseData['data']['form_data']['flightplan']['flight_plan_departure_time_LT_estimated'] ?? '';
          _flight_plan_departure_time_LT_actual.text = responseData['data']['form_data']['flightplan']['flight_plan_departure_time_LT_actual'] ?? '';
          _flight_plan_crusing_speed.text = responseData['data']['form_data']['flightplan']['flight_plan_crusing_speed'] ?? '';
          _flight_plan_crusing_alt.text = responseData['data']['form_data']['flightplan']['flight_plan_crusing_alt'] ?? '';
          _flight_plan_speed_HRS.text = responseData['data']['form_data']['flightplan']['flight_plan_speed_HRS'] ?? '';
          _flight_plan_speed_MIN.text = responseData['data']['form_data']['flightplan']['flight_plan_speed_MIN'] ?? '';
          _flight_plan_route_of_flight.text = responseData['data']['form_data']['flightplan']['flight_plan_route_of_flight'] ?? '';
          _flight_plan_alternative.text = responseData['data']['form_data']['flightplan']['flight_plan_alternative'] ?? '';
          _flight_plan_pilot_in_command.text = responseData['data']['form_data']['flightplan']['flight_plan_pilot_in_command'] ?? '';
          _flight_plan_co_pilot.text = responseData['data']['form_data']['flightplan']['flight_plan_co_pilot'] ?? '';



          if ((responseData['data']['form_data']['flightlog']['flight1_status']) == 'completed'){
            _flightlog_flight_1__from.text = responseData['data']['form_data']['flightlog']['flight1']['flightlog_flight_1__from'] ?? '';
            _flightlog_flight_1__to.text = responseData['data']['form_data']['flightlog']['flight1']['flightlog_flight_1__to'] ?? '';
            _flightlog_flight_1__dist.text = responseData['data']['form_data']['flightlog']['flight1']['flightlog_flight_1__dist'] ?? '';
            _flightlog_flight_1__gs.text = responseData['data']['form_data']['flightlog']['flight1']['flightlog_flight_1__gs'] ?? '';
            _flightlog_flight_1__est_fit_time.text = responseData['data']['form_data']['flightlog']['flight1']['flightlog_flight_1__est_fit_time'] ?? '';
            _flightlog_flight_1__est_fuel_req.text = responseData['data']['form_data']['flightlog']['flight1']['flightlog_flight_1__est_fuel_req'] ?? '';
            _flightlog_flight_1__empty_weight.text = responseData['data']['form_data']['flightlog']['flight1']['flightlog_flight_1__empty_weight'] ?? '';
            _flightlog_flight_1__crew.text = responseData['data']['form_data']['flightlog']['flight1']['flightlog_flight_1__crew'] ?? '';
            _flightlog_flight_1__pax_fwd.text = responseData['data']['form_data']['flightlog']['flight1']['flightlog_flight_1__pax_fwd'] ?? '';
            _flightlog_flight_1__pax_aft.text = responseData['data']['form_data']['flightlog']['flight1']['flightlog_flight_1__pax_aft'] ?? '';
            _flightlog_flight_1__baggage_cargo.text = responseData['data']['form_data']['flightlog']['flight1']['flightlog_flight_1__baggage_cargo'] ?? '';
            _flightlog_flight_1__fuel_on_dep.text = responseData['data']['form_data']['flightlog']['flight1']['flightlog_flight_1__fuel_on_dep'] ?? '';
            _flightlog_flight_1__take_of_weight.text = responseData['data']['form_data']['flightlog']['flight1']['flightlog_flight_1__take_of_weight'] ?? '';
            _flightlog_flight_1__cof_g.text = responseData['data']['form_data']['flightlog']['flight1']['flightlog_flight_1__cof_g'] ?? '';
            _flightlog_flight_1__w_b_in_limits_pilot_initials =  responseData['data']['form_data']['flightlog']['flight1']['flightlog_flight_1__w_b_in_limits_pilot_initials'] ?? '';
            _flightlog_flight_1__lmc___pax.text = responseData['data']['form_data']['flightlog']['flight1']['flightlog_flight_1__lmc___pax'] ?? '';
            _flightlog_flight_1__lmc___cargo.text = responseData['data']['form_data']['flightlog']['flight1']['flightlog_flight_1__lmc___cargo'] ?? '';
            _flightlog_flight_1__lmc___tow.text = responseData['data']['form_data']['flightlog']['flight1']['flightlog_flight_1__lmc___tow'] ?? '';
            _flightlog_flight_1__burn_rate.text = responseData['data']['form_data']['flightlog']['flight1']['flightlog_flight_1__burn_rate'] ?? '';
            _flightlog_flight_1__15_min_fuel_check1 =  responseData['data']['form_data']['flightlog']['flight1']['flightlog_flight_1__15_min_fuel_check1'] ?? '';
            _flightlog_flight_1__15_min_fuel_check2 =  responseData['data']['form_data']['flightlog']['flight1']['flightlog_flight_1__15_min_fuel_check2'] ?? '';
            _flightlog_flight_1__landing_fuel.text = responseData['data']['form_data']['flightlog']['flight1']['flightlog_flight_1__landing_fuel'] ?? '';
            _flightlog_flight_1__consumption.text = responseData['data']['form_data']['flightlog']['flight1']['flightlog_flight_1__consumption'] ?? '';
            _flightlog_flight_1__fuel_uplift.text = responseData['data']['form_data']['flightlog']['flight1']['flightlog_flight_1__fuel_uplift'] ?? '';
            _flightlog_flight_1__take_off_time.text = responseData['data']['form_data']['flightlog']['flight1']['flightlog_flight_1__take_off_time'] ?? '';
            _flightlog_flight_1__landing_time.text = responseData['data']['form_data']['flightlog']['flight1']['flightlog_flight_1__landing_time'] ?? '';
            _flightlog_flight_1__act_fit_time.text = responseData['data']['form_data']['flightlog']['flight1']['flightlog_flight_1__act_fit_time'] ?? '';
          }

          if ((responseData['data']['form_data']['flightlog']['flight2_status']) == 'completed'){
            _flightlog_flight_2__from.text = responseData['data']['form_data']['flightlog']['flight2']['flightlog_flight_2__from'] ?? '';
            _flightlog_flight_2__to.text = responseData['data']['form_data']['flightlog']['flight2']['flightlog_flight_2__to'] ?? '';
            _flightlog_flight_2__dist.text = responseData['data']['form_data']['flightlog']['flight2']['flightlog_flight_2__dist'] ?? '';
            _flightlog_flight_2__gs.text = responseData['data']['form_data']['flightlog']['flight2']['flightlog_flight_2__gs'] ?? '';
            _flightlog_flight_2__est_fit_time.text = responseData['data']['form_data']['flightlog']['flight2']['flightlog_flight_2__est_fit_time'] ?? '';
            _flightlog_flight_2__est_fuel_req.text = responseData['data']['form_data']['flightlog']['flight2']['flightlog_flight_2__est_fuel_req'] ?? '';
            _flightlog_flight_2__empty_weight.text = responseData['data']['form_data']['flightlog']['flight2']['flightlog_flight_2__empty_weight'] ?? '';
            _flightlog_flight_2__crew.text = responseData['data']['form_data']['flightlog']['flight2']['flightlog_flight_2__crew'] ?? '';
            _flightlog_flight_2__pax_fwd.text = responseData['data']['form_data']['flightlog']['flight2']['flightlog_flight_2__pax_fwd'] ?? '';
            _flightlog_flight_2__pax_aft.text = responseData['data']['form_data']['flightlog']['flight2']['flightlog_flight_2__pax_aft'] ?? '';
            _flightlog_flight_2__baggage_cargo.text = responseData['data']['form_data']['flightlog']['flight2']['flightlog_flight_2__baggage_cargo'] ?? '';
            _flightlog_flight_2__fuel_on_dep.text = responseData['data']['form_data']['flightlog']['flight2']['flightlog_flight_2__fuel_on_dep'] ?? '';
            _flightlog_flight_2__take_of_weight.text = responseData['data']['form_data']['flightlog']['flight2']['flightlog_flight_2__take_of_weight'] ?? '';
            _flightlog_flight_2__cof_g.text = responseData['data']['form_data']['flightlog']['flight2']['flightlog_flight_2__cof_g'] ?? '';
            _flightlog_flight_2__w_b_in_limits_pilot_initials =  responseData['data']['form_data']['flightlog']['flight2']['flightlog_flight_2__w_b_in_limits_pilot_initials'] ?? '';
            _flightlog_flight_2__lmc___pax.text = responseData['data']['form_data']['flightlog']['flight2']['flightlog_flight_2__lmc___pax'] ?? '';
            _flightlog_flight_2__lmc___cargo.text = responseData['data']['form_data']['flightlog']['flight2']['flightlog_flight_2__lmc___cargo'] ?? '';
            _flightlog_flight_2__lmc___tow.text = responseData['data']['form_data']['flightlog']['flight2']['flightlog_flight_2__lmc___tow'] ?? '';
            _flightlog_flight_2__burn_rate.text = responseData['data']['form_data']['flightlog']['flight2']['flightlog_flight_2__burn_rate'] ?? '';
            _flightlog_flight_2__15_min_fuel_check1 =  responseData['data']['form_data']['flightlog']['flight2']['flightlog_flight_2__15_min_fuel_check1'] ?? '';
            _flightlog_flight_2__15_min_fuel_check2 =  responseData['data']['form_data']['flightlog']['flight2']['flightlog_flight_2__15_min_fuel_check2'] ?? '';
            _flightlog_flight_2__landing_fuel.text = responseData['data']['form_data']['flightlog']['flight2']['flightlog_flight_2__landing_fuel'] ?? '';
            _flightlog_flight_2__consumption.text = responseData['data']['form_data']['flightlog']['flight2']['flightlog_flight_2__consumption'] ?? '';
            _flightlog_flight_2__fuel_uplift.text = responseData['data']['form_data']['flightlog']['flight2']['flightlog_flight_2__fuel_uplift'] ?? '';
            _flightlog_flight_2__take_off_time.text = responseData['data']['form_data']['flightlog']['flight2']['flightlog_flight_2__take_off_time'] ?? '';
            _flightlog_flight_2__landing_time.text = responseData['data']['form_data']['flightlog']['flight2']['flightlog_flight_2__landing_time'] ?? '';
            _flightlog_flight_2__act_fit_time.text = responseData['data']['form_data']['flightlog']['flight2']['flightlog_flight_2__act_fit_time'] ?? '';
          }

          if ((responseData['data']['form_data']['flightlog']['flight3_status']) == 'completed'){
            _flightlog_flight_3__from.text = responseData['data']['form_data']['flightlog']['flight3']['flightlog_flight_3__from'] ?? '';
            _flightlog_flight_3__to.text = responseData['data']['form_data']['flightlog']['flight3']['flightlog_flight_3__to'] ?? '';
            _flightlog_flight_3__dist.text = responseData['data']['form_data']['flightlog']['flight3']['flightlog_flight_3__dist'] ?? '';
            _flightlog_flight_3__gs.text = responseData['data']['form_data']['flightlog']['flight3']['flightlog_flight_3__gs'] ?? '';
            _flightlog_flight_3__est_fit_time.text = responseData['data']['form_data']['flightlog']['flight3']['flightlog_flight_3__est_fit_time'] ?? '';
            _flightlog_flight_3__est_fuel_req.text = responseData['data']['form_data']['flightlog']['flight3']['flightlog_flight_3__est_fuel_req'] ?? '';
            _flightlog_flight_3__empty_weight.text = responseData['data']['form_data']['flightlog']['flight3']['flightlog_flight_3__empty_weight'] ?? '';
            _flightlog_flight_3__crew.text = responseData['data']['form_data']['flightlog']['flight3']['flightlog_flight_3__crew'] ?? '';
            _flightlog_flight_3__pax_fwd.text = responseData['data']['form_data']['flightlog']['flight3']['flightlog_flight_3__pax_fwd'] ?? '';
            _flightlog_flight_3__pax_aft.text = responseData['data']['form_data']['flightlog']['flight3']['flightlog_flight_3__pax_aft'] ?? '';
            _flightlog_flight_3__baggage_cargo.text = responseData['data']['form_data']['flightlog']['flight3']['flightlog_flight_3__baggage_cargo'] ?? '';
            _flightlog_flight_3__fuel_on_dep.text = responseData['data']['form_data']['flightlog']['flight3']['flightlog_flight_3__fuel_on_dep'] ?? '';
            _flightlog_flight_3__take_of_weight.text = responseData['data']['form_data']['flightlog']['flight3']['flightlog_flight_3__take_of_weight'] ?? '';
            _flightlog_flight_3__cof_g.text = responseData['data']['form_data']['flightlog']['flight3']['flightlog_flight_3__cof_g'] ?? '';
            _flightlog_flight_3__w_b_in_limits_pilot_initials =  responseData['data']['form_data']['flightlog']['flight3']['flightlog_flight_3__w_b_in_limits_pilot_initials'] ?? '';
            _flightlog_flight_3__lmc___pax.text = responseData['data']['form_data']['flightlog']['flight3']['flightlog_flight_3__lmc___pax'] ?? '';
            _flightlog_flight_3__lmc___cargo.text = responseData['data']['form_data']['flightlog']['flight3']['flightlog_flight_3__lmc___cargo'] ?? '';
            _flightlog_flight_3__lmc___tow.text = responseData['data']['form_data']['flightlog']['flight3']['flightlog_flight_3__lmc___tow'] ?? '';
            _flightlog_flight_3__burn_rate.text = responseData['data']['form_data']['flightlog']['flight3']['flightlog_flight_3__burn_rate'] ?? '';
            _flightlog_flight_3__15_min_fuel_check1 =  responseData['data']['form_data']['flightlog']['flight3']['flightlog_flight_3__15_min_fuel_check1'] ?? '';
            _flightlog_flight_3__15_min_fuel_check2 =  responseData['data']['form_data']['flightlog']['flight3']['flightlog_flight_3__15_min_fuel_check2'] ?? '';
            _flightlog_flight_3__landing_fuel.text = responseData['data']['form_data']['flightlog']['flight3']['flightlog_flight_3__landing_fuel'] ?? '';
            _flightlog_flight_3__consumption.text = responseData['data']['form_data']['flightlog']['flight3']['flightlog_flight_3__consumption'] ?? '';
            _flightlog_flight_3__fuel_uplift.text = responseData['data']['form_data']['flightlog']['flight3']['flightlog_flight_3__fuel_uplift'] ?? '';
            _flightlog_flight_3__take_off_time.text = responseData['data']['form_data']['flightlog']['flight3']['flightlog_flight_3__take_off_time'] ?? '';
            _flightlog_flight_3__landing_time.text = responseData['data']['form_data']['flightlog']['flight3']['flightlog_flight_3__landing_time'] ?? '';
            _flightlog_flight_3__act_fit_time.text = responseData['data']['form_data']['flightlog']['flight3']['flightlog_flight_3__act_fit_time'] ?? '';
          }

          if ((responseData['data']['form_data']['flightlog']['flight4_status']) == 'completed'){
            _flightlog_flight_4__from.text = responseData['data']['form_data']['flightlog']['flight4']['flightlog_flight_4__from'] ?? '';
            _flightlog_flight_4__to.text = responseData['data']['form_data']['flightlog']['flight4']['flightlog_flight_4__to'] ?? '';
            _flightlog_flight_4__dist.text = responseData['data']['form_data']['flightlog']['flight4']['flightlog_flight_4__dist'] ?? '';
            _flightlog_flight_4__gs.text = responseData['data']['form_data']['flightlog']['flight4']['flightlog_flight_4__gs'] ?? '';
            _flightlog_flight_4__est_fit_time.text = responseData['data']['form_data']['flightlog']['flight4']['flightlog_flight_4__est_fit_time'] ?? '';
            _flightlog_flight_4__est_fuel_req.text = responseData['data']['form_data']['flightlog']['flight4']['flightlog_flight_4__est_fuel_req'] ?? '';
            _flightlog_flight_4__empty_weight.text = responseData['data']['form_data']['flightlog']['flight4']['flightlog_flight_4__empty_weight'] ?? '';
            _flightlog_flight_4__crew.text = responseData['data']['form_data']['flightlog']['flight4']['flightlog_flight_4__crew'] ?? '';
            _flightlog_flight_4__pax_fwd.text = responseData['data']['form_data']['flightlog']['flight4']['flightlog_flight_4__pax_fwd'] ?? '';
            _flightlog_flight_4__pax_aft.text = responseData['data']['form_data']['flightlog']['flight4']['flightlog_flight_4__pax_aft'] ?? '';
            _flightlog_flight_4__baggage_cargo.text = responseData['data']['form_data']['flightlog']['flight4']['flightlog_flight_4__baggage_cargo'] ?? '';
            _flightlog_flight_4__fuel_on_dep.text = responseData['data']['form_data']['flightlog']['flight4']['flightlog_flight_4__fuel_on_dep'] ?? '';
            _flightlog_flight_4__take_of_weight.text = responseData['data']['form_data']['flightlog']['flight4']['flightlog_flight_4__take_of_weight'] ?? '';
            _flightlog_flight_4__cof_g.text = responseData['data']['form_data']['flightlog']['flight4']['flightlog_flight_4__cof_g'] ?? '';
            _flightlog_flight_4__w_b_in_limits_pilot_initials =  responseData['data']['form_data']['flightlog']['flight4']['flightlog_flight_4__w_b_in_limits_pilot_initials'] ?? '';
            _flightlog_flight_4__lmc___pax.text = responseData['data']['form_data']['flightlog']['flight4']['flightlog_flight_4__lmc___pax'] ?? '';
            _flightlog_flight_4__lmc___cargo.text = responseData['data']['form_data']['flightlog']['flight4']['flightlog_flight_4__lmc___cargo'] ?? '';
            _flightlog_flight_4__lmc___tow.text = responseData['data']['form_data']['flightlog']['flight4']['flightlog_flight_4__lmc___tow'] ?? '';
            _flightlog_flight_4__burn_rate.text = responseData['data']['form_data']['flightlog']['flight4']['flightlog_flight_4__burn_rate'] ?? '';
            _flightlog_flight_4__15_min_fuel_check1 =  responseData['data']['form_data']['flightlog']['flight4']['flightlog_flight_4__15_min_fuel_check1'] ?? '';
            _flightlog_flight_4__15_min_fuel_check2 =  responseData['data']['form_data']['flightlog']['flight4']['flightlog_flight_4__15_min_fuel_check2'] ?? '';
            _flightlog_flight_4__landing_fuel.text = responseData['data']['form_data']['flightlog']['flight4']['flightlog_flight_4__landing_fuel'] ?? '';
            _flightlog_flight_4__consumption.text = responseData['data']['form_data']['flightlog']['flight4']['flightlog_flight_4__consumption'] ?? '';
            _flightlog_flight_4__fuel_uplift.text = responseData['data']['form_data']['flightlog']['flight4']['flightlog_flight_4__fuel_uplift'] ?? '';
            _flightlog_flight_4__take_off_time.text = responseData['data']['form_data']['flightlog']['flight4']['flightlog_flight_4__take_off_time'] ?? '';
            _flightlog_flight_4__landing_time.text = responseData['data']['form_data']['flightlog']['flight4']['flightlog_flight_4__landing_time'] ?? '';
            _flightlog_flight_4__act_fit_time.text = responseData['data']['form_data']['flightlog']['flight4']['flightlog_flight_4__act_fit_time'] ?? '';
          }


          _comments.text = responseData['data']['form_data']['comments'] ?? '';
          _total_flt_time.text = responseData['data']['form_data']['total_flt_time'] ?? '';

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





  void _calculateTotalWeight(
      emptyWeight,
      crew,
      pax_fwd,
      pax_aft,
      baggage_cargo,
      fuel_on_dep,
      TextEditingController takeOffWeightController,
      ) {
    final xemptyWt = double.tryParse(emptyWeight) ?? 0.0;
    final xcrewWt = double.tryParse(crew) ?? 0.0;
    final xpax_fwd = double.tryParse(pax_fwd) ?? 0.0;
    final xpax_aft = double.tryParse(pax_aft) ?? 0.0;
    final xbaggage_cargo = double.tryParse(baggage_cargo) ?? 0.0;
    final xfuel_on_dep = double.tryParse(fuel_on_dep) ?? 0.0;

    final totalWeight = xemptyWt + xcrewWt + xpax_fwd + xpax_aft + xbaggage_cargo + xfuel_on_dep;

    takeOffWeightController.text = totalWeight.toInt().toString();
  }


  void _calculateConsumption(
      fuel_on_dep,
      landing_fuel,
      TextEditingController consumption
      ){
    final xfuel_on_dep = double.tryParse(fuel_on_dep) ?? 0.0;
    final xlanding_fuel = double.tryParse(landing_fuel) ?? 0.0;

    final total  = xfuel_on_dep - xlanding_fuel ;

    consumption.text = total.toInt().toString();
  }



  void __estimateTimeBydistbyspeed(
      dist_nm,
      gbys_kts,
      TextEditingController est_flt_time
      ) {
    final xdist_nm = double.tryParse(dist_nm) ?? 0.0;
    final xgbys_kts = double.tryParse(gbys_kts) ?? 0.0;

    final totalHours = xdist_nm / xgbys_kts;

    final hours = totalHours.toInt();
    final minutes = ((totalHours - hours) * 60).toInt();

    final formattedTime = "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}";

    est_flt_time.text = formattedTime;
  }



void __actualFlightTime(
    TextEditingController take_off_time, TextEditingController landing_time,  TextEditingController act_flt_time
    ){
  String xxtake_off_time = take_off_time.text;
  String xxlanding_time = landing_time.text;

  if (xxtake_off_time.isNotEmpty && xxlanding_time.isNotEmpty) {
    try {
      // Parse Startup and Shutdown times
      List<String> startParts = xxtake_off_time.split(":");
      List<String> shutdownParts = xxlanding_time.split(":");

      int startHour = int.parse(startParts[0]);
      int startMinute = int.parse(startParts[1]);

      int shutdownHour = int.parse(shutdownParts[0]);
      int shutdownMinute = int.parse(shutdownParts[1]);

      Duration startDuration = Duration(hours: startHour, minutes: startMinute);
      Duration shutdownDuration = Duration(hours: shutdownHour, minutes: shutdownMinute);

      // Calculate Block Time
      Duration blockDuration = shutdownDuration - startDuration;

      // Format Block Time
      String formattedBlockTime =
          "${blockDuration.inHours.toString().padLeft(2, '0')}:${(blockDuration.inMinutes % 60).toString().padLeft(2, '0')}";

      act_flt_time.text = formattedBlockTime;
      __total_flt_time();
    } catch (e) {
      act_flt_time.text = "Error";
    }
  }
}

  void __total_flt_time() {
    String act_time_1 = _flightlog_flight_1__act_fit_time.text;
    String act_time_2 = _flightlog_flight_2__act_fit_time.text;
    String act_time_3 = _flightlog_flight_3__act_fit_time.text;
    String act_time_4 = _flightlog_flight_4__act_fit_time.text;

    Duration parseTime(String time) {
      List<String> timeParts = time.split(":");
      if (timeParts.length != 2) {
        return Duration.zero;
      }
      int hours = int.tryParse(timeParts[0]) ?? 0;
      int minutes = int.tryParse(timeParts[1]) ?? 0;
      return Duration(hours: hours, minutes: minutes);
    }

    Duration flight1 = parseTime(act_time_1);
    Duration flight2 = parseTime(act_time_2);
    Duration flight3 = parseTime(act_time_3);
    Duration flight4 = parseTime(act_time_4);

    Duration totalFlightTime = flight1 + flight2 + flight3 + flight4;

    String formattedTotalTime = "${totalFlightTime.inHours.toString().padLeft(2, '0')}:${(totalFlightTime.inMinutes % 60).toString().padLeft(2, '0')}";

    _total_flt_time.text = formattedTotalTime;
  }



  void __estTotalFuelReq(
      TextEditingController burn_rate_controller,
      TextEditingController est_fli_time,
      TextEditingController estFuelReq
      ) {
    // Get the text from the burn_rate_controller and convert to double
    double burn_rate = double.tryParse(burn_rate_controller.text) ?? 0.0;

    String estimatedTime = est_fli_time.text;

    // Helper function to parse "HH:MM" time into hours as a double
    double parseTimeToHours(String time) {
      List<String> timeParts = time.split(":");
      if (timeParts.length != 2) {
        return 0.0; // Return 0.0 if the format is incorrect
      }
      int hours = int.tryParse(timeParts[0]) ?? 0;
      int minutes = int.tryParse(timeParts[1]) ?? 0;
      return hours + minutes / 60.0;  // Convert total time to hours (including fractional hours for minutes)
    }

    // Convert the estimated flight time to hours
    double flightTimeInHours = parseTimeToHours(estimatedTime);

    // Calculate estimated fuel requirement
    double fuelReq = flightTimeInHours * burn_rate;

    // Display the calculated estimated fuel requirement
    estFuelReq.text = fuelReq.toStringAsFixed(2);  // Display with 2 decimal places
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
                                  flex: 4,
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
                                            'OPERATIONAL FLIGHT PLAN/ COMMERCIAL\nFLIGHT REPORT (CFR)'
                                                .toUpperCase(),
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // Top: Text field
                                      Container(
                                        width: double.infinity,
                                        height: 40,
                                        child: TextField(
                                           autocorrect: false,
                                                              enableSuggestions: false,
                                          controller:TextEditingController( text: commercial_flight_report_refno) ,
                                          decoration: InputDecoration(
                                            hintText: 'CFR No.',
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
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 8, horizontal: 8),
                                          ),
                                        ),
                                      ),

                                      // Space between fields
                                      const SizedBox(height: 5),

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Icon(
                                            Icons.calendar_month_outlined,
                                            color: AppColor.primaryColor,
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            currentDate.toUpperCase(),
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
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Card(
                              color: AppColor.primaryColor,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween, // Space between icon and text
                                  crossAxisAlignment: CrossAxisAlignment
                                      .center, // Vertically centers icon and text
                                  children: [
                                    Expanded(
                                      // Ensures the text stays centered
                                      child: Text(
                                        'FLIGHT PLAN '.toUpperCase(),
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
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    child: SingleChildScrollView(
                                      primary: false,
                                      scrollDirection: Axis.horizontal,
                                      padding: const EdgeInsets.all(5),
                                      child: Table(
                                        border: TableBorder.all(
                                            color: Colors.black26),
                                        columnWidths: const {
                                          0: FixedColumnWidth(180.0),
                                          1: FixedColumnWidth(140.0),
                                          2: FixedColumnWidth(120.0),
                                        },
                                        children: [
                                          TableRow(children: [
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                'HELICOPTER TYPE'.toUpperCase(),
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
                                                'Helicopter REG'.toUpperCase(),
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
                                                'Flight #'.toUpperCase(),
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
                                              padding: const EdgeInsets.all(0),
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
                                                        fontSize: 16.0,
                                                        color:
                                                            AppColor.textColor),
                                                    scrollPhysics:
                                                        const NeverScrollableScrollPhysics(),
                                                    controller:TextEditingController( text: selectMaingroup) ,
                                                    decoration: const InputDecoration(
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
                                              padding: const EdgeInsets.all(0),
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
                                                        fontSize: 16.0,
                                                        color:
                                                            AppColor.textColor),
                                                    scrollPhysics:
                                                        const NeverScrollableScrollPhysics(),
                                                    controller:TextEditingController( text: selectedGroupName) ,
                                                    decoration: const InputDecoration(
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
                                              padding: const EdgeInsets.all(0),
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
                                                        fontSize: 16.0,
                                                        color:
                                                            AppColor.textColor),
                                                    scrollPhysics:
                                                        const NeverScrollableScrollPhysics(),
                                                    controller: _flight_plan_flight,
                                                    decoration: const InputDecoration(
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
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    margin: EdgeInsets.all(0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Table(
                                            border: TableBorder.all(
                                                color: Colors.black26),
                                            children: [
                                              TableRow(children: [
                                                Container(
                                                    height: 90.0,
                                                    child: Center(
                                                        child: Text(
                                                      'Flight rules'
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                        fontFamily:
                                                            AppFont.OutfitFont,
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    )))
                                              ]),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Table(
                                            border: TableBorder.all(
                                                color: Colors.black26),
                                            children: [
                                              TableRow(children: [
                                                Container(
                                                    height: 30.0,
                                                    child: Center(
                                                        child: Text(
                                                      'VFR',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            AppFont.OutfitFont,
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ))),
                                                Container(
                                                  height: 30.0,
                                                  child: Checkbox(
                                                    value: _flight_rules_VFR,
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
                                                        _flight_rules_VFR =
                                                            value ?? false;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ]),
                                              TableRow(children: [
                                                Container(
                                                    height: 30.0,
                                                    child: Center(
                                                        child: Text(
                                                      'IFR',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            AppFont.OutfitFont,
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ))),
                                                Container(
                                                  height: 30.0,
                                                  child: Checkbox(
                                                    value: _flight_rules_IFR,
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
                                                        _flight_rules_IFR =
                                                            value ?? false;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ]),
                                              TableRow(children: [
                                                Container(
                                                    height: 30.0,
                                                    child: Center(
                                                        child: Text(
                                                      'SVFR',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            AppFont.OutfitFont,
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ))),
                                                Container(
                                                  height: 30.0,
                                                  child: Checkbox(
                                                    value: _flight_rules_SVFR,
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
                                                        _flight_rules_SVFR =
                                                            value ?? false;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ]),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),

                            Table(
                              border: const TableBorder(
                                top: BorderSide(color: Colors.black26),
                                left: BorderSide(color: Colors.black26),
                                right: BorderSide(color: Colors.black26),
                                horizontalInside:
                                    BorderSide(color: Colors.black26),
                                verticalInside:
                                    BorderSide(color: Colors.black26),
                              ),
                              columnWidths: const {
                                0: FixedColumnWidth(150.0),
                                1: FixedColumnWidth(200.0),
                                2: FixedColumnWidth(200.0),
                                3: FixedColumnWidth(200.0),
                              },
                              children: [
                                TableRow(children: [
                                  Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Container()),
                                  Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      'DEPARTURE TIME (LT) '.toUpperCase(),
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
                                      'CRUISING '.toUpperCase(),
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
                                      'FUEL ON BOARD'.toUpperCase(),
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
                              ],
                            ),
                            Table(
                              border: TableBorder.all(color: Colors.black26),
                              columnWidths: const {
                                0: FixedColumnWidth(150.0),
                                1: FixedColumnWidth(100.0),
                                2: FixedColumnWidth(100.0),
                                3: FixedColumnWidth(100.0),
                                4: FixedColumnWidth(100.0),
                                5: FixedColumnWidth(100.0),
                                6: FixedColumnWidth(100.0),
                              },
                              children: [
                                TableRow(children: [
                                  Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      'Departure Base'.toUpperCase(),
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
                                      'Estimated'.toUpperCase(),
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
                                      'Actual'.toUpperCase(),
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
                                      'Speed (KTS)'.toUpperCase(),
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
                                      'ALT (FT)'.toUpperCase(),
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
                                      'HRS'.toUpperCase(),
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
                                      'MIN'.toUpperCase(),
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
                                TableRow(children: [
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
                                            textCapitalization: TextCapitalization.characters,
                                          style: const TextStyle(
                                              fontSize: 16.0,
                                              color: AppColor.textColor),
                                          scrollPhysics:
                                              const NeverScrollableScrollPhysics(),
                                          controller: _flight_plan_departure_base,
                                          decoration: const InputDecoration(
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
                                          controller: _flight_plan_departure_time_LT_estimated,
                                          readOnly: true,
                                          onTap: () async {
                                            TimeOfDay? pickedTime = await showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now(),
                                              builder: (context, child) {
                                                return MediaQuery(
                                                  data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                                  child: child!,
                                                );
                                              },
                                            );

                                            if (pickedTime != null) {
                                              // Format the selected time and update the TextField
                                              String formattedTime =
                                                  '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                                              _flight_plan_departure_time_LT_estimated.text = formattedTime; // Update the controller's text
                                            }
                                          },
                                          decoration: const InputDecoration(
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
                                          controller: _flight_plan_departure_time_LT_actual,
                                          readOnly: true,
                                          onTap: () async {
                                            TimeOfDay? pickedTime = await showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now(),
                                              builder: (context, child) {
                                                return MediaQuery(
                                                  data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                                  child: child!,
                                                );
                                              },
                                            );

                                            if (pickedTime != null) {
                                              // Format the selected time and update the TextField
                                              String formattedTime =
                                                  '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                                              _flight_plan_departure_time_LT_actual.text = formattedTime; // Update the controller's text
                                            }
                                          },
                                          decoration: const InputDecoration(
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
                                          controller: _flight_plan_crusing_speed,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
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
                                          controller: _flight_plan_crusing_alt,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
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
                                          controller: _flight_plan_speed_HRS,

                                          readOnly: true,
                                          onTap: () async {
                                            TimeOfDay? pickedTime = await showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now(),
                                              builder: (context, child) {
                                                return MediaQuery(
                                                  data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                                  child: child!,
                                                );
                                              },
                                            );

                                            if (pickedTime != null) {
                                              // Only display the hour, set minutes to 00
                                              String formattedTime = '${pickedTime.hour.toString().padLeft(2, '0')}:00';
                                              String formattedTimez ="00:" + pickedTime.minute.toString().padLeft(2, '0') ;
                                              _flight_plan_speed_MIN.text = formattedTimez;
                                              _flight_plan_speed_HRS.text = formattedTime;
                                            }
                                          },
                                          decoration: const InputDecoration(
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
                                          controller: _flight_plan_speed_MIN,

                                          readOnly: true,
                                          onTap: () async {
                                            TimeOfDay? pickedTime = await showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay(hour: 0, minute: 0), // Set default hour to 0
                                              builder: (context, child) {
                                                return MediaQuery(
                                                  data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                                  child: child!,
                                                );
                                              },
                                            );

                                            if (pickedTime != null) {
                                              String formattedTimez = '${pickedTime.hour.toString().padLeft(2, '0')}:00';
                                              _flight_plan_speed_HRS.text = formattedTimez;

                                              String formattedTime ="00:" + pickedTime.minute.toString().padLeft(2, '0') ; // Always set seconds as 00
                                              _flight_plan_speed_MIN.text = formattedTime; // Update the controller's text
                                            }
                                          },


                                          decoration: const InputDecoration(
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
                            Table(
                              border: TableBorder.all(color: Colors.black26),
                              columnWidths: const {
                                0: FixedColumnWidth(500.0),
                                1: FixedColumnWidth(250.0),
                              },
                              children: [
                                TableRow(children: [
                                  Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      'Route of flight'.toUpperCase(),
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
                                      'alternate'.toUpperCase(),
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
                                TableRow(children: [
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
                                          textCapitalization: TextCapitalization.characters,
                                          controller: _flight_plan_route_of_flight,
                                          decoration: const InputDecoration(
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
                                          controller: _flight_plan_alternative,
                                          textCapitalization: TextCapitalization.characters,
                                          decoration: const InputDecoration(
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
                            Table(
                              border: TableBorder.all(color: Colors.black26),
                              columnWidths: const {
                                0: FixedColumnWidth(375.0),
                                1: FixedColumnWidth(375.0),
                              },
                              children: [
                                TableRow(children: [
                                  Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      'Pilot-in-command'.toUpperCase(),
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
                                      'Co-pilot'.toUpperCase(),
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
                                TableRow(children: [
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
                                          controller: _flight_plan_pilot_in_command,
                                          textCapitalization: TextCapitalization.characters,
                                          decoration: const InputDecoration(
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
                                          controller: _flight_plan_co_pilot,
                                          textCapitalization: TextCapitalization.characters,
                                          decoration: const InputDecoration(
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
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'CUSTOMER : '.toUpperCase(),
                                            style: TextStyle(
                                              fontFamily: AppFont.OutfitFont,
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: DropdownButtonFormField<String>(
                                              value: selectedCustomer,
                                              items: customers.map((String customer) {
                                                return DropdownMenuItem<String>(
                                                  value: customer,
                                                  child: Text(
                                                    customer,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(fontSize: 16),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedCustomer = value;
                                                  if (value != 'OTHER CUSTOMERS') {
                                                    otherCustomerController.clear();
                                                  }
                                                });
                                              },
                                              decoration: InputDecoration(
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
                                              ),
                                              isExpanded: true,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      if (selectedCustomer == 'OTHER CUSTOMERS')
                                        TextField(
                                          autocorrect: false,
                                          enableSuggestions: false,
                                          controller: otherCustomerController,
                                          textCapitalization: TextCapitalization.characters,
                                          decoration: InputDecoration(
                                            hintText: 'Enter Customer Name',
                                            hintStyle: const TextStyle(color: Color(0xFFCACAC9)),
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
                                          ),
                                          style: TextStyle(color: Colors.black),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),




                            const SizedBox(height: 15),



//dropdown
// Expanded(
                            //   child: TextField(
                            //      autocorrect: false,
                            //                         enableSuggestions: false,
                            //     controller:TextEditingController( text: fullName) ,
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







                            Card(
                              color: AppColor.primaryColor,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween, // Space between icon and text
                                  crossAxisAlignment: CrossAxisAlignment
                                      .center, // Vertically centers icon and text
                                  children: [
                                    Expanded(
                                      // Ensures the text stays centered
                                      child: Text(
                                        'FLIGHT LOG'.toUpperCase(),
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

                            const SizedBox(height: 10),

                            Table(
                              border: const TableBorder(
                                top: BorderSide(color: Colors.black26),
                                left: BorderSide(color: Colors.black26),
                                right: BorderSide(color: Colors.black26),
                                bottom: BorderSide(color: Colors.black26),
                                horizontalInside:
                                    BorderSide(color: Colors.black26),
                                verticalInside:
                                    BorderSide(color: Colors.black26),
                              ),
                              columnWidths: const {
                                0: FixedColumnWidth(172.0),
                                1: FixedColumnWidth(117.0),
                                2: FixedColumnWidth(115.0),
                                3: FixedColumnWidth(115.0),
                                4: FixedColumnWidth(115.0),
                                5: FixedColumnWidth(115.0),
                              },
                              children: [
                                TableRow(children: [
                                  Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Container()),
                                  Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      'Flight 1',
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
                                      'Offshore Field Operations',
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
                                      'Flight 2',
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
                                      'Flight 3',
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
                                      'Flight 4',
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
                              ],
                            ),

                            Container(
                              color: AppColor.secondaryColor,
                              child: Table(
                                columnWidths: const {
                                  0: FixedColumnWidth(750.0),
                                },
                                children: [
                                  TableRow(children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        'PRE-FLIGHT',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: AppFont.OutfitFont,
                                          color: Colors
                                              .white, // Change text color for contrast
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ]),
                                ],
                              ),
                            ),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Table(
                                    border: TableBorder(
                                        horizontalInside:
                                            BorderSide(color: Colors.black26),
                                        verticalInside:
                                            BorderSide(color: Colors.black26),
                                        right:
                                            BorderSide(color: Colors.black26),
                                        bottom:
                                            BorderSide(color: Colors.black26),
                                        left:
                                            BorderSide(color: Colors.black26)),
                                    children: [
                                      TableRow(children: [
                                        Container(
                                            height: 30.0,
                                            child: Center(
                                                child: Text(
                                              'FROM',
                                              style: TextStyle(
                                                fontFamily: AppFont.OutfitFont,
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ))),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                            height: 30.0,
                                            child: Center(
                                                child: Text(
                                              'TO',
                                              style: TextStyle(
                                                fontFamily: AppFont.OutfitFont,
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ))),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                            height: 30.0,
                                            child: Center(
                                                child: Text(
                                              'DIST (NM)',
                                              style: TextStyle(
                                                fontFamily: AppFont.OutfitFont,
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ))),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                            height: 30.0,
                                            child: Center(
                                                child: Text(
                                              'G/S (KTS)',
                                              style: TextStyle(
                                                fontFamily: AppFont.OutfitFont,
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ))),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                            height: 30.0,
                                            child: Center(
                                                child: Text(
                                              'EST. Fit. Time',
                                              style: TextStyle(
                                                fontFamily: AppFont.OutfitFont,
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ))),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                            height: 50.0,
                                            child: Center(
                                                child: Text(
                                              'Est. Fuel Req.\n(KG/LBS)',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: AppFont.OutfitFont,
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ))),
                                      ]),
                                    ],
                                  ),
                                ),
                                
                                
                                Expanded(
                                  flex: 2,
                                  child: Table(
                                    border: TableBorder(
                                        horizontalInside:
                                            BorderSide(color: Colors.black26),
                                        verticalInside:
                                            BorderSide(color: Colors.black26),
                                        right:
                                            BorderSide(color: Colors.black26),
                                        bottom:
                                            BorderSide(color: Colors.black26)),
                                    children: [
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            controller: _flightlog_flight_1__from ,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,

                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 7.0,
                                                      vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            controller: _flightlog_flight_1__to ,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,

                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 7.0,
                                                      vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            controller: _flightlog_flight_1__dist ,
                                            onChanged: (value) {
                                              __estimateTimeBydistbyspeed(
                                                _flightlog_flight_1__dist.text,
                                                _flightlog_flight_1__gs.text,
                                                _flightlog_flight_1__est_fit_time,
                                              );
                                            },
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 7.0,
                                                      vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            controller: _flightlog_flight_1__gs ,
                                            onChanged: (value) {
                                              __estimateTimeBydistbyspeed(
                                                _flightlog_flight_1__dist.text,
                                                _flightlog_flight_1__gs.text,
                                                _flightlog_flight_1__est_fit_time,
                                              );
                                            },
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 7.0,
                                                      vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            controller: _flightlog_flight_1__est_fit_time ,

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
                                            //     _flightlog_flight_1__est_fit_time.text = formattedTime; // Update the controller's text
                                            //   }
                                            // },

                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 7.0,
                                                      vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 50.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            controller: _flightlog_flight_1__est_fuel_req ,
                                            readOnly:true,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 7.0,
                                                      vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                    ],
                                  ),
                                ),


                                Expanded(
                                  flex: 2,
                                  child: Table(
                                    border: TableBorder(
                                      horizontalInside:
                                          BorderSide(color: Colors.black26),
                                      verticalInside:
                                          BorderSide(color: Colors.black26),
                                      right: BorderSide(color: Colors.black26),
                                      bottom: BorderSide(color: Colors.black26),
                                    ),
                                    children: [
                                      TableRow(children: [
                                        Container(
                                            height: 200.0,
                                            child: Center(
                                                child: Text(
                                              "As Req'd Inner\nField Ops",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: AppFont.OutfitFont,
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            )))
                                      ]),
                                    ],
                                  ),
                                ),


                                // Expanded(
                                //   flex: 2,
                                //   child: Table(
                                //     border: TableBorder(
                                //         horizontalInside:
                                //             BorderSide(color: Colors.black26),
                                //         verticalInside:
                                //             BorderSide(color: Colors.black26),
                                //         right:
                                //             BorderSide(color: Colors.black26),
                                //         bottom:
                                //             BorderSide(color: Colors.black26)),
                                //     children: [
                                //       TableRow(children: [
                                //         Container(
                                //           height: 30.0,
                                //           alignment: Alignment.center,
                                //           child: TextField(
                                //  autocorrect: false,
                                //                               enableSuggestions: false,
                                //             style: TextStyle(
                                //               fontSize: 14.0,
                                //               color: AppColor.textColor,
                                //             ),
                                //             decoration: InputDecoration(
                                //               border: InputBorder.none,
                                //               contentPadding:
                                //                   EdgeInsets.symmetric(
                                //                       horizontal: 7.0,
                                //                       vertical: 14.0),
                                //             ),
                                //           ),
                                //         ),
                                //       ]),
                                //       TableRow(children: [
                                //         Container(
                                //           height: 30.0,
                                //           alignment: Alignment.center,
                                //           child: TextField(
                                //  autocorrect: false,
                                //                               enableSuggestions: false,
                                //             style: TextStyle(
                                //               fontSize: 14.0,
                                //               color: AppColor.textColor,
                                //             ),
                                //             decoration: InputDecoration(
                                //               border: InputBorder.none,
                                //               contentPadding:
                                //                   EdgeInsets.symmetric(
                                //                       horizontal: 7.0,
                                //                       vertical: 14.0),
                                //             ),
                                //           ),
                                //         ),
                                //       ]),
                                //       TableRow(children: [
                                //         Container(
                                //           height: 30.0,
                                //           alignment: Alignment.center,
                                //           child: TextField(
                                //  autocorrect: false,
                                //                               enableSuggestions: false,
                                //             style: TextStyle(
                                //               fontSize: 14.0,
                                //               color: AppColor.textColor,
                                //             ),
                                //             decoration: InputDecoration(
                                //               border: InputBorder.none,
                                //               contentPadding:
                                //                   EdgeInsets.symmetric(
                                //                       horizontal: 7.0,
                                //                       vertical: 14.0),
                                //             ),
                                //           ),
                                //         ),
                                //       ]),
                                //       TableRow(children: [
                                //         Container(
                                //           height: 30.0,
                                //           alignment: Alignment.center,
                                //           child: TextField(
                                //  autocorrect: false,
                                //                               enableSuggestions: false,
                                //             style: TextStyle(
                                //               fontSize: 14.0,
                                //               color: AppColor.textColor,
                                //             ),
                                //             decoration: InputDecoration(
                                //               border: InputBorder.none,
                                //               contentPadding:
                                //                   EdgeInsets.symmetric(
                                //                       horizontal: 7.0,
                                //                       vertical: 14.0),
                                //             ),
                                //           ),
                                //         ),
                                //       ]),
                                //       TableRow(children: [
                                //         Container(
                                //           height: 30.0,
                                //           alignment: Alignment.center,
                                //           child: TextField(
                                //  autocorrect: false,
                                //                               enableSuggestions: false,
                                //             style: TextStyle(
                                //               fontSize: 14.0,
                                //               color: AppColor.textColor,
                                //             ),
                                //             decoration: InputDecoration(
                                //               border: InputBorder.none,
                                //               contentPadding:
                                //                   EdgeInsets.symmetric(
                                //                       horizontal: 7.0,
                                //                       vertical: 14.0),
                                //             ),
                                //           ),
                                //         ),
                                //       ]),
                                //       TableRow(children: [
                                //         Container(
                                //           height: 50.0,
                                //           alignment: Alignment.center,
                                //           child: TextField(
                                //  autocorrect: false,
                                //                               enableSuggestions: false,
                                //             style: TextStyle(
                                //               fontSize: 14.0,
                                //               color: AppColor.textColor,
                                //             ),
                                //             decoration: InputDecoration(
                                //               border: InputBorder.none,
                                //               contentPadding:
                                //                   EdgeInsets.symmetric(
                                //                       horizontal: 7.0,
                                //                       vertical: 14.0),
                                //             ),
                                //           ),
                                //         ),
                                //       ]),
                                //     ],
                                //   ),
                                // ),
                                Expanded(
                                  flex: 2,
                                  child: Table(
                                    border: TableBorder(
                                        horizontalInside:
                                        BorderSide(color: Colors.black26),
                                        verticalInside:
                                        BorderSide(color: Colors.black26),
                                        right:
                                        BorderSide(color: Colors.black26),
                                        bottom:
                                        BorderSide(color: Colors.black26)),
                                    children: [
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            controller: _flightlog_flight_2__from ,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,

                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            controller: _flightlog_flight_2__to ,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,

                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            controller: _flightlog_flight_2__dist ,
                                            onChanged: (value) {
                                              __estimateTimeBydistbyspeed(
                                                _flightlog_flight_2__dist.text,
                                                _flightlog_flight_2__gs.text,
                                                _flightlog_flight_2__est_fit_time,
                                              );
                                            },
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            controller: _flightlog_flight_2__gs ,
                                            onChanged: (value) {
                                              __estimateTimeBydistbyspeed(
                                                _flightlog_flight_2__dist.text,
                                                _flightlog_flight_2__gs.text,
                                                _flightlog_flight_2__est_fit_time,
                                              );
                                            },
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            controller: _flightlog_flight_2__est_fit_time ,
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
                                            //     _flightlog_flight_2__est_fit_time.text = formattedTime; // Update the controller's text
                                            //   }
                                            // },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 50.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                            autocorrect: false,
                                            enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            controller: _flightlog_flight_2__est_fuel_req ,
                                            readOnly:true,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                    ],
                                  ),
                                ),


                                Expanded(
                                  flex: 2,
                                  child: Table(
                                    border: TableBorder(
                                        horizontalInside:
                                        BorderSide(color: Colors.black26),
                                        verticalInside:
                                        BorderSide(color: Colors.black26),
                                        right:
                                        BorderSide(color: Colors.black26),
                                        bottom:
                                        BorderSide(color: Colors.black26)),
                                    children: [
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            controller: _flightlog_flight_3__from ,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,

                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            controller: _flightlog_flight_3__to ,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,

                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            controller: _flightlog_flight_3__dist ,
                                            onChanged: (value) {
                                              __estimateTimeBydistbyspeed(
                                                _flightlog_flight_3__dist.text,
                                                _flightlog_flight_3__gs.text,
                                                _flightlog_flight_3__est_fit_time,
                                              );
                                            },
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            controller: _flightlog_flight_3__gs ,
                                            onChanged: (value) {
                                              __estimateTimeBydistbyspeed(
                                                _flightlog_flight_3__dist.text,
                                                _flightlog_flight_3__gs.text,
                                                _flightlog_flight_3__est_fit_time,
                                              );
                                            },
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            controller: _flightlog_flight_3__est_fit_time ,
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
                                            //     _flightlog_flight_3__est_fit_time.text = formattedTime; // Update the controller's text
                                            //   }
                                            // },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 50.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            controller: _flightlog_flight_3__est_fuel_req ,
                                            readOnly:true,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                    ],
                                  ),
                                ),

                                Expanded(
                                  flex: 2,
                                  child: Table(
                                    border: TableBorder(
                                        horizontalInside:
                                        BorderSide(color: Colors.black26),
                                        verticalInside:
                                        BorderSide(color: Colors.black26),
                                        right:
                                        BorderSide(color: Colors.black26),
                                        bottom:
                                        BorderSide(color: Colors.black26)),
                                    children: [
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            controller: _flightlog_flight_4__from ,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,

                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            controller: _flightlog_flight_4__to ,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,

                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            controller: _flightlog_flight_4__dist ,
                                            onChanged: (value) {
                                              __estimateTimeBydistbyspeed(
                                                _flightlog_flight_4__dist.text,
                                                _flightlog_flight_4__gs.text,
                                                _flightlog_flight_4__est_fit_time,
                                              );
                                            },
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            controller: _flightlog_flight_4__gs ,
                                            onChanged: (value) {
                                              __estimateTimeBydistbyspeed(
                                                _flightlog_flight_4__dist.text,
                                                _flightlog_flight_4__gs.text,
                                                _flightlog_flight_4__est_fit_time,
                                              );
                                            },
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            controller: _flightlog_flight_4__est_fit_time ,
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
                                            //     _flightlog_flight_4__est_fit_time.text = formattedTime; // Update the controller's text
                                            //   }
                                            // },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 50.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            controller: _flightlog_flight_4__est_fuel_req ,
                                            readOnly:true,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                    ],
                                  ),
                                ),

                              ],
                            ),

                            Container(
                              color: AppColor.secondaryColor,
                              child: Table(
                                columnWidths: const {
                                  0: FixedColumnWidth(750.0),
                                },
                                children: [
                                  TableRow(children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        'WEIGHT & BALANCE',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: AppFont.OutfitFont,
                                          color: Colors
                                              .white, // Change text color for contrast
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ]),
                                ],
                              ),
                            ),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Table(
                                    border: TableBorder(
                                        horizontalInside:
                                            BorderSide(color: Colors.black26),
                                        verticalInside:
                                            BorderSide(color: Colors.black26),
                                        right:
                                            BorderSide(color: Colors.black26),
                                        bottom:
                                            BorderSide(color: Colors.black26),
                                        left:
                                            BorderSide(color: Colors.black26)),
                                    children: [
                                      TableRow(children: [
                                        Container(
                                            height: 30.0,
                                            child: Center(
                                                child: Text(
                                              'Empty Weight',
                                              style: TextStyle(
                                                fontFamily: AppFont.OutfitFont,
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ))),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                            height: 30.0,
                                            child: Center(
                                                child: Text(
                                              'Crew',
                                              style: TextStyle(
                                                fontFamily: AppFont.OutfitFont,
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ))),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                            height: 30.0,
                                            child: Center(
                                                child: Text(
                                              'Pax Fwd',
                                              style: TextStyle(
                                                fontFamily: AppFont.OutfitFont,
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ))),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                            height: 30.0,
                                            child: Center(
                                                child: Text(
                                              'Pax Aft',
                                              style: TextStyle(
                                                fontFamily: AppFont.OutfitFont,
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ))),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                            height: 30.0,
                                            child: Center(
                                                child: Text(
                                              'Baggage/ Cargo',
                                              style: TextStyle(
                                                fontFamily: AppFont.OutfitFont,
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ))),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                            height: 30.0,
                                            child: Center(
                                                child: Text(
                                              'Fuel On Dep.',
                                              style: TextStyle(
                                                fontFamily: AppFont.OutfitFont,
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ))),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                            height: 30.0,
                                            child: Center(
                                                child: Text(
                                              'Take-off Weight',
                                              style: TextStyle(
                                                fontFamily: AppFont.OutfitFont,
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ))),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                            height: 30.0,
                                            child: Center(
                                                child: Text(
                                              'Cof G',
                                              style: TextStyle(
                                                fontFamily: AppFont.OutfitFont,
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ))),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                            height: 50.0,
                                            child: Center(
                                                child: Text(
                                              'W&B in limits',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: AppFont.OutfitFont,
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ))),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                            height: 50.0,
                                            child: Center(
                                                child: Text(
                                              'Last Minute Change',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: AppFont.OutfitFont,
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ))),
                                      ]),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Table(
                                    border: TableBorder(
                                        horizontalInside:
                                        BorderSide(color: Colors.black26),
                                        verticalInside:
                                        BorderSide(color: Colors.black26),
                                        right:
                                        BorderSide(color: Colors.black26),
                                        bottom:
                                        BorderSide(color: Colors.black26)),
                                    children: [
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            keyboardType: TextInputType.number,
                                            controller: _flightlog_flight_1__empty_weight ,
                                            onChanged: (value) {
                                              _calculateTotalWeight(
                                                _flightlog_flight_1__empty_weight.text,
                                                _flightlog_flight_1__crew.text,
                                                _flightlog_flight_1__pax_fwd.text,
                                                _flightlog_flight_1__pax_aft.text,
                                                _flightlog_flight_1__baggage_cargo.text,
                                                _flightlog_flight_1__fuel_on_dep.text,
                                                _flightlog_flight_1__take_of_weight, // Pass the controller directly
                                              );
                                            },

                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            keyboardType: TextInputType.number,
                                            controller: _flightlog_flight_1__crew ,
                                            onChanged: (value) {
                                              _calculateTotalWeight(
                                                _flightlog_flight_1__empty_weight.text,
                                                _flightlog_flight_1__crew.text,
                                                _flightlog_flight_1__pax_fwd.text,
                                                _flightlog_flight_1__pax_aft.text,
                                                _flightlog_flight_1__baggage_cargo.text,
                                                _flightlog_flight_1__fuel_on_dep.text,
                                                _flightlog_flight_1__take_of_weight, // Pass the controller directly
                                              );
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            keyboardType: TextInputType.number,
                                            controller: _flightlog_flight_1__pax_fwd ,
                                            onChanged: (value) {
                                              _calculateTotalWeight(
                                                _flightlog_flight_1__empty_weight.text,
                                                _flightlog_flight_1__crew.text,
                                                _flightlog_flight_1__pax_fwd.text,
                                                _flightlog_flight_1__pax_aft.text,
                                                _flightlog_flight_1__baggage_cargo.text,
                                                _flightlog_flight_1__fuel_on_dep.text,
                                                _flightlog_flight_1__take_of_weight, // Pass the controller directly
                                              );
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            keyboardType: TextInputType.number,
                                            controller: _flightlog_flight_1__pax_aft ,
                                            onChanged: (value) {
                                              _calculateTotalWeight(
                                                _flightlog_flight_1__empty_weight.text,
                                                _flightlog_flight_1__crew.text,
                                                _flightlog_flight_1__pax_fwd.text,
                                                _flightlog_flight_1__pax_aft.text,
                                                _flightlog_flight_1__baggage_cargo.text,
                                                _flightlog_flight_1__fuel_on_dep.text,
                                                _flightlog_flight_1__take_of_weight, // Pass the controller directly
                                              );
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            keyboardType: TextInputType.number,
                                            controller: _flightlog_flight_1__baggage_cargo ,
                                            onChanged: (value) {
                                              _calculateTotalWeight(
                                                _flightlog_flight_1__empty_weight.text,
                                                _flightlog_flight_1__crew.text,
                                                _flightlog_flight_1__pax_fwd.text,
                                                _flightlog_flight_1__pax_aft.text,
                                                _flightlog_flight_1__baggage_cargo.text,
                                                _flightlog_flight_1__fuel_on_dep.text,
                                                _flightlog_flight_1__take_of_weight, // Pass the controller directly
                                              );
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            keyboardType: TextInputType.number,
                                            controller: _flightlog_flight_1__fuel_on_dep ,
                                            onChanged: (value) {
                                              _calculateTotalWeight(
                                                _flightlog_flight_1__empty_weight.text,
                                                _flightlog_flight_1__crew.text,
                                                _flightlog_flight_1__pax_fwd.text,
                                                _flightlog_flight_1__pax_aft.text,
                                                _flightlog_flight_1__baggage_cargo.text,
                                                _flightlog_flight_1__fuel_on_dep.text,
                                                _flightlog_flight_1__take_of_weight, // Pass the controller directly
                                              );
                                              _calculateConsumption(
                                                _flightlog_flight_1__fuel_on_dep.text,
                                                _flightlog_flight_1__landing_fuel.text,
                                                _flightlog_flight_1__consumption,
                                              );
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            keyboardType: TextInputType.number,
                                            controller: _flightlog_flight_1__take_of_weight ,
                                            readOnly: true,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            keyboardType: TextInputType.number,
                                            controller: _flightlog_flight_1__cof_g ,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(
                                        children: [
                                          Container(
                                            height: 50.0,
                                            alignment: Alignment.center,
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                const SizedBox(width: 5),
                                                Text(
                                                  'Pilot\ninitials',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily:
                                                    AppFont.OutfitFont,
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                Checkbox(
                                                  value: _flightlog_flight_1__w_b_in_limits_pilot_initials,
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
                                                      _flightlog_flight_1__w_b_in_limits_pilot_initials =
                                                          value ?? false;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),



                                      TableRow(
                                        children: [
                                          Container(
                                            height: 50.0,
                                            alignment: Alignment.center,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: TextField(
                                                     autocorrect: false,
                                                              enableSuggestions: false,
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: AppColor.textColor,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                    keyboardType: TextInputType.number,
                                                    controller: _flightlog_flight_1__lmc___pax ,
                                                    decoration: InputDecoration(
                                                      contentPadding: EdgeInsets.zero,
                                                      hintText: "PAX",
                                                      hintStyle: const TextStyle(
                                                        fontSize: 6.0,
                                                        color: Color( 0x6B000000),

                                                      ),
                                                      border: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(0),
                                                        borderSide: const BorderSide(
                                                            color: Color(0xFFCACAC9)),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(0),
                                                        borderSide: const BorderSide(
                                                            color: Color(0xFF626262)),
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(0),
                                                        borderSide: const BorderSide(
                                                            color: Color(0xFFCACAC9)),
                                                      ),

                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: TextField(
                                                     autocorrect: false,
                                                              enableSuggestions: false,
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: AppColor.textColor,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                    keyboardType: TextInputType.number,
                                                    controller: _flightlog_flight_1__lmc___cargo ,
                                                    decoration: InputDecoration(
                                                      contentPadding: EdgeInsets.zero,
                                                      hintText: "CARGO",
                                                      hintStyle: const TextStyle(
                                                          fontSize: 6.0,
                                                          color: Color( 0x6B000000)
                                                      ),
                                                      border: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(0),
                                                        borderSide: const BorderSide(
                                                            color: Color(0xFFCACAC9)),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(0),
                                                        borderSide: const BorderSide(
                                                            color: Color(0xFF626262)),
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(0),
                                                        borderSide: const BorderSide(
                                                            color: Color(0xFFCACAC9)),
                                                      ),

                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: TextField(
                                                     autocorrect: false,
                                                              enableSuggestions: false,
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: AppColor.textColor,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                    keyboardType: TextInputType.number,
                                                    controller: _flightlog_flight_1__lmc___tow ,
                                                    decoration: InputDecoration(
                                                      contentPadding: EdgeInsets.zero,
                                                      hintText: "TOW",
                                                      hintStyle: const TextStyle(
                                                          fontSize: 6.0,
                                                          color: Color( 0x6B000000)
                                                      ),
                                                      border: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(0),
                                                        borderSide: const BorderSide(
                                                            color: Color(0xFFCACAC9)),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(0),
                                                        borderSide: const BorderSide(
                                                            color: Color(0xFF626262)),
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(0),
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


                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Table(
                                    border: TableBorder(
                                      horizontalInside:
                                      BorderSide(color: Colors.black26),
                                      verticalInside:
                                      BorderSide(color: Colors.black26),
                                      right: BorderSide(color: Colors.black26),
                                      bottom: BorderSide(color: Colors.black26),
                                    ),
                                    children: [
                                      TableRow(children: [
                                        Container(
                                            height: 340.0,
                                            child: Center(
                                                child: Text(
                                                  "As Req'd Inner\nField Ops",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily: AppFont.OutfitFont,
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                )))
                                      ]),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Table(
                                    border: TableBorder(
                                        horizontalInside:
                                        BorderSide(color: Colors.black26),
                                        verticalInside:
                                        BorderSide(color: Colors.black26),
                                        right:
                                        BorderSide(color: Colors.black26),
                                        bottom:
                                        BorderSide(color: Colors.black26)),
                                    children: [
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            keyboardType: TextInputType.number,
                                            controller: _flightlog_flight_2__empty_weight ,
                                            onChanged: (value) {
                                              _calculateTotalWeight(
                                                _flightlog_flight_2__empty_weight.text,
                                                _flightlog_flight_2__crew.text,
                                                _flightlog_flight_2__pax_fwd.text,
                                                _flightlog_flight_2__pax_aft.text,
                                                _flightlog_flight_2__baggage_cargo.text,
                                                _flightlog_flight_2__fuel_on_dep.text,
                                                _flightlog_flight_2__take_of_weight, // Pass the controller directly
                                              );
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            keyboardType: TextInputType.number,
                                            controller: _flightlog_flight_2__crew ,
                                            onChanged: (value) {
                                              _calculateTotalWeight(
                                                _flightlog_flight_2__empty_weight.text,
                                                _flightlog_flight_2__crew.text,
                                                _flightlog_flight_2__pax_fwd.text,
                                                _flightlog_flight_2__pax_aft.text,
                                                _flightlog_flight_2__baggage_cargo.text,
                                                _flightlog_flight_2__fuel_on_dep.text,
                                                _flightlog_flight_2__take_of_weight, // Pass the controller directly
                                              );
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            keyboardType: TextInputType.number,
                                            controller: _flightlog_flight_2__pax_fwd ,
                                            onChanged: (value) {
                                              _calculateTotalWeight(
                                                _flightlog_flight_2__empty_weight.text,
                                                _flightlog_flight_2__crew.text,
                                                _flightlog_flight_2__pax_fwd.text,
                                                _flightlog_flight_2__pax_aft.text,
                                                _flightlog_flight_2__baggage_cargo.text,
                                                _flightlog_flight_2__fuel_on_dep.text,
                                                _flightlog_flight_2__take_of_weight, // Pass the controller directly
                                              );
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            keyboardType: TextInputType.number,
                                            controller: _flightlog_flight_2__pax_aft ,
                                            onChanged: (value) {
                                              _calculateTotalWeight(
                                                _flightlog_flight_2__empty_weight.text,
                                                _flightlog_flight_2__crew.text,
                                                _flightlog_flight_2__pax_fwd.text,
                                                _flightlog_flight_2__pax_aft.text,
                                                _flightlog_flight_2__baggage_cargo.text,
                                                _flightlog_flight_2__fuel_on_dep.text,
                                                _flightlog_flight_2__take_of_weight, // Pass the controller directly
                                              );
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            keyboardType: TextInputType.number,
                                            controller: _flightlog_flight_2__baggage_cargo ,
                                            onChanged: (value) {
                                              _calculateTotalWeight(
                                                _flightlog_flight_2__empty_weight.text,
                                                _flightlog_flight_2__crew.text,
                                                _flightlog_flight_2__pax_fwd.text,
                                                _flightlog_flight_2__pax_aft.text,
                                                _flightlog_flight_2__baggage_cargo.text,
                                                _flightlog_flight_2__fuel_on_dep.text,
                                                _flightlog_flight_2__take_of_weight, // Pass the controller directly
                                              );
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            keyboardType: TextInputType.number,
                                            controller: _flightlog_flight_2__fuel_on_dep ,
                                            onChanged: (value) {
                                              _calculateTotalWeight(
                                                _flightlog_flight_2__empty_weight.text,
                                                _flightlog_flight_2__crew.text,
                                                _flightlog_flight_2__pax_fwd.text,
                                                _flightlog_flight_2__pax_aft.text,
                                                _flightlog_flight_2__baggage_cargo.text,
                                                _flightlog_flight_2__fuel_on_dep.text,
                                                _flightlog_flight_2__take_of_weight, // Pass the controller directly
                                              );
                                              _calculateConsumption(
                                                _flightlog_flight_2__fuel_on_dep.text,
                                                _flightlog_flight_2__landing_fuel.text,
                                                _flightlog_flight_2__consumption,
                                              );
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            keyboardType: TextInputType.number,
                                            readOnly:true,
                                            controller: _flightlog_flight_2__take_of_weight ,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            keyboardType: TextInputType.number,
                                            controller: _flightlog_flight_2__cof_g ,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(
                                        children: [
                                          Container(
                                            height: 50.0,
                                            alignment: Alignment.center,
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                const SizedBox(width: 5),
                                                Text(
                                                  'Pilot\ninitials',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily:
                                                    AppFont.OutfitFont,
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                Checkbox(
                                                  value: _flightlog_flight_2__w_b_in_limits_pilot_initials,
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
                                                      _flightlog_flight_2__w_b_in_limits_pilot_initials =
                                                          value ?? false;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),



                                      TableRow(
                                        children: [
                                          Container(
                                            height: 50.0,
                                            alignment: Alignment.center,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: TextField(
                                                     autocorrect: false,
                                                              enableSuggestions: false,
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: AppColor.textColor,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                    keyboardType: TextInputType.number,
                                                    controller: _flightlog_flight_2__lmc___pax ,
                                                    decoration: InputDecoration(
                                                      contentPadding: EdgeInsets.zero,
                                                      hintText: "PAX",
                                                      hintStyle: const TextStyle(
                                                        fontSize: 6.0,
                                                        color: Color( 0x6B000000),

                                                      ),
                                                      border: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(0),
                                                        borderSide: const BorderSide(
                                                            color: Color(0xFFCACAC9)),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(0),
                                                        borderSide: const BorderSide(
                                                            color: Color(0xFF626262)),
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(0),
                                                        borderSide: const BorderSide(
                                                            color: Color(0xFFCACAC9)),
                                                      ),

                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: TextField(
                                                     autocorrect: false,
                                                              enableSuggestions: false,
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: AppColor.textColor,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                    keyboardType: TextInputType.number,
                                                    controller: _flightlog_flight_2__lmc___cargo ,
                                                    decoration: InputDecoration(
                                                      contentPadding: EdgeInsets.zero,
                                                      hintText: "CARGO",
                                                      hintStyle: const TextStyle(
                                                          fontSize: 6.0,
                                                          color: Color( 0x6B000000)
                                                      ),
                                                      border: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(0),
                                                        borderSide: const BorderSide(
                                                            color: Color(0xFFCACAC9)),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(0),
                                                        borderSide: const BorderSide(
                                                            color: Color(0xFF626262)),
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(0),
                                                        borderSide: const BorderSide(
                                                            color: Color(0xFFCACAC9)),
                                                      ),

                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: TextField(
                                                     autocorrect: false,
                                                              enableSuggestions: false,
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: AppColor.textColor,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                    keyboardType: TextInputType.number,
                                                    controller: _flightlog_flight_2__lmc___tow ,
                                                    decoration: InputDecoration(
                                                      contentPadding: EdgeInsets.zero,
                                                      hintText: "TOW",
                                                      hintStyle: const TextStyle(
                                                          fontSize: 6.0,
                                                          color: Color( 0x6B000000)
                                                      ),
                                                      border: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(0),
                                                        borderSide: const BorderSide(
                                                            color: Color(0xFFCACAC9)),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(0),
                                                        borderSide: const BorderSide(
                                                            color: Color(0xFF626262)),
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(0),
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


                                    ],
                                  ),
                                ),

                                Expanded(
                                  flex: 2,
                                  child: Table(
                                    border: TableBorder(
                                        horizontalInside:
                                        BorderSide(color: Colors.black26),
                                        verticalInside:
                                        BorderSide(color: Colors.black26),
                                        right:
                                        BorderSide(color: Colors.black26),
                                        bottom:
                                        BorderSide(color: Colors.black26)),
                                    children: [
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            keyboardType: TextInputType.number,
                                            controller: _flightlog_flight_3__empty_weight ,
                                            onChanged: (value) {
                                              _calculateTotalWeight(
                                                _flightlog_flight_3__empty_weight.text,
                                                _flightlog_flight_3__crew.text,
                                                _flightlog_flight_3__pax_fwd.text,
                                                _flightlog_flight_3__pax_aft.text,
                                                _flightlog_flight_3__baggage_cargo.text,
                                                _flightlog_flight_3__fuel_on_dep.text,
                                                _flightlog_flight_3__take_of_weight, // Pass the controller directly
                                              );
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            keyboardType: TextInputType.number,
                                            controller: _flightlog_flight_3__crew ,
                                            onChanged: (value) {
                                              _calculateTotalWeight(
                                                _flightlog_flight_3__empty_weight.text,
                                                _flightlog_flight_3__crew.text,
                                                _flightlog_flight_3__pax_fwd.text,
                                                _flightlog_flight_3__pax_aft.text,
                                                _flightlog_flight_3__baggage_cargo.text,
                                                _flightlog_flight_3__fuel_on_dep.text,
                                                _flightlog_flight_3__take_of_weight, // Pass the controller directly
                                              );
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            keyboardType: TextInputType.number,
                                            controller: _flightlog_flight_3__pax_fwd ,
                                            onChanged: (value) {
                                              _calculateTotalWeight(
                                                _flightlog_flight_3__empty_weight.text,
                                                _flightlog_flight_3__crew.text,
                                                _flightlog_flight_3__pax_fwd.text,
                                                _flightlog_flight_3__pax_aft.text,
                                                _flightlog_flight_3__baggage_cargo.text,
                                                _flightlog_flight_3__fuel_on_dep.text,
                                                _flightlog_flight_3__take_of_weight, // Pass the controller directly
                                              );
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            keyboardType: TextInputType.number,
                                            controller: _flightlog_flight_3__pax_aft ,
                                            onChanged: (value) {
                                              _calculateTotalWeight(
                                                _flightlog_flight_3__empty_weight.text,
                                                _flightlog_flight_3__crew.text,
                                                _flightlog_flight_3__pax_fwd.text,
                                                _flightlog_flight_3__pax_aft.text,
                                                _flightlog_flight_3__baggage_cargo.text,
                                                _flightlog_flight_3__fuel_on_dep.text,
                                                _flightlog_flight_3__take_of_weight, // Pass the controller directly
                                              );
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            keyboardType: TextInputType.number,
                                            controller: _flightlog_flight_3__baggage_cargo ,
                                            onChanged: (value) {
                                              _calculateTotalWeight(
                                                _flightlog_flight_3__empty_weight.text,
                                                _flightlog_flight_3__crew.text,
                                                _flightlog_flight_3__pax_fwd.text,
                                                _flightlog_flight_3__pax_aft.text,
                                                _flightlog_flight_3__baggage_cargo.text,
                                                _flightlog_flight_3__fuel_on_dep.text,
                                                _flightlog_flight_3__take_of_weight, // Pass the controller directly
                                              );
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            keyboardType: TextInputType.number,
                                            controller: _flightlog_flight_3__fuel_on_dep ,
                                            onChanged: (value) {
                                              _calculateTotalWeight(
                                                _flightlog_flight_3__empty_weight.text,
                                                _flightlog_flight_3__crew.text,
                                                _flightlog_flight_3__pax_fwd.text,
                                                _flightlog_flight_3__pax_aft.text,
                                                _flightlog_flight_3__baggage_cargo.text,
                                                _flightlog_flight_3__fuel_on_dep.text,
                                                _flightlog_flight_3__take_of_weight, // Pass the controller directly
                                              );
                                              _calculateConsumption(
                                                _flightlog_flight_3__fuel_on_dep.text,
                                                _flightlog_flight_3__landing_fuel.text,
                                                _flightlog_flight_3__consumption,
                                              );
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            keyboardType: TextInputType.number,
                                            readOnly:true,
                                            controller: _flightlog_flight_3__take_of_weight ,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            keyboardType: TextInputType.number,
                                            controller: _flightlog_flight_3__cof_g ,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(
                                        children: [
                                          Container(
                                            height: 50.0,
                                            alignment: Alignment.center,
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                const SizedBox(width: 5),
                                                Text(
                                                  'Pilot\ninitials',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily:
                                                    AppFont.OutfitFont,
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                Checkbox(
                                                  value: _flightlog_flight_3__w_b_in_limits_pilot_initials,
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
                                                      _flightlog_flight_3__w_b_in_limits_pilot_initials =
                                                          value ?? false;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),



                                      TableRow(
                                        children: [
                                          Container(
                                            height: 50.0,
                                            alignment: Alignment.center,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: TextField(
                                                     autocorrect: false,
                                                              enableSuggestions: false,
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: AppColor.textColor,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                    keyboardType: TextInputType.number,
                                                    controller: _flightlog_flight_3__lmc___pax ,
                                                    decoration: InputDecoration(
                                                      contentPadding: EdgeInsets.zero,
                                                      hintText: "PAX",
                                                      hintStyle: const TextStyle(
                                                        fontSize: 6.0,
                                                        color: Color( 0x6B000000),

                                                      ),
                                                      border: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(0),
                                                        borderSide: const BorderSide(
                                                            color: Color(0xFFCACAC9)),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(0),
                                                        borderSide: const BorderSide(
                                                            color: Color(0xFF626262)),
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(0),
                                                        borderSide: const BorderSide(
                                                            color: Color(0xFFCACAC9)),
                                                      ),

                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: TextField(
                                                     autocorrect: false,
                                                              enableSuggestions: false,
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: AppColor.textColor,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                    keyboardType: TextInputType.number,
                                                    controller: _flightlog_flight_3__lmc___cargo ,
                                                    decoration: InputDecoration(
                                                      contentPadding: EdgeInsets.zero,
                                                      hintText: "CARGO",
                                                      hintStyle: const TextStyle(
                                                          fontSize: 6.0,
                                                          color: Color( 0x6B000000)
                                                      ),
                                                      border: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(0),
                                                        borderSide: const BorderSide(
                                                            color: Color(0xFFCACAC9)),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(0),
                                                        borderSide: const BorderSide(
                                                            color: Color(0xFF626262)),
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(0),
                                                        borderSide: const BorderSide(
                                                            color: Color(0xFFCACAC9)),
                                                      ),

                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: TextField(
                                                     autocorrect: false,
                                                              enableSuggestions: false,
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: AppColor.textColor,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                    keyboardType: TextInputType.number,
                                                    controller: _flightlog_flight_3__lmc___tow ,
                                                    decoration: InputDecoration(
                                                      contentPadding: EdgeInsets.zero,
                                                      hintText: "TOW",
                                                      hintStyle: const TextStyle(
                                                          fontSize: 6.0,
                                                          color: Color( 0x6B000000)
                                                      ),
                                                      border: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(0),
                                                        borderSide: const BorderSide(
                                                            color: Color(0xFFCACAC9)),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(0),
                                                        borderSide: const BorderSide(
                                                            color: Color(0xFF626262)),
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(0),
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


                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Table(
                                    border: TableBorder(
                                        horizontalInside:
                                        BorderSide(color: Colors.black26),
                                        verticalInside:
                                        BorderSide(color: Colors.black26),
                                        right:
                                        BorderSide(color: Colors.black26),
                                        bottom:
                                        BorderSide(color: Colors.black26)),
                                    children: [
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            keyboardType: TextInputType.number,
                                            controller: _flightlog_flight_4__empty_weight ,
                                            onChanged: (value) {
                                              _calculateTotalWeight(
                                                _flightlog_flight_4__empty_weight.text,
                                                _flightlog_flight_4__crew.text,
                                                _flightlog_flight_4__pax_fwd.text,
                                                _flightlog_flight_4__pax_aft.text,
                                                _flightlog_flight_4__baggage_cargo.text,
                                                _flightlog_flight_4__fuel_on_dep.text,
                                                _flightlog_flight_4__take_of_weight, // Pass the controller directly
                                              );
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            keyboardType: TextInputType.number,
                                            controller: _flightlog_flight_4__crew ,
                                            onChanged: (value) {
                                              _calculateTotalWeight(
                                                _flightlog_flight_4__empty_weight.text,
                                                _flightlog_flight_4__crew.text,
                                                _flightlog_flight_4__pax_fwd.text,
                                                _flightlog_flight_4__pax_aft.text,
                                                _flightlog_flight_4__baggage_cargo.text,
                                                _flightlog_flight_4__fuel_on_dep.text,
                                                _flightlog_flight_4__take_of_weight, // Pass the controller directly
                                              );
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            keyboardType: TextInputType.number,
                                            controller: _flightlog_flight_4__pax_fwd ,
                                            onChanged: (value) {
                                              _calculateTotalWeight(
                                                _flightlog_flight_4__empty_weight.text,
                                                _flightlog_flight_4__crew.text,
                                                _flightlog_flight_4__pax_fwd.text,
                                                _flightlog_flight_4__pax_aft.text,
                                                _flightlog_flight_4__baggage_cargo.text,
                                                _flightlog_flight_4__fuel_on_dep.text,
                                                _flightlog_flight_4__take_of_weight, // Pass the controller directly
                                              );
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            keyboardType: TextInputType.number,
                                            controller: _flightlog_flight_4__pax_aft ,
                                            onChanged: (value) {
                                              _calculateTotalWeight(
                                                _flightlog_flight_4__empty_weight.text,
                                                _flightlog_flight_4__crew.text,
                                                _flightlog_flight_4__pax_fwd.text,
                                                _flightlog_flight_4__pax_aft.text,
                                                _flightlog_flight_4__baggage_cargo.text,
                                                _flightlog_flight_4__fuel_on_dep.text,
                                                _flightlog_flight_4__take_of_weight, // Pass the controller directly
                                              );
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            keyboardType: TextInputType.number,
                                            controller: _flightlog_flight_4__baggage_cargo ,
                                            onChanged: (value) {
                                              _calculateTotalWeight(
                                                _flightlog_flight_4__empty_weight.text,
                                                _flightlog_flight_4__crew.text,
                                                _flightlog_flight_4__pax_fwd.text,
                                                _flightlog_flight_4__pax_aft.text,
                                                _flightlog_flight_4__baggage_cargo.text,
                                                _flightlog_flight_4__fuel_on_dep.text,
                                                _flightlog_flight_4__take_of_weight, // Pass the controller directly
                                              );
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            keyboardType: TextInputType.number,
                                            controller: _flightlog_flight_4__fuel_on_dep ,
                                            onChanged: (value) {
                                              _calculateTotalWeight(
                                                _flightlog_flight_4__empty_weight.text,
                                                _flightlog_flight_4__crew.text,
                                                _flightlog_flight_4__pax_fwd.text,
                                                _flightlog_flight_4__pax_aft.text,
                                                _flightlog_flight_4__baggage_cargo.text,
                                                _flightlog_flight_4__fuel_on_dep.text,
                                                _flightlog_flight_4__take_of_weight, // Pass the controller directly
                                              );
                                              _calculateConsumption(
                                                _flightlog_flight_4__fuel_on_dep.text,
                                                _flightlog_flight_4__landing_fuel.text,
                                                _flightlog_flight_4__consumption,
                                              );
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            keyboardType: TextInputType.number,
                                            readOnly: true,
                                            controller: _flightlog_flight_4__take_of_weight ,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            keyboardType: TextInputType.number,
                                            controller: _flightlog_flight_4__cof_g ,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(
                                        children: [
                                          Container(
                                            height: 50.0,
                                            alignment: Alignment.center,
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                const SizedBox(width: 5),
                                                Text(
                                                  'Pilot\ninitials',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily:
                                                    AppFont.OutfitFont,
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                Checkbox(
                                                  value: _flightlog_flight_4__w_b_in_limits_pilot_initials,
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
                                                      _flightlog_flight_4__w_b_in_limits_pilot_initials =
                                                          value ?? false;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),



                                      TableRow(
                                        children: [
                                          Container(
                                            height: 50.0,
                                            alignment: Alignment.center,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: TextField(
                                                     autocorrect: false,
                                                              enableSuggestions: false,
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: AppColor.textColor,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                    keyboardType: TextInputType.number,
                                                    controller: _flightlog_flight_4__lmc___pax ,
                                                    decoration: InputDecoration(
                                                      contentPadding: EdgeInsets.zero,
                                                      hintText: "PAX",
                                                      hintStyle: const TextStyle(
                                                        fontSize: 6.0,
                                                        color: Color( 0x6B000000),

                                                      ),
                                                      border: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(0),
                                                        borderSide: const BorderSide(
                                                            color: Color(0xFFCACAC9)),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(0),
                                                        borderSide: const BorderSide(
                                                            color: Color(0xFF626262)),
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(0),
                                                        borderSide: const BorderSide(
                                                            color: Color(0xFFCACAC9)),
                                                      ),

                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: TextField(
                                                     autocorrect: false,
                                                              enableSuggestions: false,
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: AppColor.textColor,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                    keyboardType: TextInputType.number,
                                                    controller: _flightlog_flight_4__lmc___cargo ,
                                                    decoration: InputDecoration(
                                                      contentPadding: EdgeInsets.zero,
                                                      hintText: "CARGO",
                                                      hintStyle: const TextStyle(
                                                          fontSize: 6.0,
                                                          color: Color( 0x6B000000)
                                                      ),
                                                      border: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(0),
                                                        borderSide: const BorderSide(
                                                            color: Color(0xFFCACAC9)),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(0),
                                                        borderSide: const BorderSide(
                                                            color: Color(0xFF626262)),
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(0),
                                                        borderSide: const BorderSide(
                                                            color: Color(0xFFCACAC9)),
                                                      ),

                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: TextField(
                                                     autocorrect: false,
                                                              enableSuggestions: false,
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: AppColor.textColor,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                    keyboardType: TextInputType.number,
                                                    controller: _flightlog_flight_4__lmc___tow ,
                                                    decoration: InputDecoration(
                                                      contentPadding: EdgeInsets.zero,
                                                      hintText: "TOW",
                                                      hintStyle: const TextStyle(
                                                          fontSize: 6.0,
                                                          color: Color( 0x6B000000)
                                                      ),
                                                      border: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(0),
                                                        borderSide: const BorderSide(
                                                            color: Color(0xFFCACAC9)),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(0),
                                                        borderSide: const BorderSide(
                                                            color: Color(0xFF626262)),
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(0),
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


                                    ],
                                  ),
                                ),





                              ],
                            ),


                            Container(
                              color: AppColor.secondaryColor,
                              child: Table(
                                columnWidths: const {
                                  0: FixedColumnWidth(750.0),
                                },
                                children: [
                                  TableRow(children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        'FUEL',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: AppFont.OutfitFont,
                                          color: Colors
                                              .white, // Change text color for contrast
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ]),
                                ],
                              ),
                            ),


                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Table(
                                    border: TableBorder(
                                        horizontalInside:
                                        BorderSide(color: Colors.black26),
                                        verticalInside:
                                        BorderSide(color: Colors.black26),
                                        right:
                                        BorderSide(color: Colors.black26),
                                        bottom:
                                        BorderSide(color: Colors.black26),
                                        left:
                                        BorderSide(color: Colors.black26)),
                                    children: [
                                      TableRow(children: [
                                        Container(
                                            height: 30.0,
                                            child: Center(
                                                child: Text(
                                                  'Burn Rate',
                                                  style: TextStyle(
                                                    fontFamily: AppFont.OutfitFont,
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ))),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                            height: 60.0,
                                            child: Center(
                                                child: Text(
                                                  '15 Min. Fuel Checks',
                                                  style: TextStyle(
                                                    fontFamily: AppFont.OutfitFont,
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ))),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                            height: 30.0,
                                            child: Center(
                                                child: Text(
                                                  'Landing Fuel',
                                                  style: TextStyle(
                                                    fontFamily: AppFont.OutfitFont,
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ))),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                            height: 30.0,
                                            child: Center(
                                                child: Text(
                                                  'Consumption',
                                                  style: TextStyle(
                                                    fontFamily: AppFont.OutfitFont,
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ))),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                            height: 30.0,
                                            child: Center(
                                                child: Text(
                                                  'Fuel Uplift',
                                                  style: TextStyle(
                                                    fontFamily: AppFont.OutfitFont,
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ))),
                                      ]),
                                      
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Table(
                                    border: TableBorder(
                                        horizontalInside:
                                        BorderSide(color: Colors.black26),
                                        verticalInside:
                                        BorderSide(color: Colors.black26),
                                        right:
                                        BorderSide(color: Colors.black26),
                                        bottom:
                                        BorderSide(color: Colors.black26)),
                                    children: [
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            keyboardType: TextInputType.number,
                                            controller: _flightlog_flight_1__burn_rate ,
                                            onChanged: (value) {
                                              __estTotalFuelReq(
                                                  _flightlog_flight_1__burn_rate,
                                                  _flightlog_flight_1__est_fit_time,
                                                  _flightlog_flight_1__est_fuel_req
                                              );
                                            },

                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: Checkbox(
                                            value: _flightlog_flight_1__15_min_fuel_check1,
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
                                                _flightlog_flight_1__15_min_fuel_check1 =
                                                    value ?? false;
                                              });
                                            },
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child:  Checkbox(
                                            value: _flightlog_flight_1__15_min_fuel_check2,
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
                                                _flightlog_flight_1__15_min_fuel_check2 =
                                                    value ?? false;
                                              });
                                            },
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            keyboardType: TextInputType.number,
                                            controller: _flightlog_flight_1__landing_fuel ,
                                            onChanged: (value) {
                                              _calculateConsumption(
                                                _flightlog_flight_1__fuel_on_dep.text,
                                                _flightlog_flight_1__landing_fuel.text,
                                                _flightlog_flight_1__consumption,
                                              );
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            keyboardType: TextInputType.number,
                                            readOnly:true,
                                            controller: _flightlog_flight_1__consumption ,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            keyboardType: TextInputType.number,
                                            controller: _flightlog_flight_1__fuel_uplift ,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                    ],
                                  ),
                                ),


                                Expanded(
                                  flex: 2,
                                  child: Table(
                                    border: TableBorder(
                                      horizontalInside:
                                      BorderSide(color: Colors.black26),
                                      verticalInside:
                                      BorderSide(color: Colors.black26),
                                      right: BorderSide(color: Colors.black26),
                                      bottom: BorderSide(color: Colors.black26),
                                    ),
                                    children: [
                                      TableRow(children: [
                                        Container(
                                            height: 30.0,
                                            child: Center(
                                                child: Text(
                                                  'Variable',
                                                  style: TextStyle(
                                                    fontFamily: AppFont.OutfitFont,
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ))),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                            height: 30.0,
                                            child: Center(
                                                child: Text(
                                                  'Completed',
                                                  style: TextStyle(
                                                    fontFamily: AppFont.OutfitFont,
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ))),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                            height: 120.0,
                                            child: Center(
                                                child: Text(
                                                  "As Req'd Inner\nField Ops",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily: AppFont.OutfitFont,
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                )))
                                      ]),
                                    ],
                                  ),
                                ),



                                Expanded(
                                  flex: 2,
                                  child: Table(
                                    border: TableBorder(
                                        horizontalInside:
                                        BorderSide(color: Colors.black26),
                                        verticalInside:
                                        BorderSide(color: Colors.black26),
                                        right:
                                        BorderSide(color: Colors.black26),
                                        bottom:
                                        BorderSide(color: Colors.black26)),
                                    children: [
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            keyboardType: TextInputType.number,
                                            controller: _flightlog_flight_2__burn_rate ,
                                            onChanged: (value) {
                                              __estTotalFuelReq(
                                                  _flightlog_flight_2__burn_rate,
                                                  _flightlog_flight_2__est_fit_time,
                                                  _flightlog_flight_2__est_fuel_req
                                              );
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: Checkbox(
                                            value: _flightlog_flight_2__15_min_fuel_check1,
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
                                                _flightlog_flight_2__15_min_fuel_check1 =
                                                    value ?? false;
                                              });
                                            },
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child:  Checkbox(
                                            value: _flightlog_flight_2__15_min_fuel_check2,
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
                                                _flightlog_flight_2__15_min_fuel_check2 =
                                                    value ?? false;
                                              });
                                            },
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            keyboardType: TextInputType.number,
                                            controller: _flightlog_flight_2__landing_fuel ,
                                            onChanged: (value) {
                                              _calculateConsumption(
                                                _flightlog_flight_2__fuel_on_dep.text,
                                                _flightlog_flight_2__landing_fuel.text,
                                                _flightlog_flight_2__consumption,
                                              );
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            keyboardType: TextInputType.number,
                                            readOnly:true,
                                            controller: _flightlog_flight_2__consumption ,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            keyboardType: TextInputType.number,
                                            controller: _flightlog_flight_2__fuel_uplift ,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                    ],
                                  ),
                                ),

                                Expanded(
                                  flex: 2,
                                  child: Table(
                                    border: TableBorder(
                                        horizontalInside:
                                        BorderSide(color: Colors.black26),
                                        verticalInside:
                                        BorderSide(color: Colors.black26),
                                        right:
                                        BorderSide(color: Colors.black26),
                                        bottom:
                                        BorderSide(color: Colors.black26)),
                                    children: [
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            keyboardType: TextInputType.number,
                                            controller: _flightlog_flight_3__burn_rate ,
                                            onChanged: (value) {
                                              __estTotalFuelReq(
                                                  _flightlog_flight_3__burn_rate,
                                                  _flightlog_flight_3__est_fit_time,
                                                  _flightlog_flight_3__est_fuel_req
                                              );
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: Checkbox(
                                            value: _flightlog_flight_3__15_min_fuel_check1,
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
                                                _flightlog_flight_3__15_min_fuel_check1 =
                                                    value ?? false;
                                              });
                                            },
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child:  Checkbox(
                                            value: _flightlog_flight_3__15_min_fuel_check2,
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
                                                _flightlog_flight_3__15_min_fuel_check2 =
                                                    value ?? false;
                                              });
                                            },
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            keyboardType: TextInputType.number,
                                            controller: _flightlog_flight_3__landing_fuel ,
                                            onChanged: (value) {
                                              _calculateConsumption(
                                                _flightlog_flight_3__fuel_on_dep.text,
                                                _flightlog_flight_3__landing_fuel.text,
                                                _flightlog_flight_3__consumption,
                                              );
                                            },


                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            keyboardType: TextInputType.number,
                                            readOnly:true,
                                            controller: _flightlog_flight_3__consumption ,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            keyboardType: TextInputType.number,
                                            controller: _flightlog_flight_3__fuel_uplift ,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Table(
                                    border: TableBorder(
                                        horizontalInside:
                                        BorderSide(color: Colors.black26),
                                        verticalInside:
                                        BorderSide(color: Colors.black26),
                                        right:
                                        BorderSide(color: Colors.black26),
                                        bottom:
                                        BorderSide(color: Colors.black26)),
                                    children: [
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            keyboardType: TextInputType.number,
                                            controller: _flightlog_flight_4__burn_rate ,
                                            onChanged: (value) {
                                              __estTotalFuelReq(
                                                  _flightlog_flight_4__burn_rate,
                                                  _flightlog_flight_4__est_fit_time,
                                                  _flightlog_flight_4__est_fuel_req
                                              );
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: Checkbox(
                                            value: _flightlog_flight_4__15_min_fuel_check1,
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
                                                _flightlog_flight_4__15_min_fuel_check1 =
                                                    value ?? false;
                                              });
                                            },
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child:  Checkbox(
                                            value: _flightlog_flight_4__15_min_fuel_check2,
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
                                                _flightlog_flight_4__15_min_fuel_check2 =
                                                    value ?? false;
                                              });
                                            },
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            keyboardType: TextInputType.number,
                                            controller: _flightlog_flight_4__landing_fuel ,
                                            onChanged: (value) {
                                              _calculateConsumption(
                                                _flightlog_flight_4__fuel_on_dep.text,
                                                _flightlog_flight_4__landing_fuel.text,
                                                _flightlog_flight_4__consumption,
                                              );
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            keyboardType: TextInputType.number,
                                            readOnly:true,
                                            controller: _flightlog_flight_4__consumption ,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            keyboardType: TextInputType.number,
                                            controller: _flightlog_flight_4__fuel_uplift ,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                    ],
                                  ),
                                ),



                              ],
                            ),


                            Container(
                              color: AppColor.secondaryColor,
                              child: Table(
                                columnWidths: const {
                                  0: FixedColumnWidth(750.0),
                                },
                                children: [
                                  TableRow(children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        'FLIGHT TIME',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: AppFont.OutfitFont,
                                          color: Colors
                                              .white, // Change text color for contrast
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ]),
                                ],
                              ),
                            ),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Table(
                                    border: TableBorder(
                                        horizontalInside:
                                        BorderSide(color: Colors.black26),
                                        verticalInside:
                                        BorderSide(color: Colors.black26),
                                        right:
                                        BorderSide(color: Colors.black26),
                                        bottom:
                                        BorderSide(color: Colors.black26),
                                        left:
                                        BorderSide(color: Colors.black26)),
                                    children: [
                                      TableRow(children: [
                                        Container(
                                            height: 30.0,
                                            child: Center(
                                                child: Text(
                                                  'Take-off time (LT) ',
                                                  style: TextStyle(
                                                    fontFamily: AppFont.OutfitFont,
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ))),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                            height: 30.0,
                                            child: Center(
                                                child: Text(
                                                  'Landing time (LT)',
                                                  style: TextStyle(
                                                    fontFamily: AppFont.OutfitFont,
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ))),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                            height: 30.0,
                                            child: Center(
                                                child: Text(
                                                  'Act. Flt Time',
                                                  style: TextStyle(
                                                    fontFamily: AppFont.OutfitFont,
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ))),
                                      ]),
                                       
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Table(
                                    border: TableBorder(
                                        horizontalInside:
                                        BorderSide(color: Colors.black26),
                                        verticalInside:
                                        BorderSide(color: Colors.black26),
                                        right:
                                        BorderSide(color: Colors.black26),
                                        bottom:
                                        BorderSide(color: Colors.black26)),
                                    children: [
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            controller: _flightlog_flight_1__take_off_time ,
                                            readOnly: true,
                                            onTap: () async {
                                              TimeOfDay? pickedTime = await showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now(),
                                                builder: (context, child) {
                                                  return MediaQuery(
                                                    data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                                    child: child!,
                                                  );
                                                },
                                              );

                                              if (pickedTime != null) {
                                                // Format the selected time and update the TextField
                                                String formattedTime =
                                                    '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                                                _flightlog_flight_1__take_off_time.text = formattedTime; // Update the controller's text
                                                __actualFlightTime(
                                                    _flightlog_flight_1__take_off_time,
                                                    _flightlog_flight_1__landing_time,
                                                    _flightlog_flight_1__act_fit_time
                                                );

                                              }
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            controller: _flightlog_flight_1__landing_time ,
                                            readOnly: true,
                                            onTap: () async {
                                              TimeOfDay? pickedTime = await showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now(),
                                                builder: (context, child) {
                                                  return MediaQuery(
                                                    data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                                    child: child!,
                                                  );
                                                },
                                              );

                                              if (pickedTime != null) {
                                                // Format the selected time and update the TextField
                                                String formattedTime =
                                                    '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                                                _flightlog_flight_1__landing_time.text = formattedTime; // Update the controller's text

                                                __actualFlightTime(
                                                    _flightlog_flight_1__take_off_time,
                                                    _flightlog_flight_1__landing_time,
                                                    _flightlog_flight_1__act_fit_time
                                                );


                                              }
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            controller: _flightlog_flight_1__act_fit_time ,
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
                                            //     _flightlog_flight_1__act_fit_time.text = formattedTime; // Update the controller's text
                                            //   }
                                            // },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                       
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Table(
                                    border: TableBorder(
                                      horizontalInside:
                                      BorderSide(color: Colors.black26),
                                      verticalInside:
                                      BorderSide(color: Colors.black26),
                                      right: BorderSide(color: Colors.black26),
                                      bottom: BorderSide(color: Colors.black26),
                                    ),
                                    children: [
                                      TableRow(children: [
                                        Container(
                                            height: 90.0,
                                            child: Center(
                                                child: Text(
                                                  "As Req'd Inner\nField Ops",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily: AppFont.OutfitFont,
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                )))
                                      ]),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Table(
                                    border: TableBorder(
                                        horizontalInside:
                                        BorderSide(color: Colors.black26),
                                        verticalInside:
                                        BorderSide(color: Colors.black26),
                                        right:
                                        BorderSide(color: Colors.black26),
                                        bottom:
                                        BorderSide(color: Colors.black26)),
                                    children: [
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            controller: _flightlog_flight_2__take_off_time ,
                                            readOnly: true,
                                            onTap: () async {
                                              TimeOfDay? pickedTime = await showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now(),
                                                builder: (context, child) {
                                                  return MediaQuery(
                                                    data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                                    child: child!,
                                                  );
                                                },
                                              );

                                              if (pickedTime != null) {
                                                // Format the selected time and update the TextField
                                                String formattedTime =
                                                    '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                                                _flightlog_flight_2__take_off_time.text = formattedTime; // Update the controller's text
                                                __actualFlightTime(
                                                    _flightlog_flight_2__take_off_time,
                                                    _flightlog_flight_2__landing_time,
                                                    _flightlog_flight_2__act_fit_time
                                                );
                                              }
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            controller: _flightlog_flight_2__landing_time ,
                                            readOnly: true,
                                            onTap: () async {
                                              TimeOfDay? pickedTime = await showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now(),
                                                builder: (context, child) {
                                                  return MediaQuery(
                                                    data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                                    child: child!,
                                                  );
                                                },
                                              );

                                              if (pickedTime != null) {
                                                // Format the selected time and update the TextField
                                                String formattedTime =
                                                    '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                                                _flightlog_flight_2__landing_time.text = formattedTime; // Update the controller's text
                                                __actualFlightTime(
                                                    _flightlog_flight_2__take_off_time,
                                                    _flightlog_flight_2__landing_time,
                                                    _flightlog_flight_2__act_fit_time
                                                );
                                              }
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            controller: _flightlog_flight_2__act_fit_time ,
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
                                            //     _flightlog_flight_2__act_fit_time.text = formattedTime; // Update the controller's text
                                            //   }
                                            // },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),

                                    ],
                                  ),
                                ),


                                Expanded(
                                  flex: 2,
                                  child: Table(
                                    border: TableBorder(
                                        horizontalInside:
                                        BorderSide(color: Colors.black26),
                                        verticalInside:
                                        BorderSide(color: Colors.black26),
                                        right:
                                        BorderSide(color: Colors.black26),
                                        bottom:
                                        BorderSide(color: Colors.black26)),
                                    children: [
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            controller: _flightlog_flight_3__take_off_time ,
                                            readOnly: true,
                                            onTap: () async {
                                              TimeOfDay? pickedTime = await showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now(),
                                                builder: (context, child) {
                                                  return MediaQuery(
                                                    data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                                    child: child!,
                                                  );
                                                },
                                              );

                                              if (pickedTime != null) {
                                                // Format the selected time and update the TextField
                                                String formattedTime =
                                                    '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                                                _flightlog_flight_3__take_off_time.text = formattedTime; // Update the controller's text
                                                __actualFlightTime(
                                                    _flightlog_flight_3__take_off_time,
                                                    _flightlog_flight_3__landing_time,
                                                    _flightlog_flight_3__act_fit_time
                                                );
                                              }
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            controller: _flightlog_flight_3__landing_time ,
                                            readOnly: true,
                                            onTap: () async {
                                              TimeOfDay? pickedTime = await showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now(),
                                                builder: (context, child) {
                                                  return MediaQuery(
                                                    data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                                    child: child!,
                                                  );
                                                },
                                              );

                                              if (pickedTime != null) {
                                                // Format the selected time and update the TextField
                                                String formattedTime =
                                                    '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                                                _flightlog_flight_3__landing_time.text = formattedTime; // Update the controller's text
                                                __actualFlightTime(
                                                    _flightlog_flight_3__take_off_time,
                                                    _flightlog_flight_3__landing_time,
                                                    _flightlog_flight_3__act_fit_time
                                                );
                                              }
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            controller: _flightlog_flight_3__act_fit_time ,
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
                                            //     _flightlog_flight_3__act_fit_time.text = formattedTime; // Update the controller's text
                                            //   }
                                            // },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),

                                    ],
                                  ),
                                ),

                                Expanded(
                                  flex: 2,
                                  child: Table(
                                    border: TableBorder(
                                        horizontalInside:
                                        BorderSide(color: Colors.black26),
                                        verticalInside:
                                        BorderSide(color: Colors.black26),
                                        right:
                                        BorderSide(color: Colors.black26),
                                        bottom:
                                        BorderSide(color: Colors.black26)),
                                    children: [
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            controller: _flightlog_flight_4__take_off_time ,
                                            readOnly: true,
                                            onTap: () async {
                                              TimeOfDay? pickedTime = await showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now(),
                                                builder: (context, child) {
                                                  return MediaQuery(
                                                    data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                                    child: child!,
                                                  );
                                                },
                                              );

                                              if (pickedTime != null) {
                                                // Format the selected time and update the TextField
                                                String formattedTime =
                                                    '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                                                _flightlog_flight_4__take_off_time.text = formattedTime; // Update the controller's text
                                                __actualFlightTime(
                                                    _flightlog_flight_4__take_off_time,
                                                    _flightlog_flight_4__landing_time,
                                                    _flightlog_flight_4__act_fit_time
                                                );
                                              }
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            controller: _flightlog_flight_4__landing_time ,
                                            readOnly: true,
                                            onTap: () async {
                                              TimeOfDay? pickedTime = await showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now(),
                                                builder: (context, child) {
                                                  return MediaQuery(
                                                    data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                                    child: child!,
                                                  );
                                                },
                                              );

                                              if (pickedTime != null) {
                                                // Format the selected time and update the TextField
                                                String formattedTime =
                                                    '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                                                _flightlog_flight_4__landing_time.text = formattedTime; // Update the controller's text
                                                __actualFlightTime(
                                                    _flightlog_flight_4__take_off_time,
                                                    _flightlog_flight_4__landing_time,
                                                    _flightlog_flight_4__act_fit_time
                                                );
                                              }
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            controller: _flightlog_flight_4__act_fit_time ,
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
                                            //     _flightlog_flight_4__act_fit_time.text = formattedTime; // Update the controller's text
                                            //   }
                                            // },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),

                                    ],
                                  ),
                                ),
                              ],
                            ),


                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Table(
                                    border: TableBorder(
                                        horizontalInside:
                                        BorderSide(color: Colors.black26),
                                        verticalInside:
                                        BorderSide(color: Colors.black26),
                                        right:
                                        BorderSide(color: Colors.black26),
                                        bottom:
                                        BorderSide(color: Colors.black26),
                                        left:
                                        BorderSide(color: Colors.black26)),
                                    children: [
                                      TableRow(children: [
                                        Container(
                                            height: 50.0,
                                            child: Center(
                                                child: Text(
                                                  'COMMENTS',
                                                  style: TextStyle(
                                                    fontFamily: AppFont.OutfitFont,
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ))),
                                      ]),
                                       

                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Table(
                                    border: TableBorder(
                                        horizontalInside:
                                        BorderSide(color: Colors.black26),
                                        verticalInside:
                                        BorderSide(color: Colors.black26),
                                        right:
                                        BorderSide(color: Colors.black26),
                                        bottom:
                                        BorderSide(color: Colors.black26)),
                                    children: [
                                      TableRow(children: [
                                        Container(
                                          height: 50.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            controller: _comments,
                                            textCapitalization: TextCapitalization.characters,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),


                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Table(
                                    border: TableBorder(
                                      horizontalInside:
                                      BorderSide(color: Colors.black26),
                                      verticalInside:
                                      BorderSide(color: Colors.black26),
                                      right: BorderSide(color: Colors.black26),
                                      bottom: BorderSide(color: Colors.black26),
                                    ),
                                    children: [
                                      TableRow(children: [
                                        Container(
                                            height: 50.0,
                                            child: Center(
                                                child: Text(
                                                  "TOTAL FLT TIME\n(HR: MIN)",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily: AppFont.OutfitFont,
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                )))
                                      ]),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Table(
                                    border: TableBorder(
                                        horizontalInside:
                                        BorderSide(color: Colors.black26),
                                        verticalInside:
                                        BorderSide(color: Colors.black26),
                                        right:
                                        BorderSide(color: Colors.black26),
                                        bottom:
                                        BorderSide(color: Colors.black26)),
                                    children: [
                                      TableRow(children: [
                                        Container(
                                          height: 50.0,
                                          alignment: Alignment.center,
                                          child: TextField(
                                             autocorrect: false,
                                                              enableSuggestions: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.textColor,
                                            ),
                                            controller: _total_flt_time,
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
                                            //     _total_flt_time.text = formattedTime; // Update the controller's text
                                            //   }
                                            // },

                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 7.0,
                                                  vertical: 14.0),
                                            ),
                                          ),
                                        ),
                                      ]),
                                       

                                    ],
                                  ),
                                ),

                              ],
                            ),

                            const SizedBox(height: 15),

                            Row(
                              children: [
                                Expanded(
                                  flex:3,
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Text('Note: ',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: AppFont.OutfitFont,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                          )),
                                      const SizedBox(width: 0),
                                      Text('Positive identification is required and must be verified for \nall passengers prior to departure on all sectors.',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: AppFont.OutfitFont,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                          )),

                                       
                                    ],
                                  ),
                                ),
                                // const SizedBox(width: 5),

                                const SizedBox(width: 20),
                                Expanded(
                                  flex:1,
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                          'SIGNED BY:', // Label for the first text field
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: AppFont.OutfitFont,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                          )),
                                      const SizedBox(width: 10),
                                      Checkbox(
                                        value: _isCheckedx,
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
                                            _isCheckedx =
                                                value ?? false;
                                          });
                                        },
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
                                  "OCC/FOR/10",
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
                                  "02 JUL 2019",
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
                    mainAxisAlignment: MainAxisAlignment
                    .spaceBetween,
                    children: [

                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              "/forms",
                            );
                          },
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.pressed)) {
                                return Colors.white; // Text color when pressed
                              }
                              return Color(0xFFAA182C); // Text color when not pressed
                            }),
                            backgroundColor: MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.pressed)) {
                                return Color(0xFFAA182C); // Background color when pressed
                              }
                              return Colors.white; // Background color when not pressed
                            }),
                            side: MaterialStateProperty.all(BorderSide(color: Color(0xFFAA182C), width: 1)), // Red outline
                            padding: MaterialStateProperty.all(const EdgeInsets.all(13.0)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
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
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: ElevatedButton(
                                onPressed: () {
                                  // EasyLoading.show( status: 'Updating...');


                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Choose an action:'),
                                        actions: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  EasyLoading.show();

                                                  if (_flightlog_flight_1__from.text != '') {
                                                    if (!_flightlog_flight_1__w_b_in_limits_pilot_initials) {
                                                      EasyLoading.showInfo('Please Pilot sign Flight 1 to continue');
                                                    } else if (_flightlog_flight_2__from.text != '') {
                                                      if (!_flightlog_flight_2__w_b_in_limits_pilot_initials) {
                                                        EasyLoading.showInfo('Please Pilot sign Flight 2 to continue');
                                                      } else if (_flightlog_flight_3__from.text != '') {
                                                        if (!_flightlog_flight_3__w_b_in_limits_pilot_initials) {
                                                          EasyLoading.showInfo('Please Pilot sign Flight 3 to continue');
                                                        } else if (_flightlog_flight_4__from.text != '') {
                                                          if (!_flightlog_flight_4__w_b_in_limits_pilot_initials) {
                                                            EasyLoading.showInfo('Please Pilot sign Flight 4 to continue');
                                                          } else {
                                                            setState(() {
                                                              flight1_status = 'completed';
                                                              flight2_status = 'completed';
                                                              flight3_status = 'completed';
                                                              flight4_status = 'completed';
                                                            });
                                                            saveFormData('partialy');
                                                          }
                                                        } else {
                                                          setState(() {
                                                            flight1_status = 'completed';
                                                            flight2_status = 'completed';
                                                            flight3_status = 'completed';
                                                          });
                                                          saveFormData('partialy');
                                                        }
                                                      } else {
                                                        setState(() {
                                                          flight1_status = 'completed';
                                                          flight2_status = 'completed';
                                                        });
                                                        saveFormData('partialy');
                                                      }
                                                    } else {
                                                      setState(() {
                                                        flight1_status = 'completed';
                                                      });
                                                      saveFormData('partialy');
                                                    }
                                                  } else {
                                                    EasyLoading.showInfo('Please provide Flight 1 data to continue');
                                                  }

                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('Save Form Data'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  EasyLoading.show();
                                                  Navigator.of(context).pop();
                                                  if (!_isCheckedx) {
                                                  EasyLoading.showInfo( 'Please Commanders sign in to continue');
                                                  } else {
                                                    if (_flightlog_flight_1__from.text != '') {
                                                      if (!_flightlog_flight_1__w_b_in_limits_pilot_initials) {
                                                        EasyLoading.showInfo('Please Pilot sign Flight 1 to continue');
                                                      } else if (_flightlog_flight_2__from.text != '') {
                                                        if (!_flightlog_flight_2__w_b_in_limits_pilot_initials) {
                                                          EasyLoading.showInfo('Please Pilot sign Flight 2 to continue');
                                                        } else if (_flightlog_flight_3__from.text != '') {
                                                          if (!_flightlog_flight_3__w_b_in_limits_pilot_initials) {
                                                            EasyLoading.showInfo('Please Pilot sign Flight 3 to continue');
                                                          } else if (_flightlog_flight_4__from.text != '') {
                                                            if (!_flightlog_flight_4__w_b_in_limits_pilot_initials) {
                                                              EasyLoading.showInfo('Please Pilot sign Flight 4 to continue');
                                                            } else {
                                                              setState(() {
                                                                flight1_status = 'completed';
                                                                flight2_status = 'completed';
                                                                flight3_status = 'completed';
                                                                flight4_status = 'completed';
                                                              });
                                                              saveFormData('completed');
                                                            }
                                                          } else {
                                                            setState(() {
                                                              flight1_status = 'completed';
                                                              flight2_status = 'completed';
                                                              flight3_status = 'completed';
                                                            });
                                                            saveFormData('completed');
                                                          }
                                                        } else {
                                                          setState(() {
                                                            flight1_status = 'completed';
                                                            flight2_status = 'completed';
                                                          });
                                                          saveFormData('completed');
                                                        }
                                                      } else {
                                                        setState(() {
                                                          flight1_status = 'completed';
                                                        });
                                                        saveFormData('completed');
                                                      }
                                                    } else {
                                                      EasyLoading.showInfo('Please provide Flight 1 data to continue');
                                                    }
                                                  };

 
                                                },
                                                child: Text('Upload Complete Data'),
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
                                      WidgetStateProperty.resolveWith((states) {
                                    if (states.contains(WidgetState.pressed)) {
                                      return Colors.white;
                                    }
                                    return Colors.white70;
                                  }),
                                  backgroundColor:
                                      WidgetStateProperty.resolveWith((states) {
                                    if (states.contains(WidgetState.pressed)) {
                                      return (Color(0xFFE8374F));
                                    }
                                    return (Color(0xFFAA182C));
                                  }),
                                  padding: WidgetStateProperty.all(
                                      const EdgeInsets.all(13.0)),
                                  shape: WidgetStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
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
                            ],),
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



  Future<void> saveFormData(String status) async {

    var aircraft = {
      "aircraftId": selectMaingroupId,
      "aircraftType": selectMaingroup,
      "aircraftRegId": selectedGroupId_id,
      "aircraftRegistration": selectedGroupName
    };


    var flightplan = {
      "flight_plan_flight": _flight_plan_flight.text,
      "flight_rules_VFR" : _flight_rules_VFR,
      "flight_rules_IFR" : _flight_rules_IFR,
      "flight_rules_SVFR" : _flight_rules_SVFR,
      "flight_plan_departure_base": _flight_plan_departure_base.text,
      "flight_plan_departure_time_LT_estimated": _flight_plan_departure_time_LT_estimated.text,
      "flight_plan_departure_time_LT_actual": _flight_plan_departure_time_LT_actual.text,
      "flight_plan_crusing_speed": _flight_plan_crusing_speed.text,
      "flight_plan_crusing_alt": _flight_plan_crusing_alt.text,
      "flight_plan_speed_HRS": _flight_plan_speed_HRS.text,
      "flight_plan_speed_MIN": _flight_plan_speed_MIN.text,
      "flight_plan_route_of_flight": _flight_plan_route_of_flight.text,
      "flight_plan_alternative": _flight_plan_alternative.text,
      "flight_plan_pilot_in_command": _flight_plan_pilot_in_command.text,
      "flight_plan_co_pilot": _flight_plan_co_pilot.text,

    };

    var flight1 = {
      "flightlog_flight_1__from": _flightlog_flight_1__from.text,
      "flightlog_flight_1__to": _flightlog_flight_1__to.text,
      "flightlog_flight_1__dist": _flightlog_flight_1__dist.text,
      "flightlog_flight_1__gs": _flightlog_flight_1__gs.text,
      "flightlog_flight_1__est_fit_time": _flightlog_flight_1__est_fit_time.text,
      "flightlog_flight_1__est_fuel_req": _flightlog_flight_1__est_fuel_req.text,
      "flightlog_flight_1__empty_weight": _flightlog_flight_1__empty_weight.text,
      "flightlog_flight_1__crew": _flightlog_flight_1__crew.text,
      "flightlog_flight_1__pax_fwd": _flightlog_flight_1__pax_fwd.text,
      "flightlog_flight_1__pax_aft": _flightlog_flight_1__pax_aft.text,
      "flightlog_flight_1__baggage_cargo": _flightlog_flight_1__baggage_cargo.text,
      "flightlog_flight_1__fuel_on_dep": _flightlog_flight_1__fuel_on_dep.text,
      "flightlog_flight_1__take_of_weight": _flightlog_flight_1__take_of_weight.text,
      "flightlog_flight_1__cof_g": _flightlog_flight_1__cof_g.text,
      "flightlog_flight_1__lmc___pax": _flightlog_flight_1__lmc___pax.text,
      "flightlog_flight_1__lmc___cargo": _flightlog_flight_1__lmc___cargo.text,
      "flightlog_flight_1__lmc___tow": _flightlog_flight_1__lmc___tow.text,
      "flightlog_flight_1__burn_rate": _flightlog_flight_1__burn_rate.text,
      "flightlog_flight_1__landing_fuel": _flightlog_flight_1__landing_fuel.text,
      "flightlog_flight_1__consumption": _flightlog_flight_1__consumption.text,
      "flightlog_flight_1__fuel_uplift": _flightlog_flight_1__fuel_uplift.text,
      "flightlog_flight_1__take_off_time": _flightlog_flight_1__take_off_time.text,
      "flightlog_flight_1__landing_time": _flightlog_flight_1__landing_time.text,
      "flightlog_flight_1__act_fit_time": _flightlog_flight_1__act_fit_time.text,
      "flightlog_flight_1__w_b_in_limits_pilot_initials" : _flightlog_flight_1__w_b_in_limits_pilot_initials,
      "flightlog_flight_1__15_min_fuel_check1" : _flightlog_flight_1__15_min_fuel_check1,
      "flightlog_flight_1__15_min_fuel_check2" : _flightlog_flight_1__15_min_fuel_check2
    };


    var flight2 = {
      "flightlog_flight_2__from": _flightlog_flight_2__from.text,
      "flightlog_flight_2__to": _flightlog_flight_2__to.text,
      "flightlog_flight_2__dist": _flightlog_flight_2__dist.text,
      "flightlog_flight_2__gs": _flightlog_flight_2__gs.text,
      "flightlog_flight_2__est_fit_time": _flightlog_flight_2__est_fit_time.text,
      "flightlog_flight_2__est_fuel_req": _flightlog_flight_2__est_fuel_req.text,
      "flightlog_flight_2__empty_weight": _flightlog_flight_2__empty_weight.text,
      "flightlog_flight_2__crew": _flightlog_flight_2__crew.text,
      "flightlog_flight_2__pax_fwd": _flightlog_flight_2__pax_fwd.text,
      "flightlog_flight_2__pax_aft": _flightlog_flight_2__pax_aft.text,
      "flightlog_flight_2__baggage_cargo": _flightlog_flight_2__baggage_cargo.text,
      "flightlog_flight_2__fuel_on_dep": _flightlog_flight_2__fuel_on_dep.text,
      "flightlog_flight_2__take_of_weight": _flightlog_flight_2__take_of_weight.text,
      "flightlog_flight_2__cof_g": _flightlog_flight_2__cof_g.text,
      "flightlog_flight_2__lmc___pax": _flightlog_flight_2__lmc___pax.text,
      "flightlog_flight_2__lmc___cargo": _flightlog_flight_2__lmc___cargo.text,
      "flightlog_flight_2__lmc___tow": _flightlog_flight_2__lmc___tow.text,
      "flightlog_flight_2__burn_rate": _flightlog_flight_2__burn_rate.text,
      "flightlog_flight_2__landing_fuel": _flightlog_flight_2__landing_fuel.text,
      "flightlog_flight_2__consumption": _flightlog_flight_2__consumption.text,
      "flightlog_flight_2__fuel_uplift": _flightlog_flight_2__fuel_uplift.text,
      "flightlog_flight_2__take_off_time": _flightlog_flight_2__take_off_time.text,
      "flightlog_flight_2__landing_time": _flightlog_flight_2__landing_time.text,
      "flightlog_flight_2__act_fit_time": _flightlog_flight_2__act_fit_time.text,
      "flightlog_flight_2__w_b_in_limits_pilot_initials" : _flightlog_flight_2__w_b_in_limits_pilot_initials,
      "flightlog_flight_2__15_min_fuel_check1" : _flightlog_flight_2__15_min_fuel_check1,
      "flightlog_flight_2__15_min_fuel_check2" : _flightlog_flight_2__15_min_fuel_check2
    };

    var flight3 = {
      "flightlog_flight_3__from": _flightlog_flight_3__from.text,
      "flightlog_flight_3__to": _flightlog_flight_3__to.text,
      "flightlog_flight_3__dist": _flightlog_flight_3__dist.text,
      "flightlog_flight_3__gs": _flightlog_flight_3__gs.text,
      "flightlog_flight_3__est_fit_time": _flightlog_flight_3__est_fit_time.text,
      "flightlog_flight_3__est_fuel_req": _flightlog_flight_3__est_fuel_req.text,
      "flightlog_flight_3__empty_weight": _flightlog_flight_3__empty_weight.text,
      "flightlog_flight_3__crew": _flightlog_flight_3__crew.text,
      "flightlog_flight_3__pax_fwd": _flightlog_flight_3__pax_fwd.text,
      "flightlog_flight_3__pax_aft": _flightlog_flight_3__pax_aft.text,
      "flightlog_flight_3__baggage_cargo": _flightlog_flight_3__baggage_cargo.text,
      "flightlog_flight_3__fuel_on_dep": _flightlog_flight_3__fuel_on_dep.text,
      "flightlog_flight_3__take_of_weight": _flightlog_flight_3__take_of_weight.text,
      "flightlog_flight_3__cof_g": _flightlog_flight_3__cof_g.text,
      "flightlog_flight_3__lmc___pax": _flightlog_flight_3__lmc___pax.text,
      "flightlog_flight_3__lmc___cargo": _flightlog_flight_3__lmc___cargo.text,
      "flightlog_flight_3__lmc___tow": _flightlog_flight_3__lmc___tow.text,
      "flightlog_flight_3__burn_rate": _flightlog_flight_3__burn_rate.text,
      "flightlog_flight_3__landing_fuel": _flightlog_flight_3__landing_fuel.text,
      "flightlog_flight_3__consumption": _flightlog_flight_3__consumption.text,
      "flightlog_flight_3__fuel_uplift": _flightlog_flight_3__fuel_uplift.text,
      "flightlog_flight_3__take_off_time": _flightlog_flight_3__take_off_time.text,
      "flightlog_flight_3__landing_time": _flightlog_flight_3__landing_time.text,
      "flightlog_flight_3__act_fit_time": _flightlog_flight_3__act_fit_time.text,
      "flightlog_flight_3__w_b_in_limits_pilot_initials" : _flightlog_flight_3__w_b_in_limits_pilot_initials,
      "flightlog_flight_3__15_min_fuel_check1" : _flightlog_flight_3__15_min_fuel_check1,
      "flightlog_flight_3__15_min_fuel_check2" : _flightlog_flight_3__15_min_fuel_check2
    };

    var flight4 = {
      "flightlog_flight_4__from": _flightlog_flight_4__from.text,
      "flightlog_flight_4__to": _flightlog_flight_4__to.text,
      "flightlog_flight_4__dist": _flightlog_flight_4__dist.text,
      "flightlog_flight_4__gs": _flightlog_flight_4__gs.text,
      "flightlog_flight_4__est_fit_time": _flightlog_flight_4__est_fit_time.text,
      "flightlog_flight_4__est_fuel_req": _flightlog_flight_4__est_fuel_req.text,
      "flightlog_flight_4__empty_weight": _flightlog_flight_4__empty_weight.text,
      "flightlog_flight_4__crew": _flightlog_flight_4__crew.text,
      "flightlog_flight_4__pax_fwd": _flightlog_flight_4__pax_fwd.text,
      "flightlog_flight_4__pax_aft": _flightlog_flight_4__pax_aft.text,
      "flightlog_flight_4__baggage_cargo": _flightlog_flight_4__baggage_cargo.text,
      "flightlog_flight_4__fuel_on_dep": _flightlog_flight_4__fuel_on_dep.text,
      "flightlog_flight_4__take_of_weight": _flightlog_flight_4__take_of_weight.text,
      "flightlog_flight_4__cof_g": _flightlog_flight_4__cof_g.text,
      "flightlog_flight_4__lmc___pax": _flightlog_flight_4__lmc___pax.text,
      "flightlog_flight_4__lmc___cargo": _flightlog_flight_4__lmc___cargo.text,
      "flightlog_flight_4__lmc___tow": _flightlog_flight_4__lmc___tow.text,
      "flightlog_flight_4__burn_rate": _flightlog_flight_4__burn_rate.text,
      "flightlog_flight_4__landing_fuel": _flightlog_flight_4__landing_fuel.text,
      "flightlog_flight_4__consumption": _flightlog_flight_4__consumption.text,
      "flightlog_flight_4__fuel_uplift": _flightlog_flight_4__fuel_uplift.text,
      "flightlog_flight_4__take_off_time": _flightlog_flight_4__take_off_time.text,
      "flightlog_flight_4__landing_time": _flightlog_flight_4__landing_time.text,
      "flightlog_flight_4__act_fit_time": _flightlog_flight_4__act_fit_time.text,
      "flightlog_flight_4__w_b_in_limits_pilot_initials" : _flightlog_flight_4__w_b_in_limits_pilot_initials,
      "flightlog_flight_4__15_min_fuel_check1" : _flightlog_flight_4__15_min_fuel_check1,
      "flightlog_flight_4__15_min_fuel_check2" : _flightlog_flight_4__15_min_fuel_check2
    };


    if (selectedCustomer == 'OTHER CUSTOMERS') {
      nameofCustomer = otherCustomerController.text;
    } else {
      nameofCustomer = selectedCustomer;
    }


    var data = {
      "customer": nameofCustomer,
      "aircraft": aircraft,
      "flightplan":flightplan,
      "flightlog": {
        "flight1": flight1,
        "flight1_status": flight1_status,
        "flight2": flight2,
        "flight2_status": flight2_status,
        "flight3": flight3,
        "flight3_status": flight3_status,
        "flight4": flight4,
        "flight4_status": flight3_status,
      },
      "comments":  _comments.text,
      "total_flt_time":_total_flt_time.text,

    };


    try {
      var response = await http.Client().post(
        Uri.parse(
            "${AppUrls.formdata}?formid=$formId&formrefno=$commercial_flight_report_refno"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $userToken"
        },
        body: jsonEncode({
          "data": data,
          "status":status
        }),
      );

      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        final responseData = json.decode(response.body);
        print(responseData);

        EasyLoading.showSuccess("Saved");

        if (status == 'completed'){
          formdata_pass_backend(UserID, userToken);
        }

        // if (status == 'extension') {
        //   EasyLoading.showSuccess("Extension form added successfully");
        // }
        // if (status == 'reduced') {
        //   EasyLoading.showSuccess("Reduced form Added successfully");
        // }

        // formdata_pass_backend(UserID, userToken);
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
