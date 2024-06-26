import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe_rental/services/network_services/api_end_points.dart';
import 'package:universe_rental/services/network_services/api_service.dart';
import 'package:universe_rental/services/overlays_services/dialog/dialog_service.dart';
import 'package:universe_rental/web_data_entry/listing_attribute/list/c_list.dart';

class ListingAttributeAddController extends GetxController {
  TextEditingController txtName = TextEditingController(text: "");
  TextEditingController txtDescription = TextEditingController();

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

  Future<void> onClickSave() async {
    if (txtName.text.isEmpty || txtDescription.text.isEmpty) {
      DialogService().showSnack(title: "Error", message: "Fill all data");
    } else {
      DialogService().showLoadingDialog();
      Response? response = await ApiService().post(
          endPoint: ApiEndPoints.dataEntryAttribute,
          data: {"name": txtName.text, "description": txtDescription.text});
      DialogService().dismissDialog();
      final apiResponse = ApiService().validateResponse(
        response: response,
      );

      if (apiResponse.xSuccess) {
        Get.back();
        ListingAttributeListController controller = Get.find();
        controller.updateData();
      } else {
        DialogService().showTransactionDialog(text: apiResponse.message);
      }
    }
  }
}
