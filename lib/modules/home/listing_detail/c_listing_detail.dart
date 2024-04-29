import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe_rental/modules/_common/models/m_listing_detail.dart';
import 'package:universe_rental/services/network_services/api_end_points.dart';
import 'package:universe_rental/services/network_services/api_service.dart';
import 'package:universe_rental/services/overlays_services/dialog/dialog_service.dart';
import 'package:universe_rental/web_data_entry/all_listings/m_listing_model.dart';

class ListingDetailController extends GetxController {
  ValueNotifier<int> currentShownPageIndex = ValueNotifier(0);
  ValueNotifier<ListingDetail?> listingData = ValueNotifier(null);
  ValueNotifier<DateTimeRange> selectedDateTimeRange =
      ValueNotifier(DateTimeRange(end: DateTime.now(), start: DateTime.now()));
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
    getListingData(id);
  }

  void onPageChanged(int index) {
    currentShownPageIndex.value = index;
  }

  Future<void> getListingData(String id) async {
    Response? response = await ApiService()
        .get(endPoint: "${ApiEndPoints.dataEntryListing}/$id");

    final apiResponse = ApiService().validateResponse(response: response);

    if (apiResponse.xSuccess) {
      listingData.value =
          ListingDetail.fromDetail(data: apiResponse.bodyData['_data']);

      listingData.notifyListeners();
    } else {
      DialogService().showTransactionDialog(text: "Something went wrong");
    }
  }

  onChangedSelectedDate(DateTimeRange? date) {
    if (date != null) {
      selectedDateTimeRange.value = date;
    }
    selectedDateTimeRange.notifyListeners();
  }
}
