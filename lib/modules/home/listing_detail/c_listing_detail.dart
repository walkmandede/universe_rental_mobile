import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe_rental/modules/_common/models/m_listing_detail.dart';
import 'package:universe_rental/modules/home/explore/sub_widgets/header/c_explore_header_controller.dart';
import 'package:universe_rental/modules/my_calendar/c_my_calendar.dart';
import 'package:universe_rental/services/network_services/api_end_points.dart';
import 'package:universe_rental/services/network_services/api_service.dart';
import 'package:universe_rental/services/others/extensions.dart';
import 'package:universe_rental/services/overlays_services/dialog/dialog_service.dart';
import 'package:universe_rental/web_data_entry/all_listings/m_listing_model.dart';

class ListingDetailController extends GetxController {
  ValueNotifier<int> currentShownPageIndex = ValueNotifier(0);
  ValueNotifier<ListingDetail?> listingData = ValueNotifier(null);

  ValueNotifier<DateTimeRange> selectedDateTimeRange =
      ValueNotifier(DateTimeRange(start: DateTime.now(), end: DateTime.now()));
  ValueNotifier<bool> xSelectedDates = ValueNotifier(false);
  ValueNotifier<bool> xContainNightDate = ValueNotifier(false);
  Set<String> validDates = {};
  ValueNotifier<bool> xLoading = ValueNotifier(false);
  @override
  void onInit() {
    //
    ExploreHeaderController _controller = Get.find();
    selectedDateTimeRange.value = _controller.selectedDateRange.value;
    selectedDateTimeRange.notifyListeners();
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
    xLoading.value = true;
    xLoading.notifyListeners();
    Response? response = await ApiService()
        .get(endPoint: "${ApiEndPoints.dataEntryListing}/$id");

    final apiResponse = ApiService().validateResponse(response: response);

    if (apiResponse.xSuccess) {
      validDates.clear();
      listingData.value =
          ListingDetail.fromDetail(data: apiResponse.bodyData['_data']);

      listingData.notifyListeners();
      listingData.value!.nightData.forEach((element) {
        validDates.add(element.date.getDateKey());
      });
      xLoading.value = false;
      xLoading.notifyListeners();
    } else {
      DialogService().showTransactionDialog(text: "Something went wrong");
      xLoading.value = false;
      xLoading.notifyListeners();
    }
  }

  void onChangedSelectedDate(DateTimeRange? date) {
    if (date != null) {
      selectedDateTimeRange.value = date;
    }

    checkNightDataExist();
    selectedDateTimeRange.notifyListeners();
  }

  void checkNightDataExist() {
    List _date = listingData.value!.nightData
        .map((e) => e.date.toString().split(" ").first)
        .toList();
    print(_date);
    if (_date.contains(
            selectedDateTimeRange.value!.start.toString().split(" ").first) &&
        _date.contains(
            selectedDateTimeRange.value!.end.toString().split(" ").first)) {
      xContainNightDate.value = true;
    } else {
      xContainNightDate.value = false;
    }
    xSelectedDates.value = true;
    xSelectedDates.notifyListeners();
    xContainNightDate.notifyListeners();
    print(xContainNightDate);
  }
}
