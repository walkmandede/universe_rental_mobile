import 'dart:math';

import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe_rental/modules/home/c_home_controller.dart';

import '../../../constants/app_functions.dart';

class ExploreController extends GetxController with GetSingleTickerProviderStateMixin{

  ValueNotifier<bool> xLoaded = ValueNotifier(false);
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
    xLoaded.value = true;
    xLoaded.notifyListeners();
    superPrint("initloaded");
  }

}