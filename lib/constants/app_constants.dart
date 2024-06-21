import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_colors.dart';

class AppConstants {
  static String baseRasterTileWhiteUrl =
      // "https://s.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png";
      "https://tile.openstreetmap.org/{z}/{x}/{y}.png";
      // "https://api.maptiler.com/maps/350b059e-93c6-428e-8a5a-da7f1cda974f/{z}/{x}/{y}.png?key=SD6Ev9Xf11MLip5FQDt5";
  // static String baseRasterTileWhiteUrl = "https://tile.openstreetmap.org/{z}/{x}/{y}.png";
  // static String baseRasterTileWhiteUrl = "https://cartodb-basemaps-{s}.global.ssl.fastly.net/light_all/{z}/{x}/{y}.png";

  static TextStyle defaultTextStyle = TextStyle(
      fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.black);

  static double basePadding = 20;
  static double baseBorderRadius = 10;
  static double baseBorderRadiusL = 16;
  static double baseBorderRadiusXL = 20;
  static double baseButtonHeightM = 50;
  static double baseButtonHeightL = 60;
  static double baseButtonHeightS = 40;

  static double fontSizeXXL = 22;
  static double fontSizeL = 18;
  static double fontSizeXL = 20;
  static double fontSizeM = 16;
  static double fontSizeMS = 14;
  static double fontSizeS = 12;
  static double fontSizeXS = 10;

  //
  static double baseNaviBarHeight = Get.height * 0.115;

  static OutlineInputBorder baseOutlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppConstants.baseBorderRadius),
    borderSide: BorderSide(
      color: AppColors.borderGrey,
      width: 1.2,
    ),
  );

  static double authBgTopImageRatio = 616 / 932;

  static int bsAnimateDurationInMs = 550;
}
