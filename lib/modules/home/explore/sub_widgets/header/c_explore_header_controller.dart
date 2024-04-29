// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe_rental/constants/app_functions.dart';
import 'package:universe_rental/modules/home/explore/c_explore_controller.dart';
import 'package:universe_rental/modules/home/explore/sub_widgets/listing_map/c_listing_map.dart';
import '../../../../_common/models/m_listing_tag.dart';

class ExploreHeaderController extends GetxController{

  ValueNotifier<ListingTag?> selectedTag = ValueNotifier(null);
  ValueNotifier<DateTimeRange> selectedDateRange = ValueNotifier(
    DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now().add(const Duration(days: 100))
    )
  );

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
    try{
      ExploreController exploreController = Get.find();
      await exploreController.updateShownListing();
    }
    catch(e){
      null;
    }
    try{
      ListingMapController listingMapController = Get.find();
      await listingMapController.updateData();
    }
    catch(e){
      null;
    }
  }

}

