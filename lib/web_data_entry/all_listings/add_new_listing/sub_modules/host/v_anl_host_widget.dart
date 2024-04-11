import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe_rental/web_data_entry/all_listings/add_new_listing/c_add_new_listing.dart';

class AnlHostWidget extends StatefulWidget {
  const AnlHostWidget({super.key});

  @override
  State<AnlHostWidget> createState() => _AnlHostWidgetState();
}

class _AnlHostWidgetState extends State<AnlHostWidget> {
  @override
  Widget build(BuildContext context) {
    AddNewListingController controller = Get.find();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Host Info",style: TextStyle(fontSize: 20),),
        TextField(
          controller: controller.txtHostName,
          decoration: const InputDecoration(labelText: "Name"),
        ),
      ],
    );
  }
}
