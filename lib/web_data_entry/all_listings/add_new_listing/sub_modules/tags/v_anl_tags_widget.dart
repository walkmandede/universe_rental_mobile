import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe_rental/services/others/extensions.dart';
import 'package:universe_rental/web_data_entry/_common/controllers/c_data_controller.dart';
import 'package:universe_rental/web_data_entry/all_listings/add_new_listing/c_add_new_listing.dart';

class AnlTagsWidget extends StatefulWidget {
  const AnlTagsWidget({super.key});

  @override
  State<AnlTagsWidget> createState() => _AnlTagsWidgetState();
}

class _AnlTagsWidgetState extends State<AnlTagsWidget> {
  @override
  Widget build(BuildContext context) {
    AddNewListingController controller = Get.find();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Tags",style: TextStyle(fontSize: 15),),
        10.heightBox(),
        GetBuilder<DataEntryDataController>(
          builder: (dedController) {
            return Wrap(
              children: dedController.allTags.value.map((e) {
                return ValueListenableBuilder(
                  valueListenable: controller.listingTags,
                  builder: (context, listingTags, child) {
                    bool xSelected = listingTags.contains(e);
                    return GestureDetector(
                      onTap: () {
                        if(xSelected){
                          controller.listingTags.value.remove(e);
                        }
                        else{
                          controller.listingTags.value.add(e);
                        }
                        controller.listingTags.notifyListeners();
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.transparent
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(xSelected?Icons.check_box_rounded:Icons.check_box_outline_blank_rounded),
                            5.widthBox(),
                            Text(e.name),
                            10.widthBox(),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            );
          },
        )
      ],
    );
  }
}
