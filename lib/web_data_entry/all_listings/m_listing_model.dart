import 'package:latlong2/latlong.dart';
import 'package:universe_rental/services/network_services/api_end_points.dart';
import 'package:universe_rental/services/network_services/api_service.dart';
import 'package:universe_rental/web_data_entry/currency/m_currency_model.dart';
import 'package:universe_rental/web_data_entry/listing_offers/m_listing_tag.dart';
import 'package:universe_rental/web_data_entry/listing_place/m_listing_place.dart';
import 'package:universe_rental/web_data_entry/listing_tags/m_listing_tag.dart';
import '../listing_attribute/m_listing_attribute.dart';

enum EnumListingType { room, entirePlace, shareRoom }

class ListingModel {
  String id;
  String title;
  String subTitle;
  String about;
  String hostName;
  List<String> imgList;

  EnumListingType listingType;
  List<ListingTag> listingTags;
  Map<ListingAttribute, int> listingAttributesQty;
  Map<ListingPlace, List<String>> listingPlacesImages;

  List<ListingOffer> offerList;

  LatLng addressLocation;
  String fullAddress;
  String addressRemark;

  Map<String, List<Map<CurrencyModel, double>>> dailyNightData;

  ListingModel({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.imgList,
    required this.listingType,
    required this.listingTags,
    required this.addressLocation,
    required this.about,
    required this.dailyNightData,
    required this.addressRemark,
    required this.hostName,
    required this.fullAddress,
    required this.listingAttributesQty,
    required this.listingPlacesImages,
    required this.offerList,
  });

  factory ListingModel.fromApi(Map<String, dynamic> data) {
    List<ListingTag> _listTags = [];
    for (var v in data['listingOnTag']) {
      _listTags.add(ListingTag.fromApi(data: v['listingTag']));
    }
    print(_listTags);

    Map<String, List<Map<CurrencyModel, double>>> _nightData = {};
    for (var v in data['nightData']) {
      List<Map<CurrencyModel, double>> _currencyList = [];
      for (var _currency in v['listingPrice']) {
        _currencyList.add({
          CurrencyModel.fromApi(data: _currency['currency']):
              double.parse(_currency['amount'].toString())
        });
      }
      _nightData[v['date'].toString().split("T").first] = _currencyList;
    }
    print(_nightData);

    Map<ListingAttribute, int> _attributeData = {};
    for (var attribute in data['listingOnAttribute']) {
      _attributeData[
              ListingAttribute.fromApi(data: attribute['listingAttribute'])] =
          attribute['quantity'];
    }
    print(_attributeData);

    Map<ListingPlace, List<String>> _places = {};

    for (var v in data['listingOnPlace']) {
      ListingPlace _place = ListingPlace.fromApi(data: v['listingPlace']);
      List<String> _imgs = [];
      for (var image in v['imageList']) {
        _imgs.add(ApiService().domain + image);
      }
      _places[_place] = _imgs;
    }
    print(_places);

    List<ListingOffer> _offerList = [];
    for (var _offer in data['listingOffers']) {
      _offerList.add(ListingOffer.fromApi(data: _offer));
    }
    print(_offerList);

    List<String> _imgList = [];
    for (var img in data['imageList']) {
      _imgList.add(ApiService().domain + img);
    }
    return ListingModel(
        id: data['id'],
        title: data['title'],
        subTitle: data['subTitle'],
        about: data['description'],
        listingType: stringToEnum(data['listingType']),
        hostName: data['hostName'],
        addressLocation: LatLng(
            data['listingLocation']['lat'], data['listingLocation']['lng']),
        addressRemark: data['listingLocation']['remark'],
        fullAddress: data['listingLocation']['fullAddress'],
        listingTags: _listTags,
        dailyNightData: _nightData,
        listingAttributesQty: _attributeData,
        listingPlacesImages: _places,
        offerList: _offerList,
        imgList: _imgList);
  }
}

EnumListingType stringToEnum(String str) {
  EnumListingType _result = EnumListingType.entirePlace;
  switch (str) {
    case "ENTIRE_PLACE":
      _result = EnumListingType.entirePlace;
      break;
    case "ROOM":
      _result = EnumListingType.room;
      break;
    case "SHARE_ROOM":
      _result = EnumListingType.shareRoom;
      break;

    default:
  }
  return _result;
}

String enumToString(EnumListingType enumtype) {
  String _result = '';
  switch (enumtype) {
    case EnumListingType.entirePlace:
      _result = "ENTIRE_PLACE";
      break;
    case EnumListingType.room:
      _result = "ROOM";
      break;
    case EnumListingType.shareRoom:
      _result = "SHARE_ROOM";
      break;
    default:
  }
  return _result;
}
