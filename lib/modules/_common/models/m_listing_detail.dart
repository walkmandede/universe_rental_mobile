
import 'package:latlong2/latlong.dart';
import 'package:universe_rental/constants/app_enum.dart';
import 'package:universe_rental/modules/_common/models/m_listing_attribute.dart';
import 'package:universe_rental/modules/_common/models/m_listing_place.dart';
import 'm_listing_offer.dart';
import 'm_listing_tag.dart';
import 'm_night_fee_model.dart';

class ListingDetail{

  String id;
  String title;
  String subTitle;
  String description;
  EnumListingType enumListingType;
  List<String> imageList;
  String hostName;
  ListingLocation listingLocation;
  List<ListingOffer> listingOffers;
  List<ListingOnPlace> listingOnPlaces;
  List<ListingOnAttribute> listingOnAttributes;
  List<ListingTag> listingTags;
  List<NightData> nightData;

  ListingDetail({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.description,
    required this.enumListingType,
    required this.imageList,
    required this.hostName,
    required this.listingLocation,
    required this.listingOffers,
    required this.listingOnPlaces,
    required this.listingOnAttributes,
    required this.listingTags,
    required this.nightData,
  });

  factory ListingDetail.fromMap({required Map<String,dynamic> data}){

    EnumListingType enumListingType = EnumListingType.entirePlace;

    //listingType - ENTIRE_PLACE, ROOM, SHARE_ROOM
    switch(data["listingType"].toString()){
      case "ROOM" : enumListingType = EnumListingType.room;break;
      case "ENTIRE_PLACE" : enumListingType = EnumListingType.entirePlace;break;
      case "SHARE_ROOM" : enumListingType = EnumListingType.shareRoom;break;
    }

    //listingOffer
    Iterable listingOffers = data["listingOffers"]??[];
    //listingOnPlace
    Iterable listingOnPlace = data["listingOnPlace"]??[];
    //listingOnAttribute
    Iterable listingOnAttribute = data["listingOnAttribute"]??[];
    //listingOnTag
    Iterable listingOnTag = data["listingOnTag"]??[];
    //nightData
    Iterable nightData = data["nightData"]??[];

    return ListingDetail(
      id: data["id"].toString(),
      title: data["title"].toString(),
      subTitle: data["subTitle"].toString(),
      description: data["description"].toString(),
      enumListingType: enumListingType,
      imageList: data["imageList"]??[],
      hostName: data["hostName"].toString(),
      listingLocation: ListingLocation.fromMap(data: data["listingLocation"]),
      listingOffers: listingOffers.map((e) => ListingOffer.fromApi(data: e)).toList(),
      listingOnPlaces: listingOnPlace.map((e) => ListingOnPlace.fromMap(data: e)).toList(),
      listingOnAttributes: listingOnAttribute.map((e) => ListingOnAttribute.fromMap(data: e)).toList(),
      listingTags: listingOnTag.map((e) => ListingTag.fromMap(data: e)).toList(),
      nightData: nightData.map((e) => NightData.fromMap(data: e)).toList(),
    );
  }

}

class ListingLocation{
  LatLng latLng;
  String fullAddress;
  String remark;

  ListingLocation({
    required this.latLng,
    required this.fullAddress,
    required this.remark
  });

  factory ListingLocation.fromMap({required Map<String,dynamic> data}){
    return ListingLocation(
      latLng: LatLng(
        double.tryParse(data["lat"].toString())??0,
        double.tryParse(data["lng"].toString())??0
      ),
      remark: data["remark"].toString(),
      fullAddress: data["fullAddress"].toString(),
    );
  }

}

class ListingOnPlace{
  ListingPlace listingPlace;
  List<String> images;

  ListingOnPlace({
    required this.listingPlace,
    required this.images,
  });

  factory ListingOnPlace.fromMap({required Map<String,dynamic> data}){
    return ListingOnPlace(
      listingPlace: ListingPlace(
        id: data["listingPlace"]["id"].toString(),
        name: data["listingPlace"]["name"].toString(),
      ),
      images: data["imageList"]??[]
    );
  }

}

class ListingOnAttribute{
  ListingAttribute listingAttribute;
  int quantity;

  ListingOnAttribute({
    required this.listingAttribute,
    required this.quantity,
  });

  factory ListingOnAttribute.fromMap({required Map<String,dynamic> data}){
    return ListingOnAttribute(
      listingAttribute: ListingAttribute(
        id: data["listingAttribute"]["id"].toString(),
        name: data["listingAttribute"]["name"].toString(),
        description: data["listingAttribute"]["description"].toString()
      ),
      quantity: int.tryParse(data["quantity"].toString())??0
    );
  }
}

class NightData{

  DateTime date;
  List<NightFeeModel> nightFees;

  NightData({
    required this.date,
    required this.nightFees,
  });

  factory NightData.fromMap({required Map<String,dynamic> data}){

    Iterable iterable = data["listingPrice"]??[];

    return NightData(
      date: DateTime.tryParse(data["date"].toString())??DateTime(2020),
      nightFees: iterable.map((e) {
        return NightFeeModel.fromMap(data: e);
      }).toList()
    );
  }

}