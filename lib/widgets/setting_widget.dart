import 'package:flutter/material.dart';

import '../theme.dart';

class SettingWidget extends StatelessWidget {
  Function? onTap;
  String? name;
  String? icon;
  SettingWidget({Key? key, this.onTap, this.name, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
        width: double.infinity,
        height: 75,
        margin: const EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 53,
                  height: 53,
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Image.asset(
                      icon!,
                      width: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    name!,
                    style: primaryText.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: primaryColor,
                  size: 14,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 2,
              color: const Color(0xffF2F3F2),
            )
          ],
        ),
      ),
    );
  }
}
