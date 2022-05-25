import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:gerai_lam_supplier/pages/catalog_page.dart';

import '../theme.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          onPageChanged: (index) {
            setState(() => _selectedIndex = index);
          },
          controller: _pageController,
          children: const [
            CatalogPage(),
            Center(
              child: Text("Pemasukkan"),
            ),
            Center(
              child: Text("Pengeluaran"),
            ),
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
              duration: const Duration(milliseconds: 300), curve: Curves.ease);
        }),
        items: [
          BottomNavyBarItem(
            icon: Image.asset('assets/home.png', width: 24),
            title: const Text('Home'),
            activeColor: primaryColor,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Image.asset('assets/income_icon.png', width: 24),
            title: const Text('Income'),
            activeColor: primaryColor,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Image.asset('assets/delivery_icon.png', width: 24),
            title: const Text('Delivery'),
            activeColor: primaryColor,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
