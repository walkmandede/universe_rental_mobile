import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:universe_rental/constants/app_functions.dart';
import 'package:universe_rental/services/others/extensions.dart';
import 'package:universe_rental/web_data_entry/_common/controllers/c_data_controller.dart';
import 'package:universe_rental/web_data_entry/all_listings/add_new_listing/c_add_new_listing.dart';

class AnlAttributesWidget extends StatefulWidget {
  const AnlAttributesWidget({super.key});

  @override
  State<AnlAttributesWidget> createState() => _AnlAttributesWidgetState();
}

class _AnlAttributesWidgetState extends State<AnlAttributesWidget> {
  @override
  Widget build(BuildContext context) {
    AddNewListingController controller = Get.find();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Attributes",style: TextStyle(fontSize: 15),),
        10.heightBox(),
        GetBuilder<DataEntryDataController>(
          builder: (dedController) {
            return Wrap(
              spacing: 10,
              runSpacing: 10,
              children: dedController.allAttributes.value.map((e) {
                return ValueListenableBuilder(
                  valueListenable: controller.listingAttributesMap,
                  builder: (context, listingAttributesMap, child) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 100,
                          child: TextField(
                            controller: TextEditingController(text: "0"),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            onChanged: (value) {
                              int? qty = int.tryParse(value);
                              if(qty!=null){
                                controller.listingAttributesMap.value[e] = qty;
                                // controller.listingAttributesMap.notifyListeners();
                                superPrint(listingAttributesMap);
                              }
                            },
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: e.name,
                            ),
                          ),
                        ),
                        10.widthBox(),
                      ],
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
