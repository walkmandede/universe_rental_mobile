
import 'dart:convert';

import 'package:latlong2/latlong.dart';
import 'package:universe_rental/constants/app_functions.dart';

class FaryPoi{

  String id;
  String nameEn;
  String nameMm;
  List<FaryPickUpPoint> faryPickUpPoints;
  List<LatLng> poiPoints;

  FaryPoi({
    required this.id,
    required this.nameEn,
    required this.nameMm,
    required this.faryPickUpPoints,
    required this.poiPoints
  });

  factory FaryPoi.fromApi({required Map<String,dynamic> data}){
    Iterable rawPolygon = data["polygon"]??[];
    Iterable rawPickUpPoints = data["pickUpPoint"]??[];
    return FaryPoi(
      id: data["id"].toString(),
      nameMm: data["nameMm"].toString(),
      nameEn: data["nameEn"].toString(),
      poiPoints: rawPolygon.map((rawEach) {
        return LatLng(
          double.tryParse(rawEach["latitude"].toString())??0,
          double.tryParse(rawEach["longitude"].toString())??0,
        );
      }).toList(),
      faryPickUpPoints: rawPickUpPoints.map((e) {
        return FaryPickUpPoint(
          id: e["id"].toString(),
          poiId: data["id"].toString(),
          nameEn: e["nameEn"].toString(),
          nameMm: e["nameMm"].toString(),
          latLng: LatLng(
            double.tryParse(e['latitude'].toString())??0,
            double.tryParse(e['longitude'].toString())??0,
          )
        );
      }).toList()
    );
  }

}

class FaryPickUpPoint{

  String id;
  String poiId;
  String nameEn;
  String nameMm;
  LatLng latLng;

  FaryPickUpPoint({
    required this.id,
    required this.poiId,
    required this.nameEn,
    required this.nameMm,
    required this.latLng
  });

}