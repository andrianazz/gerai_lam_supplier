import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/notification_service.dart';
import 'package:timezone/data/latest.dart' as tz;

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String imageUrl = '';
  String name = '';
  String id = '';

  Future<void> getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? imageString = pref.getString("imageUrl") ?? "";
    String? nameString = pref.getString("name") ?? "";
    String? idString = pref.getString("id") ?? "";

    setState(() {
      imageUrl = imageString;
      name = nameString;
      id = idString;
    });
  }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/login',
        (Route<dynamic> route) => false,
      );
    });
    getPref();

    CollectionReference products = firestore.collection("product");

    products.where("sisa_stok", isLessThanOrEqualTo: 5).get().then((value) =>
        value.docs.where((element) => element['supplier']['id'] == id).map((e) {
          Map<String, dynamic> product = e.data() as Map<String, dynamic>;

          NotificationService.showNotification(
            title: "Halo, ${name}",
            body:
                "${product['nama'].toString()} hanya tersisa ${product['sisa_stok']} stok lagi. Silahkan hubungi Pengelola Toko",
          );
        }).toList());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Hero(
          tag: 'logo1',
          child: Image.asset(
            "assets/splash_screen.png",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
