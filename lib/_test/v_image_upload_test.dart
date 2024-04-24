// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:universe_rental/constants/app_constants.dart';
import 'package:universe_rental/constants/app_functions.dart';
import 'package:universe_rental/modules/_common/controllers/c_data_controller.dart';
import 'package:universe_rental/services/network_services/api_service.dart';
import 'package:universe_rental/services/others/extensions.dart';
import 'package:universe_rental/services/overlays_services/dialog/dialog_service.dart';

class ImageUploadTestPage extends StatefulWidget {
  const ImageUploadTestPage({super.key});

  @override
  State<ImageUploadTestPage> createState() => _ImageUploadTestPageState();
}

class _ImageUploadTestPageState extends State<ImageUploadTestPage> {

  ValueNotifier<File?> imageFile = ValueNotifier(null);

  Future<void> uploadImage() async{
    final result = await AppFunctions().pickImage();
    if(result!=null){
      imageFile.value = result;
      imageFile.notifyListeners();
    }
  }

  Future<void> onClickSave() async{
    Get.put(DataController());
    if(imageFile.value!=null){
      final rawImage = await imageFile.value!.readAsBytes();
      final extension = imageFile.value!.path.split(".").last;
      final base64Image = "data:image/$extension;${base64.encode(rawImage)}";
      print(base64Image.substring(0,100));
      // superPrint(base64Image);
      DialogService().showLoadingDialog();
      final response = await ApiService().post(
        endPoint: "listing/img-test",
        data: {
          // "images" : "-"
          "images" : [
            base64Image
          ]
        },
        xNeedToken: false,
      );
      DialogService().dismissDialog();
      if(response==null){
        log("Response is null");
      }
      else{
        superPrint(response.bodyString,title: response.statusCode);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox.expand(
        child: Padding(
          padding: EdgeInsets.all(AppConstants.basePadding),
          child: Column(
            children: [
              SizedBox(
                width: Get.width * 0.2,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: GestureDetector(
                    onTap: () {
                      uploadImage();
                    },
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        color: Colors.transparent,
                      ),
                      child: ValueListenableBuilder(
                        valueListenable: imageFile,
                        builder: (context, data, child) {
                          if(data==null){
                            return const Center(
                              child: Icon(Icons.error),
                            );
                          }
                          else{
                            return Image.file(data);
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
              10.heightBox(),
              ElevatedButton(onPressed: () {
                onClickSave();
              }, child: const Text("Save"))
            ],
          ),
        ),
      ),
    );
  }

}
