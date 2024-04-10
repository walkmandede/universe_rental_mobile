import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe_rental/web_data_entry/all_listings/add_new_listing/c_add_new_listing.dart';

class AnlDataInfoWidget extends StatefulWidget {
  const AnlDataInfoWidget({super.key});

  @override
  State<AnlDataInfoWidget> createState() => _AnlDataInfoWidgetState();
}

class _AnlDataInfoWidgetState extends State<AnlDataInfoWidget> {
  @override
  Widget build(BuildContext context) {
    AddNewListingController controller = Get.find();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Data Info",style: TextStyle(fontSize: 20),),
        TextField(
          controller: controller.txtTitle,
          decoration: const InputDecoration(labelText: "Title"),
        ),
        TextField(
          controller: controller.txtSubtitle,
          decoration: const InputDecoration(labelText: "Subtitle"),
        ),
        TextField(
          controller: controller.txtAbout,
          decoration: const InputDecoration(labelText: "About"),
          maxLines: null,
        ),
      ],
    );
  }
}
