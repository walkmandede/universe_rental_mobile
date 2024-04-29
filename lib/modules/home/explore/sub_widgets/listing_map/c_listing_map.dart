
// ignore_for_file: deprecated_member_use, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:universe_rental/constants/app_functions.dart';
import 'package:universe_rental/modules/_common/models/m_listing_detail.dart';
import 'package:universe_rental/modules/home/explore/sub_widgets/header/c_explore_header_controller.dart';
import 'package:universe_rental/services/network_services/api_end_points.dart';
import 'package:universe_rental/services/network_services/api_service.dart';

class ListingMapController extends GetxController{

  Timer? timer;
  MapController mapController = MapController();
  ValueNotifier<List<ListingDetail>> shownData = ValueNotifier([]);
  ValueNotifier<bool> xFetching = ValueNotifier(false);
  final double baseMarkerWidth = Get.width *0.25;

  @override
  void onInit() {
    initLoad();
    super.onInit();
  }

  @override
  void onClose() {
    if(timer!=null){
      timer!.cancel();
    }
    super.onClose();
  }

  Future<void> initLoad() async{
  }

  Future<void> onMapMove() async{
    if(timer!=null){
      timer!.cancel();
      resetTimer();
    }
    else{
      resetTimer();
    }
  }

  void resetTimer(){
    timer = Timer(const Duration(milliseconds: 650), () async{
      updateData();
    });
  }

  Future<void> updateData() async{
    shownData.value.clear();
    shownData.notifyListeners();
    xFetching.value = true;
    ExploreHeaderController exploreHeaderController = Get.find();
    try{
      final topLeft = mapController.bounds!.northWest;
      final botRight = mapController.bounds!.southEast;
      final response = await ApiService().get(
          endPoint: "${ApiEndPoints.getLocationListings}"
              "?topLeftLat=${topLeft.latitude}"
              "&topLeftLng=${topLeft.longitude}"
              "&bottomRightLat=${botRight.latitude}"
              "&bottomRightLng=${botRight.longitude}"
              "&tagId=${exploreHeaderController.selectedTag.value!.id}"
      );
      final apiResponse = ApiService().validateResponse(response: response);

      if(apiResponse.xSuccess){
        Iterable iterable = apiResponse.bodyData["_data"]??[];
        for(final each in iterable){
          final listing = ListingDetail.fromLocation(data: each);
          shownData.value.add(listing);
        }
        shownData.notifyListeners();
      }
    }
    catch(e){
      null;
    }

    xFetching.value = false;
  }

}
