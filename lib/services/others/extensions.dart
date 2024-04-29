import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:universe_rental/services/network_services/api_service.dart';
import '../../constants/app_assets.dart';
import '../../constants/app_functions.dart';

extension CustomBox on double {
  Widget widthBox() {
    return SizedBox(
      width: this,
    );
  }

  Widget heightBox() {
    return SizedBox(
      height: this,
    );
  }

  Widget scalableHeightBox() {
    return SizedBox(
      height: this * getScreenScaleFactor(),
    );
  }

  Widget logo(){
    return Image.asset(AppAssets.logo,width: this,height: this,fit: BoxFit.contain,);
  }

  Widget networkImage({required String imageUrl,double borderRadius = 0}){
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: this,
        height: this,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) {
          return logo();
        },
      ),
    );
  }

}

extension CustomBox2 on int {
  Widget widthBox() {
    return SizedBox(
      width: toDouble(),
    );
  }

  Widget heightBox() {
    return SizedBox(
      height: toDouble(),
    );
  }

  Widget heightBoxWithScale() {
    return SizedBox(
      height: this * getScreenScaleFactor(),
    );
  }

  Widget widthBoxWithScale() {
    return SizedBox(
      width: this * getScreenScaleFactor(),
    );
  }
}

extension CustomDateTime on DateTime{

  String getDateKey(){
    return toString().substring(0,10);
  }

}

extension ServerImage on String{


  String getServerPath(){
    return ApiService().baseUrl.replaceAll("/api/v1/", "") + toString();
  }

}

extension CustomList on List{

  String getCSV(){
    return toString().replaceAll("[", "").replaceAll("]", "").removeAllWhitespace;
  }

}