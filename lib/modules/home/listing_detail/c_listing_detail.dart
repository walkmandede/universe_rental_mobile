
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListingDetailController extends GetxController{

  ValueNotifier<int> currentShownPageIndex = ValueNotifier(0);

  @override
  void onInit() {
    //
    super.onInit();
  }
  
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
  
  Future<void> initLoad({required String id,required int shownPageIndex}) async{
    currentShownPageIndex.value = shownPageIndex;
  }

  void onPageChanged(int index){
    currentShownPageIndex.value = index;
  }
  
}
