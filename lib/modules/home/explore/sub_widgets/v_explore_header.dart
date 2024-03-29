import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ExploreHeader extends StatelessWidget {
  const ExploreHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final baseHeaderHeight = Get.height * 0.2;
    return Container(
      width: double.infinity,
      height: baseHeaderHeight,
      decoration: const BoxDecoration(
        color: Colors.blue
      ),
    );
  }
}
