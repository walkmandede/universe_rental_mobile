// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'dart:async';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:universe_rental/constants/app_functions.dart';
import 'package:universe_rental/modules/_common/models/m_listing_detail.dart';
import 'package:universe_rental/modules/home/listing_detail/v_listing_detail_page.dart';
import 'package:universe_rental/services/network_services/api_end_points.dart';
import 'package:universe_rental/services/network_services/api_service.dart';

class ListingSearchController extends GetxController with GetTickerProviderStateMixin{

  int animationDurationInMs = 200;
  Map<String,AnimationController> dataAnimations = {};
  Timer? timer;
  TextEditingController txtSearch = TextEditingController(text: "");
  ValueNotifier<List<ListingDetail>> shownData = ValueNotifier([]);

  @override
  void onInit() {
    initLoad();
    super.onInit();
  }

  @override
  void onClose() {
    if(timer!=null)timer!.cancel();
    super.onClose();
  }

  Future<void> initLoad() async{
    txtSearch.addListener(() {
      onSearch();
    });
  }

  Future<void> onSearch() async{
    if(timer!=null){
      timer!.cancel();
      resetTimer();
    }
    else{
      resetTimer();
    }
  }

  void resetTimer(){
    timer  = Timer(
      const Duration(milliseconds: 2000), () {
        updateShownListing();
      },
    );
  }

  Future<void> updateShownListing() async{
    final searchText = txtSearch.text;
    shownData.value.clear();
    shownData.notifyListeners();
    try{
      final response = await ApiService().get(
        endPoint: "${ApiEndPoints.getSearchList}?query=$searchText"
      );
      final apiResponse = ApiService().validateResponse(
        response: response
      );
      if(apiResponse.xSuccess){
        Iterable iterable = apiResponse.bodyData["_data"]??[];
        for(final each in iterable){
          final eachListing = ListingDetail.fromSearch(data: each);
          shownData.value.add(eachListing);
        }
        superPrint(iterable);
      }

    }
    catch(e){
      superPrint(e);
      null;
    }
    shownData.notifyListeners();
  }

  void onClickEachResult({required ListingDetail listingDetail}){

    Get.to(
      ()=> ListingDetailPage(id: listingDetail.id, images: listingDetail.imageList, imageShownIndex: 0),
      transition: Transition.downToUp
    );

  }

}


