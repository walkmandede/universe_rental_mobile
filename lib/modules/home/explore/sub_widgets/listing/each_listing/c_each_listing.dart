// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe_rental/constants/app_functions.dart';
import 'package:universe_rental/modules/_common/models/m_listing_detail.dart';

class EachListingWidgetController extends GetxController{

  ListingDetail? listingDetail;
  ValueNotifier<int> currentShownImageIndex = ValueNotifier(0);
  PageController pageController = PageController(initialPage: 0,keepPage: true);

  @override
  void onInit() {
    //
    super.onInit();
  }

  @override
  void onClose() {
    //
    super.onClose();
  }

  Future<void> initLoad({required ListingDetail each}) async{
    if(listingDetail==null){
      listingDetail = each;
      null;
    }
  }

  void onPageChanged(int pageIndex){
    currentShownImageIndex.value = pageIndex;
    currentShownImageIndex.notifyListeners();
  }

  void movePage({required int pageIndex,required String id}){
    try{
      if(id == listingDetail!.id){
        pageController.jumpToPage(pageIndex);
      }
    }
    catch(e){
      null;
    }
  }

}
