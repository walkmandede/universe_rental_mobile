// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:universe_rental/constants/app_functions.dart';
import 'package:universe_rental/services/overlays_services/dialog/dialog_service.dart';
import 'package:universe_rental/web_data_entry/fary_poi/bs_fary_pick_up_point.dart';

import '../../services/network_services/api_end_points.dart';
import '../../services/network_services/api_service.dart';
import 'm_fary_poi.dart';

class FaryPoiController extends GetxController{

  Timer? timer;
  ValueNotifier<List<FaryPoi>> shownData = ValueNotifier([]);
  ValueNotifier<List<FaryPickUpPoint>> shownPickUpPoints = ValueNotifier([]);
  ValueNotifier<bool> xFetching = ValueNotifier(false);
  MapController mapController = MapController();
  //entry
  ValueNotifier<List<LatLng>> poiPoints = ValueNotifier([]);
  ValueNotifier<List<FaryPickUpPoint>> pickUpPoints = ValueNotifier([]);

  TextEditingController txtPoiNameEn = TextEditingController();
  TextEditingController txtPoiNameMm = TextEditingController();

  TextEditingController txtPickUpPointNameEn = TextEditingController();
  TextEditingController txtPickUpPointNameMm = TextEditingController();

  // String baseUrl = "http://192.168.1.44:9003";
  String baseUrl = "http://192.168.86.63:9003";

  @override
  void onInit() {
    initLoad();
    super.onInit();
  }
  
  @override
  void onClose() {
    if(timer!=null){
      timer!.cancel();
    }
    super.onClose();
  }
  
  Future<void> initLoad() async{
    await Future.delayed(const Duration(seconds: 2));
    updateData();
  }


  Future<void> onMapMove() async{
    if(timer!=null){
      timer!.cancel();
      resetTimer();
    }
    else{
      resetTimer();
    }
  }

  void resetTimer(){
    timer = Timer(const Duration(milliseconds: 650), () async{
      updateData();
    });
  }

  Future<void> updateData() async{

    log("updating data");

    xFetching.value = true;

    final topLeft = mapController.bounds!.northWest;
    final botRight = mapController.bounds!.southEast;
    final response = await ApiService().get(
      endPoint: "$baseUrl/poi"
          "?topLeftLat=${topLeft.latitude}"
          "&topLeftLng=${topLeft.longitude}"
          "&bottomRightLat=${botRight.latitude}"
          "&bottomRightLng=${botRight.longitude}",
      xBaseUrlIncluded: false,
    );


    shownData.value.clear();
    shownData.notifyListeners();
    shownPickUpPoints.value.clear();
    shownPickUpPoints.notifyListeners();

    final apiResponse = ApiService().validateResponse(response: response);
    if(apiResponse.xSuccess){

      Iterable iterable = apiResponse.bodyData["_data"]??[];
      for(final each in iterable){
        final data = FaryPoi.fromApi(data: each);
        shownData.value.add(data);
        shownPickUpPoints.value.addAll(
          data.faryPickUpPoints
        );
      }
      shownData.notifyListeners();
      shownPickUpPoints.notifyListeners();
      superPrint(shownPickUpPoints.value.map((e) => e.latLng.toJson()).toList());
    }
    else{

    }

    try{

    }
    catch(e){
      superPrint(e);
      null;
    }

    xFetching.value = false;
  }

  void clearData(){
    poiPoints.value.clear();
    poiPoints.notifyListeners();
    pickUpPoints.value.clear();
    pickUpPoints.notifyListeners();
    txtPickUpPointNameEn.clear();
    txtPickUpPointNameMm.clear();
    txtPoiNameEn.clear();
    txtPoiNameMm.clear();
  }

  void addPickUpPoint(LatLng point){
    Get.bottomSheet(
      FaryPickUpPointBottomSheet(
        label: "Please fill a name for that pick up point",
        txtCtrlEn: txtPickUpPointNameEn,
        txtCtrlMm: txtPickUpPointNameMm,
        onClickSubmit: () {
          if(txtPickUpPointNameEn.text.isEmpty || txtPickUpPointNameMm.text.isEmpty){
            DialogService().showTransactionDialog(text: "Please add pick up point name");
          }
          else{
            FaryPickUpPoint faryPickUpPoint = FaryPickUpPoint(
              id: '',
              latLng: point,
              nameEn: txtPickUpPointNameEn.text,
              nameMm: txtPickUpPointNameMm.text
            );
            pickUpPoints.value.add(faryPickUpPoint);
            pickUpPoints.notifyListeners();
            txtPickUpPointNameEn.clear();
            txtPickUpPointNameMm.clear();
            Get.back();
          }
        },
      ),
      backgroundColor: Colors.transparent
    );
  }

  void removePickUpPoints({required FaryPickUpPoint faryPickUpPoint}){
    pickUpPoints.value.remove(faryPickUpPoint);
    pickUpPoints.notifyListeners();
  }

  void addPoiPoint({required LatLng latLng}){
    poiPoints.value.add(latLng);
    poiPoints.notifyListeners();
  }

  void removePoiPoint({required LatLng latLng}){
    poiPoints.value.remove(latLng);
    poiPoints.notifyListeners();
  }

  void onClickSave() async{
    if(poiPoints.value.length<2){
      DialogService().showTransactionDialog(text: "There must be at least 2 poi points");
    }
    else if(pickUpPoints.value.isEmpty){
      DialogService().showTransactionDialog(text: "There must be at least 1 pick up points");
    }
    else{
      Get.bottomSheet(
          FaryPickUpPointBottomSheet(
            label: "Please fill a name for that poi data",
            txtCtrlEn: txtPoiNameEn,
            txtCtrlMm: txtPoiNameMm,
            onClickSubmit: () async{
              if(txtPoiNameEn.text.isEmpty || txtPoiNameMm.text.isEmpty){
                DialogService().showTransactionDialog(text: "Please add poi name");
              }
              else{
                Get.back();
                DialogService().showLoadingDialog();
                try{
                  final payload = {
                    "nameEn" : txtPoiNameEn.text,
                    "nameMm" : txtPoiNameMm.text,
                    "polygons" : poiPoints.value.map((e) => {
                      "lat" : e.latitude,
                      "lng" : e.longitude
                    }).toList(),
                    "pickUpPoints" : pickUpPoints.value.map((e) {
                      return {
                        "nameEn" : e.nameEn,
                        "nameMm" : e.nameMm,
                        "latitude" : e.latLng.latitude,
                        "longitude" : e.latLng.longitude,
                      };
                    }).toList()
                  };
                  log(jsonEncode(payload));
                  final response = await ApiService().post(
                    endPoint: "$baseUrl/poi",
                    xBaseUrlIncluded: false,
                    data: payload,
                  );


                  final apiResponse = ApiService().validateResponse(response: response);

                  if(apiResponse.xSuccess){
                    clearData();
                    updateData();
                  }
                  else{

                  }

                }
                catch(e){
                  null;
                }
                DialogService().dismissDialog();
              }
            },
          ),
          backgroundColor: Colors.transparent
      );
    }
  }

}
