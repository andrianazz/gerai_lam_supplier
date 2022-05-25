import 'package:flutter/material.dart';

import '../theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isSecure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          background(),
          content(),
        ],
      ),
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
                    color: Colors.white,
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
                          color: Colors.white,
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
                Container(
                  width: double.infinity,
                  child: Text(
                    'Lupa Password?',
                    style: primaryText.copyWith(
                      fontSize: 10,
                      color: primaryColor,
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
                    onPressed: () {},
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
                          color: Colors.white,
                          fontSize: 18),
                    ),
                  ),
                ),
                Container(
                  child: Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: Text(
                        "Tidak ada akun? DAFTAR",
                        style: primaryText.copyWith(
                          color: primaryColor,
                        ),
                      ),
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
}
