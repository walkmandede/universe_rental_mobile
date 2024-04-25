import 'package:get/get.dart';
import 'package:flutter/material.dart';

class WhereToController extends GetxController with GetTickerProviderStateMixin{

  int animationDurationInMs = 200;

  @override
  void onInit() {
    initLoad();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> initLoad() async{

  }

}


