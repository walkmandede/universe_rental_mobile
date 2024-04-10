// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe_rental/constants/app_functions.dart';
import 'package:universe_rental/services/network_services/api_end_points.dart';
import 'package:universe_rental/services/network_services/api_service.dart';
import 'package:universe_rental/services/overlays_services/dialog/dialog_service.dart';

import '../m_listing_tag.dart';

class ListingTagsListController extends GetxController{

  ValueNotifier<List<ListingTag>> shownData = ValueNotifier([]);

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

  Future<void> initLoad() async{
    updateData();
  }

  Future<void> updateData() async{

    Response? response = await ApiService().get(
      endPoint: ApiEndPoints.dataEntryTag,
    );

    final apiResponse = ApiService().validateResponse(response: response);

    if(apiResponse.xSuccess){
      shownData.value.clear();
      final data = apiResponse.bodyData;
      Iterable iterable = data["_data"]??[];
      superPrint(iterable);
      for(final each in iterable){
        shownData.value.add(ListingTag.fromApi(data: each));
      }
      superPrint(shownData.value);
      shownData.notifyListeners();
    }
    else{
      DialogService().showTransactionDialog(text: "Something went wrong");
    }

  }

  Future<void> deleteData({required ListingTag data}) async{

    DialogService().showLoadingDialog();

    Response? response = await ApiService().delete(
      endPoint: "${ApiEndPoints.dataEntryTag}/${data.id}",
    );

    superPrint(response!.body);

    DialogService().dismissDialog();

    final apiResponse = ApiService().validateResponse(response: response);

    if(apiResponse.xSuccess){
      updateData();
      DialogService().showTransactionDialog(text: "Deletion success");
    }
    else{
      DialogService().showTransactionDialog(text: "Something went wrong");
    }
  }

}
