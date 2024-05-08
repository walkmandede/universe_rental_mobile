// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:universe_rental/constants/app_constants.dart';
import 'package:universe_rental/constants/app_functions.dart';
import 'package:universe_rental/services/others/extensions.dart';
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
  ValueNotifier<List<LatLng>> addedPoiPoints = ValueNotifier([]);
  ValueNotifier<List<FaryPickUpPoint>> addedPickUpPoints = ValueNotifier([]);

  TextEditingController txtPoiNameEn = TextEditingController();
  TextEditingController txtPoiNameMm = TextEditingController();

  TextEditingController txtPickUpPointNameEn = TextEditingController();
  TextEditingController txtPickUpPointNameMm = TextEditingController();

  // String baseUrl = "http://192.168.1.44:9003";
  String baseUrl = "https://poi.farytaxi.com";
  double currentZoomLevel = 17.5;
  double maxZoomForPolygon = 17.5;
  ValueNotifier<bool> xShowPolygon = ValueNotifier(false);

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

  void polygonShowCheck(){
    currentZoomLevel = mapController.camera.zoom;
    if(currentZoomLevel>=maxZoomForPolygon){
      if(!xShowPolygon.value){
        xShowPolygon.value = true;
        xShowPolygon.notifyListeners();
      }
    }
    else{
      if(xShowPolygon.value){
        xShowPolygon.value = false;
        xShowPolygon.notifyListeners();
      }
    }
  }

  Future<void> updateData() async{
    xFetching.value = true;
    xFetching.notifyListeners();

    try{
      final topLeft = mapController.camera.visibleBounds.northWest;
      final botRight = mapController.camera.visibleBounds.southEast;
      final response = await ApiService().get(
        endPoint: "$baseUrl/poi"
            "?topLeftLat=${topLeft.latitude}"
            "&topLeftLng=${topLeft.longitude}"
            "&bottomRightLat=${botRight.latitude}"
            "&bottomRightLng=${botRight.longitude}",
        xBaseUrlIncluded: false,
      );

      polygonShowCheck();

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
      }
      else{

      }
    }
    catch(e){
      superPrint(e);
      null;
    }

    xFetching.value = false;
    xFetching.notifyListeners();
  }

  void clearData(){
    addedPoiPoints.value.clear();
    addedPoiPoints.notifyListeners();
    addedPickUpPoints.value.clear();
    addedPickUpPoints.notifyListeners();
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
              poiId: "",
              latLng: point,
              nameEn: txtPickUpPointNameEn.text,
              nameMm: txtPickUpPointNameMm.text
            );
            addedPickUpPoints.value.add(faryPickUpPoint);
            addedPickUpPoints.notifyListeners();
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
    addedPickUpPoints.value.remove(faryPickUpPoint);
    addedPickUpPoints.notifyListeners();
  }

  void addPoiPoint({required LatLng latLng}){
    addedPoiPoints.value.add(latLng);
    addedPoiPoints.notifyListeners();
  }

  void removePoiPoint({required LatLng latLng}){
    addedPoiPoints.value.remove(latLng);
    addedPoiPoints.notifyListeners();
  }

  void onClickSave() async{
    if(addedPoiPoints.value.length<2){
      DialogService().showTransactionDialog(text: "There must be at least 2 poi points");
    }
    else if(addedPickUpPoints.value.isEmpty){
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
                    "polygons" : addedPoiPoints.value.map((e) => {
                      "latitude" : e.latitude,
                      "longitude" : e.longitude
                    }).toList(),
                    "pickUpPoints" : addedPickUpPoints.value.map((e) {
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
                  superPrint(payload);
                  superPrint(apiResponse.bodyData);
                  if(apiResponse.xSuccess){
                    clearData();
                    updateData();
                  }
                  else{
                    DialogService().showSnack(title: "Something went wrong", message: apiResponse.message);
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

  Future<void> onClickDeletePoi({required FaryPoi faryPoi}) async{
    DialogService().showTransactionDialog(
      text: "Are you sure you want to delete ${faryPoi.nameEn}(${faryPoi.nameMm})?",
      onClickYes: () async{
        await Future.delayed(const Duration(milliseconds: 500));
        DialogService().showLoadingDialog();
        final response = await ApiService().delete(
          endPoint: "$baseUrl/poi/${faryPoi.id}",
          xBaseUrlIncluded: false
        );
        DialogService().dismissDialog();
        superPrint(response!.body);
        final apiResponse = ApiService().validateResponse(response: response);
        if(apiResponse.xSuccess){
          clearData();
          updateData();
        }
        else{
          DialogService().showSnack(title: "Something went wrong!", message: apiResponse.message);
        }
      },
    );
  }

  Future<void> onClickHelp() async{
    Get.bottomSheet(
      Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: AppConstants.basePadding,
          vertical: AppConstants.basePadding,
        ),
        decoration: const BoxDecoration(
          color: Colors.white
        ),
        child: const Column(
          children: [
            Text(
              """
              အညွှန်း
              --------
              အပြာရောင် = အသစ်ထည့် / အစိမ်းရောင် = ထည့်ပြီးသား data
              
              အသစ်ထည့်ရန်
              -----------
              မြေပုံအလွတ်ကို တစ်ချက်ထိရင် boundary ဆွဲမည်
              ဖိထားလျှင် pick up ပွိုင့် ထည့်မည်
              နှစ်ချက်ဆက်တိုင်နှိပ်လျှင် ဖျက်မည်
              
              
              ထည့်ပြီးသားဖျက်ရန်
              --------------
              အစိမ်းရောင် pickup point တစ်ခုကို နှစ်ချက်ဆက်တိုက်နှိပ်ပါ
              """,
              textAlign: TextAlign.center,
            )
          ],
        ),
      )
    );
  }

  Future<void> onClickSearch() async{
    TextEditingController txtSearch = TextEditingController(text: "");
    Get.bottomSheet(
      Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: AppConstants.basePadding,
          vertical: AppConstants.basePadding,
        ),
        decoration: const BoxDecoration(
          color: Colors.white
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: txtSearch,
              decoration: const InputDecoration(
                label: Text(
                  "Enter location in lat lng comma format (16.125156,96.216126)",
                  textAlign: TextAlign.center,
                )
              ),
            ),
            10.heightBox(),
            ElevatedButton(onPressed: () {
              try{

                final locationString = txtSearch.text;
                final locationStringArray = locationString.split(',');

                if(locationStringArray.length>1){
                  LatLng location = LatLng(double.parse(locationStringArray.first), double.parse(locationStringArray.last));
                  superPrint(location);
                  Get.back();
                  mapController.move(location, currentZoomLevel);
                }
                else{
                  throw Error.safeToString("Invalid Lat Lng");
                }


              }
              catch(e){
                DialogService().showSnack(title: "Something went wrong!", message: e.toString());
              }
            }, child: const Text("Move Now"))
          ],
        ),
      )
    );
  }

}
