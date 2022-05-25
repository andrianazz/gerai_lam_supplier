import 'package:flutter/material.dart';

import '../theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushNamed(context, '/getstarted');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          background(),
          title(),
        ],
      ),
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

  Widget title() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 60,
          height: 70,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/supply_logo.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 25),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                text: 'Gerai ',
                style: primaryText.copyWith(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: 'LAM',
                    style: primaryText.copyWith(
                      color: orangeColor,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "Supplier",
              style: primaryText.copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 7,
              ),
            )
          ],
        )
      ],
    );
  }
}
