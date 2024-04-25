// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member


import 'dart:math';

import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe_rental/modules/home/c_home_controller.dart';
import 'package:universe_rental/services/network_services/api_end_points.dart';
import 'package:universe_rental/services/network_services/api_service.dart';

import '../../../constants/app_functions.dart';

class ExploreController extends GetxController with GetSingleTickerProviderStateMixin{

  double listingPanelHeight = 0.95;
  double headerBarHeight = 0.175;

  ValueNotifier<bool> xUpdatingShownList = ValueNotifier(false);
  HomeController homeController = Get.find();
  DraggableScrollableController draggableScrollableController = DraggableScrollableController();

  @override
  void onInit() {
    super.onInit();
    initLoad();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  Future<void> initLoad() async{
    draggableScrollableController.addListener(() {
      final pixels = draggableScrollableController.pixels;
      final size = draggableScrollableController.pixelsToSize(pixels);
      //y=1.6667x−0.16667
      final y = (1.6667*size) - 0.16667;
      homeController.naviBarAnimatedValue.value = min(1, y);
    });
  }

  double getListingHeaderHeightPortion(){
    return (headerBarHeight - (1-listingPanelHeight));
  }

  Future<void> updateShownListing() async{
    xUpdatingShownList.value = true;
    xUpdatingShownList.notifyListeners();
    try{
      final response = await ApiService().get(
        endPoint: "${ApiEndPoints.getTags}"
      );
    }
    catch(e){
      null;
    }
    xUpdatingShownList.value = false;
    xUpdatingShownList.notifyListeners();
  }

}