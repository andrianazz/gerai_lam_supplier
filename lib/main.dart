import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gerai_lam_supplier/pages/getstarted_page.dart';
import 'package:gerai_lam_supplier/pages/login_page.dart';
import 'package:gerai_lam_supplier/pages/main_page.dart';
import 'package:gerai_lam_supplier/pages/sign_up_page.dart';
import 'package:gerai_lam_supplier/pages/splash_page.dart';
import 'package:gerai_lam_supplier/pages/upload_photo_page.dart';
import 'package:gerai_lam_supplier/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: primaryColor,
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/mainPage': (context) => MainPage(),
        '/loginPage': (context) => LoginPage(),
        '/getstarted': (context) => const GetStartedPage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/uploadPhoto': (context) => const UploadPhotoPage(),
      },
      home: SplashPage(),
    );
  }
}
