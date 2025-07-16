import 'dart:async';
import 'package:falcon_aviation/utils/app_font.dart';
import 'package:falcon_aviation/view/screen/home/home_screen.dart';
import 'package:falcon_aviation/view/screen/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:falcon_aviation/utils/app_color.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/app_sp.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  String userToken = "";

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () async {
      bool val = await AppSp().getIsLogged();
      if (val) {

        Navigator.push( context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/img/splash.png',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Center(
                child: Image.asset(
                  'assets/logo/logo-white.png',
                  width: 220,
                  height: 220,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: Text(
                  'FALCON',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: AppFont.OutfitFont,
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
