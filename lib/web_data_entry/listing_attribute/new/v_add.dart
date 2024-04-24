import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe_rental/constants/app_constants.dart';
import 'package:universe_rental/services/others/extensions.dart';
import 'package:universe_rental/web_data_entry/currency/new/c_add.dart';
import 'package:universe_rental/web_data_entry/listing_attribute/new/c_add.dart';
import 'package:universe_rental/web_data_entry/listing_attribute/new/c_add.dart';
import 'package:universe_rental/web_data_entry/listing_offers/new/c_add.dart';
import 'package:universe_rental/web_data_entry/listing_place/new/c_add.dart';
import 'package:universe_rental/web_data_entry/listing_place/new/c_add.dart';
import 'package:universe_rental/web_data_entry/listing_tags/new/c_add.dart';

class ListingAttributeAddPage extends StatefulWidget {
  const ListingAttributeAddPage({super.key});

  @override
  State<ListingAttributeAddPage> createState() =>
      _ListingAttributeAddPageState();
}

class _ListingAttributeAddPageState extends State<ListingAttributeAddPage> {
  final controller = Get.put(ListingAttributeAddController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<ListingAttributeAddController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Listing Attribute Add Page"),
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
                TextField(
                  controller: controller.txtDescription,
                  decoration: const InputDecoration(
                    labelText: "Description",
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
