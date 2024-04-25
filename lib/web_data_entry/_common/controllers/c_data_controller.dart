import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe_rental/constants/app_functions.dart';
import 'package:universe_rental/services/network_services/api_end_points.dart';
import 'package:universe_rental/services/network_services/api_service.dart';
import 'package:universe_rental/services/overlays_services/dialog/dialog_service.dart';
import 'package:universe_rental/web_data_entry/currency/m_currency_model.dart';
import 'package:universe_rental/web_data_entry/listing_place/m_listing_place.dart';

import '../../all_listings/m_listing_model.dart';
import '../../listing_attribute/m_listing_attribute.dart';
import '../../listing_offers/m_listing_tag.dart';
import '../../listing_tags/m_listing_tag.dart';

class DataEntryDataController extends GetxController {
  //fetchedData
  ValueNotifier<List<EnumListingType>> allTypes = ValueNotifier([]);
  ValueNotifier<List<ListingTag>> allTags = ValueNotifier([]);
  ValueNotifier<List<ListingOffer>> allOffers = ValueNotifier([]);
  ValueNotifier<List<ListingAttribute>> allAttributes = ValueNotifier([]);
  ValueNotifier<List<ListingPlace>> allPlaces = ValueNotifier([]);
  ValueNotifier<List<CurrencyModel>> allCurrency = ValueNotifier([]);

  //dummy
  static const String dummySvg =
      """<?xml version="1.0" ?><svg data-name="Layer 1" id="Layer_1" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><title/><path d="M22.26465,2.42773a2.04837,2.04837,0,0,0-2.07813-.32421L2.26562,9.33887a2.043,2.043,0,0,0,.1045,3.81836l3.625,1.26074,2.0205,6.68164A.998.998,0,0,0,8.134,21.352c.00775.012.01868.02093.02692.03259a.98844.98844,0,0,0,.21143.21576c.02307.01758.04516.03406.06982.04968a.98592.98592,0,0,0,.31073.13611l.01184.001.00671.00287a1.02183,1.02183,0,0,0,.20215.02051c.00653,0,.01233-.00312.0188-.00324a.99255.99255,0,0,0,.30109-.05231c.02258-.00769.04193-.02056.06384-.02984a.9931.9931,0,0,0,.20429-.11456,250.75993,250.75993,0,0,1,.15222-.12818L12.416,18.499l4.03027,3.12207a2.02322,2.02322,0,0,0,1.24121.42676A2.05413,2.05413,0,0,0,19.69531,20.415L22.958,4.39844A2.02966,2.02966,0,0,0,22.26465,2.42773ZM9.37012,14.73633a.99357.99357,0,0,0-.27246.50586l-.30951,1.504-.78406-2.59307,4.06525-2.11695ZM17.67188,20.04l-4.7627-3.68945a1.00134,1.00134,0,0,0-1.35352.11914l-.86541.9552.30584-1.48645,7.083-7.083a.99975.99975,0,0,0-1.16894-1.59375L6.74487,12.55432,3.02051,11.19141,20.999,3.999Z" fill="#6563ff"/></svg>""";

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

  Future<void> fetchAllData() async {
    await Future.wait([
      fetchTags(),
      fetchOffers(),
      fetchAttributes(),
      fetchPlaces(),
      fetchCurrencies(),
    ]);
  }

  Future<void> fetchTags() async {
    Response? response = await ApiService().get(
      endPoint: ApiEndPoints.dataEntryTag,
    );

    superPrint(response!.body, title: "List Tag Response");

    final apiResponse = ApiService().validateResponse(response: response);

    if (apiResponse.xSuccess) {
      allTags.value.clear();
      final data = apiResponse.bodyData;
      Iterable iterable = data["_data"] ?? [];
      superPrint(iterable);
      for (final each in iterable) {
        allTags.value.add(ListingTag.fromApi(data: each));
      }
      superPrint(allTags.value);
      allTags.notifyListeners();
    } else {
      DialogService().showTransactionDialog(text: "Something went wrong");
    }
  }

  Future<void> fetchOffers() async {
    Response? response = await ApiService().get(
      endPoint: ApiEndPoints.dataEntryOffer,
    );

    final apiResponse = ApiService().validateResponse(response: response);

    if (apiResponse.xSuccess) {
      allOffers.value.clear();
      final data = apiResponse.bodyData;
      Iterable iterable = data["_data"] ?? [];
      superPrint(iterable);
      for (final each in iterable) {
        allOffers.value.add(ListingOffer.fromApi(data: each));
      }
      superPrint(allOffers.value);
      allOffers.notifyListeners();
    } else {
      DialogService().showTransactionDialog(text: "Something went wrong");
    }
    // allOffers.value = [
    //   ListingOffer(id: "", name: "Air Con", icon: dummySvg),
    //   ListingOffer(id: "", name: "Mini Bar", icon: dummySvg),
    //   ListingOffer(id: "", name: "Hair Dryer", icon: dummySvg),
    //   ListingOffer(id: "", name: "Bath Tub", icon: dummySvg),
    //   ListingOffer(id: "", name: "Water Heater", icon: dummySvg),
    //   ListingOffer(id: "", name: "Car Park Lots", icon: dummySvg),
    // ];
    // allOffers.notifyListeners();
  }

  Future<void> fetchAttributes() async {
    Response? response = await ApiService().get(
      endPoint: ApiEndPoints.dataEntryAttribute,
    );

    final apiResponse = ApiService().validateResponse(response: response);

    if (apiResponse.xSuccess) {
      allAttributes.value.clear();
      final data = apiResponse.bodyData;
      Iterable iterable = data["_data"] ?? [];
      superPrint(iterable);
      for (final each in iterable) {
        allAttributes.value.add(ListingAttribute.fromApi(data: each));
      }
      superPrint(allAttributes.value);
      allAttributes.notifyListeners();
    } else {
      DialogService().showTransactionDialog(text: "Something went wrong");
    }
    // // allAttributes.value = [
    // //   ListingAttribute(id: "", name: "Guests"),
    // //   ListingAttribute(id: "", name: "Bedrooms"),
    // //   ListingAttribute(id: "", name: "Beds"),
    // //   ListingAttribute(id: "", name: "Bathrooms"),
    // //   ListingAttribute(id: "", name: "Kitchen"),
    // //   ListingAttribute(id: "", name: "Study"),
    // // ];
    // allAttributes.notifyListeners();
  }

  Future<void> fetchPlaces() async {
    Response? response = await ApiService().get(
      endPoint: ApiEndPoints.dataEntryPlace,
    );

    final apiResponse = ApiService().validateResponse(response: response);

    if (apiResponse.xSuccess) {
      allPlaces.value.clear();
      final data = apiResponse.bodyData;
      Iterable iterable = data["_data"] ?? [];
      superPrint(iterable);
      for (final each in iterable) {
        allPlaces.value.add(ListingPlace.fromApi(data: each));
      }
      superPrint(allPlaces.value);
      allPlaces.notifyListeners();
    } else {
      DialogService().showTransactionDialog(text: "Something went wrong");
    }
    // allPlaces.value = [
    //   ListingPlace(id: "", name: "Kitchen"),
    //   ListingPlace(id: "", name: "Bedrooms"),
    //   ListingPlace(id: "", name: "Living Rooms"),
    //   ListingPlace(id: "", name: "Garden"),
    //   ListingPlace(id: "", name: "Parking Lot"),
    // ];
    // allPlaces.notifyListeners();
  }

  Future<void> fetchCurrencies() async {
    Response? response = await ApiService().get(
      endPoint: ApiEndPoints.dataEntryCurrency,
    );

    final apiResponse = ApiService().validateResponse(response: response);

    if (apiResponse.xSuccess) {
      allCurrency.value.clear();
      final data = apiResponse.bodyData;
      Iterable iterable = data["_data"] ?? [];
      superPrint(iterable);
      for (final each in iterable) {
        allCurrency.value.add(CurrencyModel.fromApi(data: each));
      }
      superPrint(allCurrency.value);
      allCurrency.notifyListeners();
    } else {
      DialogService().showTransactionDialog(text: "Something went wrong");
    }
    // // allCurrency.value = [
    // //   CurrencyModel(
    // //       id: "", name: "United State Dollar", abbr: "USD", sign: "\$"),
    // //   CurrencyModel(id: "", name: "Chinese Wan", abbr: "CHW", sign: "\W"),
    // //   CurrencyModel(id: "", name: "Myanmar Kyats", abbr: "MMK", sign: "\Ks"),
    // //   CurrencyModel(id: "", name: "Thai Baht", abbr: "THB", sign: "\BHT"),
    // // ];
    // allCurrency.notifyListeners();
  }
}
