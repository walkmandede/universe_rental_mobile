import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universe_rental/constants/app_colors.dart';
import 'package:universe_rental/constants/app_constants.dart';
import 'package:universe_rental/constants/app_constants.dart';
import 'package:universe_rental/constants/app_functions.dart';
import 'package:universe_rental/constants/app_svgs.dart';
import 'package:universe_rental/modules/_common/widgets/w_fitted_widget.dart';
import 'package:universe_rental/modules/home/c_home_controller.dart';
import 'package:universe_rental/services/others/extensions.dart';

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
            height: AppConstants.baseNaviBarHeight * (naviBarAnimatedValue),
            width: double.infinity,
            padding: EdgeInsets.only(
              bottom: Get.mediaQuery.padding.bottom,
              left: AppConstants.basePadding,
              right: AppConstants.basePadding
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.grey.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 20,
                  offset: const Offset(0,-10)
                )
              ]
            ),
            child: Opacity(
              opacity: naviBarAnimatedValue,
              child: ValueListenableBuilder(
                valueListenable: controller.currentPage,
                builder: (context, currentPage, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(4, (pageIndex) {
                      String iconSvg = "";
                      String label = "";
                      final bool xSelected = currentPage == pageIndex;
                      //todo each Navi Bar Item

                      switch(pageIndex){
                        case 0 :
                          iconSvg = AppSvgs.browse;
                          label = "Browse";
                          break;
                        case 1 :
                          iconSvg = AppSvgs.favorite;
                          label = "Favorite";
                          break;
                        case 2 :
                          iconSvg = AppSvgs.list;
                          label = "Lists";
                          break;
                        case 3 :
                          iconSvg = AppSvgs.chat;
                          label = "Chat";
                          break;
                      }

                      return Expanded(
                          child: LayoutBuilder(
                            builder: (a1, c1) {
                              return GestureDetector(
                                onTap: () {
                                  vibrateNow();
                                  controller.onClickChangePage(pageIndex: pageIndex);
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: const BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  padding: EdgeInsets.only(
                                      left: c1.maxWidth * 0.1,
                                      right: c1.maxWidth * 0.1,
                                      top: c1.maxHeight * 0.25
                                  ),
                                  child: FittedWidget(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.string(
                                          iconSvg,
                                          // colorFilter: ColorFilter.mode(xSelected?AppColors.black:AppColors.grey, BlendMode.srcIn),
                                          color: xSelected?AppColors.black:AppColors.iconGrey,
                                        ),
                                        (c1.maxHeight * 0.05).heightBox(),
                                        Text(
                                          label,
                                          style: TextStyle(
                                            fontSize: AppConstants.fontSizeMS,
                                            fontWeight: FontWeight.w600,
                                            color: xSelected?AppColors.black:AppColors.grey
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                      );
                    }),
                  );
                },
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
