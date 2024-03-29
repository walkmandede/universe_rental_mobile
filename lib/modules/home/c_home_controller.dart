import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:universe_rental/constants/app_functions.dart';

class HomeController extends GetxController{
  ValueNotifier<double> naviBarAnimatedValue = ValueNotifier(1);
  PageController pageController = PageController();
  ValueNotifier<int> currentPage = ValueNotifier(0);

  @override
  void onInit() {
    // TODO: implement onInit
    naviBarAnimatedValue.addListener(() {
      superPrint(naviBarAnimatedValue.value,title: "Navibar / y");
    });
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  Future<void> initLoad() async{

  }

}