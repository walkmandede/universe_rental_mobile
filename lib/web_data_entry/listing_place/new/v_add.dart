import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe_rental/constants/app_constants.dart';
import 'package:universe_rental/web_data_entry/listing_place/new/c_add.dart';

class ListingPlaceAddPage extends StatefulWidget {
  const ListingPlaceAddPage({super.key});

  @override
  State<ListingPlaceAddPage> createState() => _ListingPlaceAddPageState();
}

class _ListingPlaceAddPageState extends State<ListingPlaceAddPage> {
  final controller = Get.put(ListingPlaceAddController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<ListingPlaceAddController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Listing Place Add Page"),
          actions: [
            IconButton(
              onPressed: () {
                controller.onClickSave();
              },
              icon: const Icon(Icons.save),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(AppConstants.basePadding),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: controller.txtName,
                  decoration: const InputDecoration(
                    labelText: "Name",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
