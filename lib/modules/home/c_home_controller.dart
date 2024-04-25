// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:universe_rental/constants/app_functions.dart';
import 'package:universe_rental/modules/_common/controllers/c_data_controller.dart';
import 'package:universe_rental/modules/home/explore/c_explore_controller.dart';
import 'package:universe_rental/modules/home/explore/sub_widgets/header/c_explore_header_controller.dart';

import '../_common/models/m_listing_tag.dart';

class HomeController extends GetxController{

  ValueNotifier<double> naviBarAnimatedValue = ValueNotifier(1);
  ValueNotifier<int> currentPage = ValueNotifier(0);
  ValueNotifier<bool> xLoading = ValueNotifier(false);

  @override
  void onInit() {
    initLoad();
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
    xLoading.value = true;
    xLoading.notifyListeners();
    try{
      final exploreController = Get.put(ExploreHeaderController());
      DataController dataController  = Get.find();
      await dataController.fetchListingTags();
      if(dataController.allListingTags.value.isNotEmpty){
        exploreController.updateSelectedTag(listingTag: dataController.allListingTags.value.first);
      }
    }
    catch(e){
      superPrint(e);
      null;
    }
    xLoading.value = false;
    xLoading.notifyListeners();
  }

  void onClickChangePage({required int pageIndex}){
    currentPage.value = pageIndex;
    currentPage.notifyListeners();
  }

}