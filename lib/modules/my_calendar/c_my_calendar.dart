
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_functions.dart';

class MyCalendarController extends GetxController{

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

  Future<void> initLoad() async{

  }


  double getEachCardOccupiedAmount({
    required double av,
    required DateTime thatDate,
    required DateTimeRange dateRange
  }){
    double result = 0;
    try{
      final dateList = AppFunctions().getBetweenDates(dtr: dateRange);
      final betweenDates = dateList.map((e) => e.toString().substring(0,10)).toList();
      final index = betweenDates.indexOf(thatDate.toString().substring(0,10));
      final indexPosition = index/betweenDates.length;
      final eachPortion = 1/betweenDates.length;
      final thatCardMin = indexPosition;
      final thatCardMax = indexPosition+eachPortion;

      if(av<=thatCardMin){
        result = 0;
      }
      else if(av>=thatCardMax){
        result = 1;
      }
      else{
        final toSub = eachPortion * index;
        final specificAv = av-toSub;
        result = 4 * specificAv;
      }
    }
    catch(e){
      null;
    }
    return result;
  }

}
