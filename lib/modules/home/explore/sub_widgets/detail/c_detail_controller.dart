import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:universe_rental/constants/app_functions.dart';

class DetailController extends GetxController
    with GetTickerProviderStateMixin {
  // ValueNotifier<double> shareBtn = ValueNotifier(0);
  // ValueNotifier<double> favBtn = ValueNotifier(0);
  // ValueNotifier<double> appBarBgColor = ValueNotifier(0);
  late AnimationController appbarAnimationController;
  int animationDurationInMs = 200;
  ScrollController scrollController = ScrollController();
  // ScrollController scrollController;
  @override
  void onInit() {
    initLoad();
    super.onInit();
  }

  @override
  void onClose() {
    appbarAnimationController.dispose();
    super.onClose();
  }

  initLoad() {
    appbarAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: animationDurationInMs));

    scrollController.addListener(() {
      final iH = Get.height * 0.3;
      final sV = scrollController.position.pixels;

      //
      if(sV<iH){
        superPrint('0');
        if(appbarAnimationController.value != 0){
          appbarAnimationController.reverse();
        }
      }
      else{
        superPrint('1');
        if(appbarAnimationController.value != 1){
          appbarAnimationController.forward();
        }
      }

    });
  }
}
