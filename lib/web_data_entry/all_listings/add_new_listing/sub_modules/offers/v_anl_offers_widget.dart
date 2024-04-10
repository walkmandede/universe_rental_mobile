import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe_rental/services/others/extensions.dart';
import 'package:universe_rental/web_data_entry/_common/controllers/c_data_controller.dart';
import 'package:universe_rental/web_data_entry/all_listings/add_new_listing/c_add_new_listing.dart';

class AnlOffersWidget extends StatefulWidget {
  const AnlOffersWidget({super.key});

  @override
  State<AnlOffersWidget> createState() => _AnlOffersWidgetState();
}

class _AnlOffersWidgetState extends State<AnlOffersWidget> {
  @override
  Widget build(BuildContext context) {
    AddNewListingController controller = Get.find();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Offers",style: TextStyle(fontSize: 15),),
        10.heightBox(),
        GetBuilder<DataEntryDataController>(
          builder: (dedController) {
            return Wrap(
              runSpacing: 10,
              spacing: 10,
              children: dedController.allOffers.value.map((e) {
                return ValueListenableBuilder(
                  valueListenable: controller.listingOffers,
                  builder: (context, listingOffers, child) {
                    bool xSelected = listingOffers.contains(e);
                    return GestureDetector(
                      onTap: () {
                        if(xSelected){
                          controller.listingOffers.value.remove(e);
                        }
                        else{
                          controller.listingOffers.value.add(e);
                        }
                        controller.listingOffers.notifyListeners();
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
