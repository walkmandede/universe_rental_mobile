import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:universe_rental/modules/_common/controllers/c_data_controller.dart';
import 'package:universe_rental/web_data_entry/_common/controllers/c_data_controller.dart';
import 'package:universe_rental/web_data_entry/listing_attribute/m_listing_attribute.dart';
import 'package:universe_rental/web_data_entry/listing_offers/m_listing_tag.dart';
import 'package:universe_rental/web_data_entry/listing_place/m_listing_place.dart';
import 'package:universe_rental/web_data_entry/listing_tags/m_listing_tag.dart';

import '../../_common/models/m_night_fee_model.dart';
import '../../listing_type/m_listing_type.dart';

class AddNewListingController extends GetxController {
  //inputData

  //dataInfo
  TextEditingController txtTitle = TextEditingController(text: "");
  TextEditingController txtSubtitle = TextEditingController(text: "");
  TextEditingController txtAbout = TextEditingController(text: "");

  //location
  TextEditingController txtFullAddress = TextEditingController(text: "");
  TextEditingController txtAddressRemark = TextEditingController(text: "");
  ValueNotifier<LatLng> addressLocation =
      ValueNotifier(const LatLng(16.88, 96.24));

  //hosting
  ValueNotifier<File> hostImage = ValueNotifier(File(""));
  TextEditingController txtHostName = TextEditingController(text: "");

  //-----------------------------------------------------

  //listingData

  ValueNotifier<ListingType?> listingType = ValueNotifier(null);
  ValueNotifier<List<ListingTag>> listingTags = ValueNotifier([]);
  ValueNotifier<List<ListingOffer>> listingOffers = ValueNotifier([]);
  ValueNotifier<Map<ListingAttribute, int>> listingAttributesMap =
      ValueNotifier({});
  ValueNotifier<Map<ListingPlace, List<File>>> listingPlacesMap =
      ValueNotifier({});
  ValueNotifier<List<File>> listingImages = ValueNotifier([]);

  //-----------------------------------------------------

  //others

  //nightData
  ValueNotifier<SplayTreeMap<String, List<NightFeeModel>>> dailyNightFeesMap =
      ValueNotifier(SplayTreeMap.from({}));

  DataEntryDataController dataEntryDataController = Get.find();

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

  Future<void> initLoad() async {}
}
