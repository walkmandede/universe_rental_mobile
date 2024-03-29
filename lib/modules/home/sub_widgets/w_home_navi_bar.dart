import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe_rental/constants/app_colors.dart';
import 'package:universe_rental/constants/app_constants.dart';
import 'package:universe_rental/constants/app_constants.dart';
import 'package:universe_rental/modules/home/c_home_controller.dart';

class HomeNaviBar extends StatelessWidget {
  const HomeNaviBar({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find();
    return ValueListenableBuilder(
      valueListenable: controller.naviBarAnimatedValue,
      builder: (context, naviBarAnimatedValue, child) {
        if(naviBarAnimatedValue>0){
          return Container(
            color: Colors.white,
            height: AppConstants.baseNaviBarHeight * (naviBarAnimatedValue),
            child: Opacity(
              opacity: naviBarAnimatedValue,
              child: FittedBox(
                child: Container(
                  width: Get.width,
                  height: AppConstants.baseNaviBarHeight * (naviBarAnimatedValue),
                  decoration: BoxDecoration(
                    color: AppColors.red,
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(5, (index) {
                      return Expanded(
                        child: TextButton(
                          onPressed: () {
                            controller.pageController.animateToPage(index, duration: const Duration(milliseconds: 450), curve: Curves.linear);
                          },
                          child: Text(index.toString()),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          );
        }
        else{
          return const SizedBox.shrink();
        }
      },
    );
  }
}
