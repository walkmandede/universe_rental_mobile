import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe_rental/constants/app_functions.dart';
import 'package:universe_rental/services/network_services/api_end_points.dart';
import 'package:universe_rental/services/network_services/api_service.dart';
import 'package:universe_rental/services/overlays_services/dialog/dialog_service.dart';
import 'package:universe_rental/web_data_entry/listing_offers/list/c_list.dart';
import 'package:universe_rental/web_data_entry/listing_tags/list/c_list.dart';

class ListingOfferAddController extends GetxController{

  TextEditingController txtName = TextEditingController(text: "");
  TextEditingController txtSvg = TextEditingController(text: "");
  ValueNotifier<String?> svgData = ValueNotifier(null);

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
    txtSvg.addListener(() {
      svgData.value = txtSvg.text;
    });
  }

  Future<void> onClickSave() async{
    if(txtName.text.isEmpty || svgData.value == null){
      DialogService().showSnack(title: "Error", message: "Fill all data");
    }
    else{
      DialogService().showLoadingDialog();
      Response? response = await ApiService().post(
        endPoint: ApiEndPoints.dataEntryOffer,
        data: {
          "name": txtName.text,
          "icon": svgData.value
        }
      );
      DialogService().dismissDialog();
      final apiResponse = ApiService().validateResponse(
          response: response,
      );

      if(apiResponse.xSuccess){
        Get.back();
        ListingOfferListController controller = Get.find();
        controller.updateData();
      }
      else{
        DialogService().showTransactionDialog(text: apiResponse.message);
      }

    }
  }

}
