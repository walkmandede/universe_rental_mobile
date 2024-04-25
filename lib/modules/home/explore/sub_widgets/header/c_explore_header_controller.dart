// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe_rental/constants/app_functions.dart';
import '../../../../_common/models/m_listing_tag.dart';

class ExploreHeaderController extends GetxController{

  ValueNotifier<ListingTag?> selectedTag = ValueNotifier(null);

  @override
  void onInit() {
    initLoad();
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> initLoad() async{

  }

  Future<void> updateSelectedTag({required ListingTag listingTag}) async{
    selectedTag.value = listingTag;
    selectedTag.notifyListeners();
  }

}

