import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe_rental/services/others/extensions.dart';
import 'package:universe_rental/web_data_entry/_common/controllers/c_data_controller.dart';
import 'package:universe_rental/web_data_entry/all_listings/add_new_listing/c_add_new_listing.dart';

class AnlTypeWidget extends StatefulWidget {
  const AnlTypeWidget({super.key});

  @override
  State<AnlTypeWidget> createState() => _AnlTypeWidgetState();
}

class _AnlTypeWidgetState extends State<AnlTypeWidget> {
  @override
  Widget build(BuildContext context) {
    AddNewListingController controller = Get.find();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Type",style: TextStyle(fontSize: 15),),
        10.heightBox(),
        GetBuilder<DataEntryDataController>(
          builder: (dedController) {
            return Wrap(
              spacing: 10,
              runSpacing: 10,
              children: dedController.allTypes.value.map((e) {
                return ValueListenableBuilder(
                  valueListenable: controller.listingType,
                  builder: (context, listingType, child) {
                    bool xSelected = e == listingType;
                    return GestureDetector(
                      onTap: () {
                        controller.listingType.value = e;
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.transparent
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(xSelected?Icons.radio_button_checked_rounded:Icons.radio_button_unchecked_rounded),
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
