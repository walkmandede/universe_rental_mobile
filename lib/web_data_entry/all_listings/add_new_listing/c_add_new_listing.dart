import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:universe_rental/constants/app_functions.dart';
import 'package:universe_rental/services/network_services/api_end_points.dart';
import 'package:universe_rental/services/network_services/api_service.dart';
import 'package:universe_rental/services/overlays_services/dialog/dialog_service.dart';
import 'package:universe_rental/web_data_entry/_common/controllers/c_data_controller.dart';
import 'package:universe_rental/web_data_entry/all_listings/listing_list/c_all_listing_controller.dart';
import 'package:universe_rental/web_data_entry/listing_attribute/m_listing_attribute.dart';
import 'package:universe_rental/web_data_entry/listing_offers/m_listing_tag.dart';
import 'package:universe_rental/web_data_entry/listing_place/m_listing_place.dart';
import 'package:universe_rental/web_data_entry/listing_tags/m_listing_tag.dart';

import '../../_common/models/m_night_fee_model.dart';
import '../m_listing_model.dart';

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

  ValueNotifier<EnumListingType?> listingType = ValueNotifier(null);
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

  Future<void> onClickSave() async {
    if (txtTitle.text.isEmpty ||
        txtSubtitle.text.isEmpty ||
        txtAbout.text.isEmpty ||
        listingType.value == null ||
        txtHostName.text.isEmpty ||
        txtFullAddress.text.isEmpty ||
        txtAddressRemark.text.isEmpty ||
        listingAttributesMap.value == {} ||
        listingOffers.value == [] ||
        listingTags.value == [] ||
        listingImages.value == [] ||
        listingPlacesMap.value == {} ||
        dailyNightFeesMap.value == {}) {
      DialogService().showSnack(title: "Error", message: "Fill all data");
    } else {
      List _imgs = [];
      _imgs = await cImg(listingImages.value);

      List _placeImgs = [];
      List _place = [];

      for (var each in listingPlacesMap.value.entries) {
        _placeImgs = await cImg(each.value);
        _place.add(
            {"listingPlaceId": each.key.id, "listingPlaceImages": _placeImgs});
      }

      final _data = {
        "title": txtTitle.text,
        "subTitle": txtSubtitle.text,
        "description": txtAbout.text,
        "listingType": enumToString(listingType.value! ?? EnumListingType.room),
        "hostName": txtHostName.text,
        "listingLocation": {
          "fullAddress": txtFullAddress.text,
          "remark": txtAddressRemark.text,
          "lat": addressLocation.value.latitude,
          "lng": addressLocation.value.longitude
        },
        "attributes": listingAttributesMap.value.entries
            .map((attribute) =>
                {"quantity": attribute.value, "attributeId": attribute.key.id})
            .toList(),
        "offers": listingOffers.value.map((offer) => offer.id).toList(),
        "tags": listingTags.value.map((tag) => tag.id).toList(),
        "listingImages": _imgs,
        "listingPlaces": _place,
        "nightDatas": dailyNightFeesMap.value.entries
            .map((nightData) => {
                  "date": "${nightData.key}T06:52:35.008Z",
                  "listingPrices": nightData.value
                      .map((nightPrice) => {
                            "currencyID": nightPrice.currencyModel.id,
                            "amount": nightPrice.perNightFee
                          })
                      .toList()
                })
            .toList()
      };
      jsonEncode(_data);
      log(jsonEncode(_data));
      DialogService().showLoadingDialog();

      Response? response = await ApiService()
          .post(endPoint: ApiEndPoints.dataEntryListing, data: _data);
      DialogService().dismissDialog();
      final apiResponse = ApiService().validateResponse(response: response);

      if (apiResponse.xSuccess) {
        Get.back();
        AllListingController controller = Get.find();
        controller.updateData();
      } else {
        DialogService().showTransactionDialog(text: apiResponse.message);
      }
    }
  }
}

List<String> convertImg(List<File> imageList) {
  List<String> _str = [];
  String s = '';
  imageList.forEach((image) async {
    final rawImage = await image.readAsBytes();
    final extension = image.path.split(".").last;
    final base64Image = "data:image/$extension;${base64.encode(rawImage)}";
    _str.add(base64Image);
    s = base64Image;
  });
  // print("hello" + s);
  return _str;
}

Future<List<String>> cImg(List<File> imageList) async {
  List<String> _resu = [];
  String s = '';
  for (int i = 0; i < imageList.length; i++) {
    final rawImage = await imageList[i].readAsBytes();
    final extension = imageList[i].path.split(".").last;
    final base64Image = "data:image/$extension;${base64.encode(rawImage)}";
    _resu.add(base64Image);
    s = base64Image;
  }
  // print(s);
  return _resu;
}
