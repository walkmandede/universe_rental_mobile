import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:universe_rental/constants/app_assets.dart';
import 'package:universe_rental/constants/app_colors.dart';

class VSettingPage extends StatelessWidget {
  const VSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        backgroundColor: AppColors.borderGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets.dummyProfile,
              width: Get.width * 0.7,
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
            ),
            const Text(
              "Last Updated Date 08-05-2024    09:30 am",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
