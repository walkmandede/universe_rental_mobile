import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe_rental/web_data_entry/all_listings/add_new_listing/v_add_new_listing_controller.dart';

class AllListingPage extends StatelessWidget {
  const AllListingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Listings Page"),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(()=> const AddNewListingPage());
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: const SizedBox.expand(),
    );
  }
}
