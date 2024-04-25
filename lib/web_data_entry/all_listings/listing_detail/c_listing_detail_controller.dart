import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:universe_rental/services/network_services/api_end_points.dart';
import 'package:universe_rental/services/network_services/api_service.dart';
import 'package:universe_rental/services/overlays_services/dialog/dialog_service.dart';
import 'package:universe_rental/web_data_entry/all_listings/m_listing_model.dart';

/**
 *  ListingModel(
          id: '',
          title: '',
          subTitle: '',
          listingType: EnumListingType.entirePlace,
          listingTags: [],
          addressLocation: LatLng(32, 323),
          about: '',
          dailyNightData: {},
          addressRemark: '',
          hostName: '',
          fullAddress: '',
          listingAttributesQty: {},
          listingPlacesImages: {},
          offerList: [])
 */
class ListingDetailController extends GetxController {
  ValueNotifier<ListingModel> listingDetail = ValueNotifier<ListingModel>(
      ListingModel(
          id: '',
          title: '',
          subTitle: '',
          listingType: EnumListingType.entirePlace,
          listingTags: [],
          addressLocation: LatLng(32, 323),
          about: '',
          dailyNightData: {},
          addressRemark: '',
          hostName: '',
          fullAddress: '',
          listingAttributesQty: {},
          listingPlacesImages: {},
          offerList: [],
          imgList: []));

  String id = '';

  Map<String, dynamic> args = Get.arguments;
  @override
  void onInit() {
    id = args['id'];
    updateData();
    super.onInit();
  }

  Future<void> updateData() async {
    Response? response = await ApiService()
        .get(endPoint: "${ApiEndPoints.dataEntryListing}/$id");

    final apiResponse = ApiService().validateResponse(response: response);

    if (apiResponse.xSuccess) {
      listingDetail.value = ListingModel.fromApi(apiResponse.bodyData['_data']);
      listingDetail.notifyListeners();
    } else {
      DialogService().showTransactionDialog(text: "Something wend wrong");
    }
  }
}
