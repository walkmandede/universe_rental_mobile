import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe_rental/services/network_services/api_end_points.dart';
import 'package:universe_rental/services/network_services/api_service.dart';
import 'package:universe_rental/services/overlays_services/dialog/dialog_service.dart';
import 'package:universe_rental/web_data_entry/all_listings/m_listing_model.dart';

class ListingDetailController extends GetxController {
  ValueNotifier<int> currentShownPageIndex = ValueNotifier(0);
  ValueNotifier<ListingModel?> listingData = ValueNotifier(null);
  @override
  void onInit() {
    //
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future<void> initLoad(
      {required String id, required int shownPageIndex}) async {
    currentShownPageIndex.value = shownPageIndex;
  }

  void onPageChanged(int index) {
    currentShownPageIndex.value = index;
  }

  Future<void> getListingData(String id) async {
    Response? response = await ApiService()
        .get(endPoint: "${ApiEndPoints.dataEntryListing}/$id");

    final apiResponse = ApiService().validateResponse(response: response);

    if (apiResponse.xSuccess) {
      listingData.value = ListingModel.fromApi(apiResponse.bodyData['_data']);
      listingData.notifyListeners();
    } else {
      DialogService().showTransactionDialog(text: "Something went wrong");
    }
  }
}
