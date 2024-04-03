import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:universe_rental/constants/app_functions.dart';

class ExploreHeaderController extends GetxController {
  List<String> tags = [
    "Lakefront",
    "OMG!",
    "Amazing Views",
    "Containers",
    // "Eclare",
    // "Fotro",
    // "Morafa",
    // "Wlice",
    // "Sea Warfare",
    // "Titanium Mega",
    // "Glassmorphism",
    // "David Backghem",
    // "No",
    // "David Silva",
  ];

  List<IconData> icons = [
    TablerIcons.sailboat_2,
    TablerIcons.window,
    TablerIcons.chair_director,
    TablerIcons.package
  ];
  Map<String, Size> eachTagSize = {};
  ScrollController scrollController = ScrollController();
  ValueNotifier<double> scrollPositionInPotion = ValueNotifier(0);
  ValueNotifier<int> currentTabIndex = ValueNotifier(0);

  @override
  void onInit() {
    initLoad();
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> initLoad() async {
    await Future.delayed(const Duration(milliseconds: 10));
    double totalTagsLineSize = 0;
    for (var element in eachTagSize.values) {
      totalTagsLineSize = totalTagsLineSize + element.width;
    }
    final toAddValue =
        totalTagsLineSize - scrollController.position.maxScrollExtent;
    scrollController.addListener(() {
      final maxExtent = scrollController.position.maxScrollExtent;
      final scrolledPix = scrollController.position.pixels;
      final scrolledPortion = scrolledPix / maxExtent;
      final pix = scrolledPix + (toAddValue * scrolledPortion);
      final pixPortion = pix / totalTagsLineSize;
      scrollPositionInPotion.value = pixPortion;
      scrollPositionInPotion.notifyListeners();
    });
  }
}
