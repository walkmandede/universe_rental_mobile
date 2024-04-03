import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

import 'package:universe_rental/modules/home/explore/sub_widgets/listing/m_listing_model.dart';

class ListingController extends GetxController {
  ValueNotifier<bool> xListFetching = ValueNotifier(false);
  ValueNotifier<List<DummyPlaces>> shownData = ValueNotifier([]);

  @override
  void onInit() {
    readJsonFile();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future<void> initLoad() async {}

  Future<void> updateListingData() async {
    xListFetching.value = true;
    xListFetching.notifyListeners();
    try {
      //todo apicall
    } catch (e) {}
    xListFetching.value = false;
    xListFetching.notifyListeners();
  }

  Future<void> readJsonFile() async {
    final String response = await rootBundle.loadString('assets/places.json');
    final data = await json.decode(response);
    print(data);
    for (var v in data['data']) {
      shownData.value.add(DummyPlaces.fromJson(v));
    }
    print(shownData.value);
    shownData.notifyListeners();
  }
}
