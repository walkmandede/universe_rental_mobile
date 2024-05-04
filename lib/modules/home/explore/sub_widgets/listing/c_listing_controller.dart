import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ListingController extends GetxController {
  ValueNotifier<bool> xListFetching = ValueNotifier(false);
  ValueNotifier<List<dynamic>> shownData = ValueNotifier([]);

  Future<void> initLoad() async {}

  Future<void> updateListingData() async {
    xListFetching.value = true;
    xListFetching.notifyListeners();
    try {
      //todo apicall
    } catch (e) {
      null;
    }
    xListFetching.value = false;
    xListFetching.notifyListeners();
  }
}
