// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe_rental/constants/app_functions.dart';
import 'package:universe_rental/modules/_common/controllers/c_data_controller.dart';
import 'package:universe_rental/modules/_common/models/m_listing_detail.dart';
import 'package:universe_rental/services/network_services/api_end_points.dart';
import 'package:universe_rental/services/network_services/api_service.dart';
import 'package:universe_rental/services/others/extensions.dart';

class FavoriteController extends GetxController{

  ValueNotifier<bool> xLoading = ValueNotifier(false);
  ValueNotifier<List<ListingDetail>> shownData = ValueNotifier([]);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future<void> updateData() async{
    xLoading.value = true;
    shownData.value.clear();
    shownData.notifyListeners();
    try{
      DataController dataController = Get.find();
      await dataController.updateSpFavorites();
      final ids = dataController.favoriteListingIds.value;

      if(ids.isNotEmpty){
        final query = ids.getCSV();
        superPrint(query);
        final response = await ApiService().get(
          endPoint: "${ApiEndPoints.getFavorites}?ids=$query"
        );
        final apiResponse = ApiService().validateResponse(response: response);
        if(apiResponse.xSuccess){
          Iterable iterable = apiResponse.bodyData["_data"]??[];
          for(final each in iterable){
            final listingDetail = ListingDetail.fromResponse2(data: each);
            shownData.value.add(listingDetail);
          }
          shownData.notifyListeners();
        }
        else{

        }
      }

    }
    catch(e){
      null;
    }
    xLoading.value = false;
  }

}