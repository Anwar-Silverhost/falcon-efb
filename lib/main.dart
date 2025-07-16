import 'package:falcon_aviation/utils/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,

        // route
        onGenerateRoute: onGenerateRoute,
        initialRoute: '/splash',
        builder: EasyLoading.init()
    );
  }
}

