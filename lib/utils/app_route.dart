import 'package:falcon_aviation/view/screen/file_manager/file_manager.dart';
import 'package:falcon_aviation/view/screen/file_manager/view_pdf.dart';
import 'package:falcon_aviation/view/screen/forms/form_list/aircraft_search_checklist.dart';
import 'package:falcon_aviation/view/screen/forms/form_list/rotary_wing_flight_plan_envelope.dart';
import 'package:falcon_aviation/view/screen/forms/forms.dart';
import 'package:falcon_aviation/view/screen/home/home_screen.dart';
import 'package:falcon_aviation/view/screen/login/login_screen.dart';
import 'package:falcon_aviation/view/screen/profile/edit_profile_screen.dart';
import 'package:falcon_aviation/view/screen/profile/profile_screen.dart';
import 'package:flutter/cupertino.dart';

import '../view/screen/forms/form_list/commercial_flight_record.dart';
import '../view/screen/forms/form_list/discretion_report.dart';
import '../view/screen/forms/form_list/operational_flight_plan.dart';
import '../view/screen/forms/form_list/rotary_wing_journey_log.dart';
import '../view/screen/forms/form_list/signature_file.dart';
import '../view/screen/splash/splash_screen.dart';

Route onGenerateRoute(RouteSettings settings) {
  Route page = CupertinoPageRoute(
    builder: (context) => SplashPage(),
  );
  switch (settings.name) {
    case "/splash":
      page = CupertinoPageRoute(
        builder: (context) => SplashPage(),
      );
      break;
    case "/login":
      page = CupertinoPageRoute(
        builder: (context) => LoginScreen(),
      );
      break;
    case "/home":
      page = CupertinoPageRoute(
        builder: (context) => HomeScreen(),
      );
      break;
    case "/profile":
      page = CupertinoPageRoute(
        builder: (context) => ProfileScreen(),
      );
      break;

    case "/edit_profile":
      page = CupertinoPageRoute(
        builder: (context) => EditProfileScreen(),
      );
      break;

    case "/file_manager":
      page = CupertinoPageRoute(
        builder: (context) => FileManager(),
      );
      break;

    case "/view_pdf":
      page = CupertinoPageRoute(
        builder: (context) => ViewPdf(
          pdfPath: '',
          pdfName: '',
        ),
      );
      break;

    //Module 2
    case "/forms":
      page = CupertinoPageRoute(
        builder: (context) => const Forms(),
      );
      break;

    case "/aircraftsearchchecklist":
      page = CupertinoPageRoute(
        builder: (context) => const AircraftSearchChecklist(),
      );
      break;

    case "/rotarywingjourneylog":
      page = CupertinoPageRoute(
        builder: (context) => const RotaryWingJourneyLog(),
      );
      break;

    case "/operationalflightplan":
      page = CupertinoPageRoute(
        builder: (context) => const OperationalFlightPlan(),
      );
      break;

    case "/commercialflightrecord":
      page = CupertinoPageRoute(
        builder: (context) => const CommercialFlightRecord(),
      );
      break;

    case "/discretionreport":
      page = CupertinoPageRoute(
        builder: (context) => const DiscretionReport(),
      );
      break;

    case "/rotarywingflightplanenvelope":
      page = CupertinoPageRoute(
        builder: (context) => const RotaryWingFlightPlanEnvelope(),
      );
      break;
    case "/signaturefile":
      page = CupertinoPageRoute(
        builder: (context) => const SignatureFile(),
      );
      break;



  // case "/onboard":
    //   page = CupertinoPageRoute(
    //     builder: (context) => Onbording(),
    //   );
    //   break;
  }
  return page;
}
