import 'package:flutter/material.dart';

import '../theme.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        background(),
        content(context),
      ]),
    );
  }

  Widget background() {
    return SizedBox.expand(
      child: Image.asset(
        "assets/bg_splash.png",
        fit: BoxFit.cover,
      ),
    );
  }

  Widget content(context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 270,
            height: 290,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/started_illustration.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 70),
          Text(
            "Aplikasi Toko adalah solusi untuk Grocery Belanja semua yang Anda butuhkan",
            style: primaryText.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              fixedSize: const Size(327, 52),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            child: Text(
              "Mulai",
              style: primaryText.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: primaryColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
