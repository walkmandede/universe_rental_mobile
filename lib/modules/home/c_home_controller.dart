import 'package:flutter/cupertino.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HomeController extends GetxController {
  ValueNotifier<double> naviBarAnimatedValue = ValueNotifier(1);
  PageController pageController = PageController();
  ValueNotifier<int> currentPage = ValueNotifier(0);
  List<IconData> naviIcon = [
    TablerIcons.brand_safari,
    TablerIcons.heart,
    TablerIcons.receipt,
    TablerIcons.message_dots
  ];
  List<String> naviLabel = ["Browse", "Favourite", "Lists", "Chat"];
  @override
  void onInit() {
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

  Future<void> initLoad() async {}
}
