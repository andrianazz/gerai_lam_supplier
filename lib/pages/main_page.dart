import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gerai_lam_supplier/pages/catalog_page.dart';
import 'package:gerai_lam_supplier/pages/profile_page.dart';
import 'package:gerai_lam_supplier/pages/sales_page.dart';
import 'package:gerai_lam_supplier/pages/stock_page.dart';
import 'package:gerai_lam_supplier/services/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;

import '../theme.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    NotificationService.init();
    tz.initializeTimeZones();
    getPref();
  }

  String imageUrl = '';
  String name = '';
  String id = '';

  Future<void> getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? imageString = pref.getString("imageUrl");
    String? nameString = pref.getString("name");
    String? idString = pref.getString("id");

    setState(() {
      imageUrl = imageString!;
      name = nameString!;
      id = idString!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        body: SizedBox.expand(
          child: PageView(
            onPageChanged: (index) {
              setState(() => _selectedIndex = index);
            },
            controller: _pageController,
            children: [
              CatalogPage(),
              StockPage(),
              SalesPage(),
              ProfilePage(),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavyBar(
          iconSize: 24,
          showElevation: false,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          containerHeight: 70,
          selectedIndex: _selectedIndex,
          onItemSelected: (index) => setState(() {
            _selectedIndex = index;
            _pageController.animateToPage(index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease);
          }),
          items: [
            BottomNavyBarItem(
              icon: Image.asset('assets/home.png', width: 24),
              title: const Text('Home'),
              activeColor: Colors.black,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Image.asset('assets/income_icon.png', width: 24),
              title: const Text('Stock'),
              activeColor: Colors.black,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Image.asset('assets/delivery_icon.png', width: 24),
              title: const Text('Penjualan'),
              activeColor: Colors.black,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Image.asset('assets/profile.png', width: 24),
              title: const Text('Profile'),
              activeColor: Colors.black,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
          //show confirm dialogue
          //the return value will be from "Yes" or "No" options
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Keluar Aplikasi'),
            content: Text('Apakah anda ingin keluar dari Aplikasi?'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                ),
                //return false when click on "NO"
                child: Text('Tidak'),
              ),
              ElevatedButton(
                onPressed: () {
                  CollectionReference products =
                      firestore.collection("product");

                  products
                      .where("sisa_stok", isLessThanOrEqualTo: 5)
                      .get()
                      .then((value) => value.docs
                              .where(
                                  (element) => element['supplier']['id'] == id)
                              .map((e) {
                            Map<String, dynamic> product =
                                e.data() as Map<String, dynamic>;

                            NotificationService.showNotificationScheduled(
                                title: "Halo, ${name}",
                                body:
                                    "${product['nama'].toString()} hanya tersisa ${product['sisa_stok']} stok lagi. Silahkan hubungi Pengelola Toko",
                                scheduleTime:
                                    DateTime.now().add(Duration(seconds: 3)));
                          }).toList());

                  Navigator.of(context).pop(true);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: redColor,
                ),
                //return true when click on "Yes"
                child: Text('Keluar'),
              ),
            ],
          ),
        ) ??
        false; //if showDialouge had returned null, then return false
  }
}
