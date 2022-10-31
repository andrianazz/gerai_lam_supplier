import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gerai_lam_supplier/pages/getstarted_page.dart';
import 'package:gerai_lam_supplier/pages/login_page.dart';
import 'package:gerai_lam_supplier/pages/main_page.dart';
import 'package:gerai_lam_supplier/pages/splash_page.dart';
import 'package:gerai_lam_supplier/pages/upload_photo_page.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xffFFF59E),
      systemNavigationBarColor: Colors.black,
      statusBarIconBrightness: Brightness.dark,
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
