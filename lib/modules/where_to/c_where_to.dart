import 'package:get/get.dart';
import 'package:flutter/material.dart';

class WhereToController extends GetxController with GetTickerProviderStateMixin{

  AnimationController? card1Controller;
  AnimationController? card2Controller;
  int animationDurationInMs = 200;

  @override
  void onInit() {
    initLoad();
    super.onInit();
  }

  @override
  void onClose() {
    if(card1Controller!=null){
      card1Controller!.dispose();
    }
    if(card2Controller!=null){
      card2Controller!.dispose();
    }
    super.onClose();
  }

  Future<void> initLoad() async{
    card1Controller = AnimationController(vsync: this,duration: Duration(milliseconds: animationDurationInMs));
    card2Controller = AnimationController(vsync: this,duration: Duration(milliseconds: animationDurationInMs));


   card1Controller!.forward();
   await Future.delayed(Duration(milliseconds: (animationDurationInMs/2).ceil()));
   card2Controller!.forward();

  }

}


