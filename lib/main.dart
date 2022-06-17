import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gerai_lam_supplier/pages/getstarted_page.dart';
import 'package:gerai_lam_supplier/pages/login_page.dart';
import 'package:gerai_lam_supplier/pages/main_page.dart';
import 'package:gerai_lam_supplier/pages/splash_page.dart';
import 'package:gerai_lam_supplier/pages/upload_photo_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xffFFF59E),
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/mainPage': (context) => MainPage(),
        '/loginPage': (context) => LoginPage(),
        '/getstarted': (context) => const GetStartedPage(),
        '/login': (context) => const LoginPage(),
        '/uploadPhoto': (context) => const UploadPhotoPage(),
      },
      home: SplashPage(),
    );
  }
}
