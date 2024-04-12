
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../m_listing_model.dart';

class AllListingController extends GetxController{

  ValueNotifier<List<ListingModel>> allData = ValueNotifier([]);

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

  }

  Future<void> updateData() async{

    allData.value = [
      // ListingModel(
      //   id: "",
      //   title: "Some Title",
      //   about: "241455",
      //
      // ),
    ];

  }

}
