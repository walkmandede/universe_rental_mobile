import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe_rental/services/network_services/api_end_points.dart';
import 'package:universe_rental/services/network_services/api_service.dart';
import 'package:universe_rental/services/overlays_services/dialog/dialog_service.dart';
import 'package:universe_rental/web_data_entry/all_listings/m_listing_list_model.dart';

import '../m_listing_model.dart';

class AllListingController extends GetxController {
  ValueNotifier<List<ListingListModel>> allData = ValueNotifier([]);

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

  Future<void> initLoad() async {
    updateData();
  }

  Future<void> updateData() async {
    Response? response =
        await ApiService().get(endPoint: ApiEndPoints.dataEntryListing);

    final apiResponse = ApiService().validateResponse(response: response);

    if (apiResponse.xSuccess) {
      allData.value.clear();
      Iterable _rawData = apiResponse.bodyData['_data'];

      for (var _data in _rawData) {
        allData.value.add(ListingListModel.fromApi(_data));
      }

      allData.notifyListeners();
    } else {
      DialogService().showTransactionDialog(text: "Something went wrong");
    }
    // allData.value = [
    //   // ListingModel(
    //   //   id: "",
    //   //   title: "Some Title",
    //   //   about: "241455",
    //   //
    //   // ),
    // ];
  }

  Future<void> deleteData(String id) async {
    DialogService().showLoadingDialog();
    Response? response = await ApiService()
        .patch(endPoint: "${ApiEndPoints.dataEntryListing}/$id");

    final apiResponse = ApiService().validateResponse(response: response);
    if (apiResponse.xSuccess) {
      DialogService().showTransactionDialog(text: "Deletion success");
      updateData();
    } else {
      DialogService().showTransactionDialog(text: "Something went wrong");
    }
  }
}
