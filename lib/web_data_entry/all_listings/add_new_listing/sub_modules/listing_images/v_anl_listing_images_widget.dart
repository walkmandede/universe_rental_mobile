import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:universe_rental/constants/app_functions.dart';
import 'package:universe_rental/services/others/extensions.dart';
import 'package:universe_rental/web_data_entry/_common/controllers/c_data_controller.dart';
import 'package:universe_rental/web_data_entry/all_listings/add_new_listing/c_add_new_listing.dart';

class AnlListingImagesWidget extends StatefulWidget {
  const AnlListingImagesWidget({super.key});

  @override
  State<AnlListingImagesWidget> createState() => _AnlListingImagesWidgetState();
}

class _AnlListingImagesWidgetState extends State<AnlListingImagesWidget> {
  @override
  Widget build(BuildContext context) {
    AddNewListingController controller = Get.find();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Listing Images (* Double Tap To Remove)",style: TextStyle(fontSize: 15),),
        10.heightBox(),
        ValueListenableBuilder(
          valueListenable: controller.listingImages,
          builder: (context, listingImages, child) {
            return Wrap(
              runSpacing: 10,
              children: [
                ...listingImages.map((e) {
                  return GestureDetector(
                    onDoubleTap: () {
                      controller.listingImages.value.remove(e);
                      controller.listingImages.notifyListeners();
                    },
                    child: Container(
                      width: 200,
                      height: 200,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        border: Border.all()
                      ),
                      child: Image.file(
                        e,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(Icons.error),
                          );
                        },
                      ),
                    ),
                  );
                }).toList(),
                GestureDetector(
                  onTap: () async{
                    superPrint('start');
                    final result = await AppFunctions().pickImage();
                    if(result!=null){
                      try{
                        controller.listingImages.value.add(result);
                        controller.listingImages.notifyListeners();
                      }
                      catch(e){
                        null;
                      }
                    }
                    superPrint(result);
                  },
                  child: Container(
                    width: 200,
                    height: 200,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      color: Colors.transparent
                    ),
                    alignment: Alignment.center,
                    child: const Icon(Icons.add),
                  ),
                )
              ],
            );
          },
        )
      ],
    );
  }
}
