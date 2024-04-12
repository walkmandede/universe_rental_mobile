
import 'package:latlong2/latlong.dart';
import 'package:universe_rental/web_data_entry/currency/m_currency_model.dart';
import 'package:universe_rental/web_data_entry/listing_offers/m_listing_tag.dart';
import 'package:universe_rental/web_data_entry/listing_place/m_listing_place.dart';
import 'package:universe_rental/web_data_entry/listing_tags/m_listing_tag.dart';
import 'package:universe_rental/web_data_entry/listing_type/m_listing_type.dart';
import '../listing_attribute/m_listing_attribute.dart';

class ListingModel{
  String id;
  String title;
  String subTitle;
  String about;
  String hostName;

  ListingType listingType;
  List<ListingTag> listingTags;
  Map<ListingAttribute,int> listingAttributesQty;
  Map<ListingPlace,List<String>> listingPlacesImages;

  List<ListingOffer> offerList;

  LatLng addressLocation;
  String fullAddress;
  String addressRemark;

  Map<String,List<Map<CurrencyModel,double>>> dailyNightData;

  ListingModel({
    required this.id,
    required this.title,
    required this.subTitle,
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

}