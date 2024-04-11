import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:universe_rental/constants/app_functions.dart';
import 'package:universe_rental/services/others/extensions.dart';
import 'package:universe_rental/web_data_entry/_common/controllers/c_data_controller.dart';
import 'package:universe_rental/web_data_entry/all_listings/add_new_listing/c_add_new_listing.dart';

class AnlListingPlacesWidget extends StatefulWidget {
  const AnlListingPlacesWidget({super.key});

  @override
  State<AnlListingPlacesWidget> createState() => _AnlListingPlacesWidgetState();
}

class _AnlListingPlacesWidgetState extends State<AnlListingPlacesWidget> {
  @override
  Widget build(BuildContext context) {
    AddNewListingController controller = Get.find();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Listing Places (* Double Tap To Remove)",style: TextStyle(fontSize: 15),),
        10.heightBox(),
        GetBuilder<DataEntryDataController>(
          builder: (dataEntryDataController) {
            return ValueListenableBuilder(
              valueListenable: controller.listingPlacesMap,
              builder: (context, listingPlacesMap, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: dataEntryDataController.allPlaces.value.map((e) {
                    List<File> thatPlaceImages = listingPlacesMap[e]??[];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                                e.name
                            ),
                            10.widthBox(),
                            IconButton(onPressed: () async{
                              final result = await AppFunctions().pickImage();
                              if(result!=null){
                                thatPlaceImages.add(result);
                                controller.listingPlacesMap.value[e] = thatPlaceImages;
                                controller.listingPlacesMap.notifyListeners();
                              }
                            }, icon: const Icon(Icons.add))
                          ],
                        ),
                        Wrap(
                          runSpacing: 10,
                          spacing: 10,
                          children: thatPlaceImages.map((eachImage) {
                            return GestureDetector(
                              onDoubleTap: () {
                                thatPlaceImages.remove(eachImage);
                                controller.listingPlacesMap.value[e] = thatPlaceImages;
                                controller.listingPlacesMap.notifyListeners();
                              },
                              child: Container(
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(
                                  border: Border.all()
                                ),
                                child: Image.file(
                                  eachImage,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Center(child: Icon(Icons.error),);
                                  },
                                ),
                              ),
                            );
                          }).toList(),
                        )
                      ],
                    );
                  }).toList(),
                );
              },
            );
          },
        )
      ],
    );
  }
}
