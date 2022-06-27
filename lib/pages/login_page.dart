import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gerai_lam_supplier/pages/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;

import '../services/auth_service.dart';
import '../services/notification_service.dart';
import '../theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late SharedPreferences preferences;

  late AndroidNotificationChannel? channel;
  late FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isSecure = true;

  @override
  void initState() {
    super.initState();
    init();
    NotificationService.init();
    tz.initializeTimeZones();

    requestPermission();
    loadFCM();
    listenFCM();
    getToken();
  }

  void saveToken() async {
    CollectionReference tokens = firestore.collection("tokenFCM");
    SharedPreferences pref = await SharedPreferences.getInstance();

    String? email = pref.getString("email") ?? '';
    String? name = pref.getString("name") ?? '';
    String? tokenFCM = await FirebaseMessaging.instance.getToken();
    tokens.doc(email).set({'email': email, 'token': tokenFCM, 'name': name});
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) => print(token));
  }

  void requestPermission() async {
    FirebaseMessaging message = FirebaseMessaging.instance;

    NotificationSettings settings = await message.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User grant permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("user provisional");
    } else {
      print("Not ACCEPTED PERMISSION");
    }
  }

  void listenFCM() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin!.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel!.id,
              channel!.name,
              styleInformation: BigTextStyleInformation(''),
              icon: 'launch_background',
            ),
          ),
        );
      }
    });
  }

  void loadFCM() async {
    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.high,
        enableVibration: true,
      );

      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      await flutterLocalNotificationsPlugin
          ?.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel!);

      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  Future init() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else if (snapshot.hasData) {
          return MainPage();
        } else {
          return Scaffold(
            body: Stack(
              children: [
                background(),
                content(),
              ],
            ),
          );
        }
      },
    );
  }

  Widget background() {
    return SizedBox.expand(
      child: Image.asset(
        "assets/bg_splash2.png",
        fit: BoxFit.cover,
      ),
    );
  }

  Widget content() {
    return SafeArea(
      child: ListView(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_rounded,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 50),
                      child: Text(
                        "Masuk",
                        style: primaryText.copyWith(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: 160,
                      height: 250,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/login_illustration.png'),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                Text(
                  "No. Telepon",
                  style: primaryText.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    focusColor: const Color(0xfff2f2f2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    hintText: "Masukkan No Telepon...",
                    fillColor: const Color(0xfff2f2f2),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Password",
                  style: primaryText.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: passwordController,
                  obscureText: isSecure,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        isSecure ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          isSecure = !isSecure;
                        });
                      },
                    ),
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    focusColor: const Color(0xfff2f2f2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    hintText: "Masukkan Password",
                    fillColor: const Color(0xfff2f2f2),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    'Lupa Password?',
                    style: primaryText.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                const SizedBox(height: 50),
                Container(
                  height: 54,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      isSupplierPhone(phoneController.text.toString());
                    },
                    style: ElevatedButton.styleFrom(
                      primary: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Masuk",
                      style: primaryText.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  isSupplierPhone(String phone) {
    Map<String, dynamic> data = {};

    CollectionReference employees = firestore.collection('supplier');
    employees.where('phone', isEqualTo: phone).get().then((snapshot) {
      if (snapshot.docs.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Anda belum mendaftarkan diri!",
              textAlign: TextAlign.center,
            ),
            backgroundColor: redColor,
          ),
        );
      } else {
        data = snapshot.docs.first.data() as Map<String, dynamic>;
        print(data['email']);

        preferences.setString('name', data['name'].toString());
        preferences.setString('imageUrl', data['imageUrl'].toString());
        preferences.setString('id', data['id'].toString());
        preferences.setString('email', data['email'].toString());
        preferences.setString('phone', data['phone'].toString());
        preferences.setString('zone', data['zone'].toString());

        saveToken();

        return AuthService().signIn(
          context,
          data['email'].toString(),
          passwordController.text.trim(),
        );
      }

      if (data == null) {
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Anda belum mendaftarkan diri!",
              textAlign: TextAlign.center,
            ),
            backgroundColor: redColor,
          ),
        );
      }
    });
  }
}
