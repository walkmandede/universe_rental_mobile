import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe_rental/constants/app_functions.dart';
import 'package:universe_rental/modules/_common/models/m_listing_detail.dart';
import 'package:universe_rental/modules/home/explore/sub_widgets/header/c_explore_header_controller.dart';
import 'package:universe_rental/services/network_services/api_end_points.dart';
import 'package:universe_rental/services/network_services/api_service.dart';
import 'package:universe_rental/services/others/extensions.dart';
import 'package:universe_rental/services/overlays_services/dialog/dialog_service.dart';

class ListingDetailController extends GetxController {
  ValueNotifier<int> currentShownPageIndex = ValueNotifier(0);
  ValueNotifier<ListingDetail?> listingData = ValueNotifier(null);

  ValueNotifier<DateTimeRange> selectedDateTimeRange =
      ValueNotifier(DateTimeRange(start: DateTime.now(), end: DateTime.now()));
  ValueNotifier<bool> xSelectedDates = ValueNotifier(false);
  ValueNotifier<bool> xContainNightDate = ValueNotifier(false);
  Set<String> validDates = {};
  ValueNotifier<bool> xLoading = ValueNotifier(false);
  ValueNotifier<String?> xHasNightDataDate = ValueNotifier(null);
  ValueNotifier<int> currentIndex = ValueNotifier(0);
  @override
  void onInit() {
    //
    ExploreHeaderController _controller = Get.find();
    selectedDateTimeRange.value = _controller.selectedDateRange.value;
    selectedDateTimeRange.notifyListeners();
    super.onInit();
  }

  Future<void> initLoad(
      {required String id, required int shownPageIndex}) async {
    currentShownPageIndex.value = shownPageIndex;
    currentIndex.value = shownPageIndex;
    currentIndex.notifyListeners();
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
    List _date =
        listingData.value!.nightData.map((e) => e.date.getDateKey()).toList();
    print(_date);

    /* // check the start and end date is valid
    if (_date.contains(
            selectedDateTimeRange.value!.start.toString().split(" ").first) &&
        _date.contains(
            selectedDateTimeRange.value!.end.toString().split(" ").first)) {
      xContainNightDate.value = true;
    } else {
      xContainNightDate.value = false;
    }
   */
    xContainNightDate.value = false;
    xHasNightDataDate.value = null;
    xSelectedDates.value = false;
    final _selectedRawDates = AppFunctions().getBetweenDates(
        dtr: DateTimeRange(
            start: selectedDateTimeRange.value.start,
            end: selectedDateTimeRange.value.end));
    List _selectedDates = _selectedRawDates.map((e) => e.getDateKey()).toList();
    // check there is any one night data for at least among selected dates
    for (var date1 in _date) {
      for (var date2 in _selectedDates) {
        if (date2 == date1) {
          xContainNightDate.value = true;
          xHasNightDataDate.value = date2;
          break;
        }
      }
      if (xContainNightDate.value) {
        break;
      }
    }
    xSelectedDates.value = true;
    xSelectedDates.notifyListeners();
    xContainNightDate.notifyListeners();
    xHasNightDataDate.notifyListeners();
    print(xContainNightDate);
  }
}
