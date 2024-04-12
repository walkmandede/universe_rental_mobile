
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe_rental/web_data_entry/all_listings/add_new_listing/v_add_new_listing_controller.dart';
import 'package:universe_rental/web_data_entry/all_listings/listing_list/c_all_listing_controller.dart';

class AllListingPage extends StatefulWidget {
  const AllListingPage({super.key});

  @override
  State<AllListingPage> createState() => _AllListingPageState();
}

class _AllListingPageState extends State<AllListingPage> {
  final controller = Get.put(AllListingController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<AllListingController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "All Listing Page"
          ),
          actions: [
            IconButton(onPressed: () {
              Get.to(()=> const AddNewListingPage());
            }, icon: const Icon(Icons.add))
          ],
        ),
      ),
    );
  }
}
