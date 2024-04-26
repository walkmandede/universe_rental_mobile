import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe_rental/constants/app_constants.dart';
import 'package:universe_rental/constants/app_functions.dart';
import 'package:universe_rental/web_data_entry/all_listings/listing_list/v_all_listing_page.dart';
import 'package:universe_rental/web_data_entry/currency/list/v_list.dart';
import 'package:universe_rental/web_data_entry/listing_attribute/list/v_list.dart';
import 'package:universe_rental/web_data_entry/listing_offers/list/v_list.dart';
import 'package:universe_rental/web_data_entry/listing_place/list/v_list.dart';
import 'package:universe_rental/web_data_entry/listing_tags/list/v_list.dart';

import '_common/controllers/c_data_controller.dart';

class WebDataEntryHomePage extends StatefulWidget {
  const WebDataEntryHomePage({super.key});

  @override
  State<WebDataEntryHomePage> createState() => _WebDataEntryHomePageState();
}

class _WebDataEntryHomePageState extends State<WebDataEntryHomePage> {
  ValueNotifier<bool> xLoaded = ValueNotifier(true);

  @override
  void initState() {
    // initLoad();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  // Future<void> initLoad() async {
  //   final controller = Get.put(DataEntryDataController());
  //   await controller.fetchAllData();

  //   xLoaded.value = true;
  // }

  @override
  Widget build(BuildContext context) {
    print("Start Home Page");
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(() => const AllListingPage());
        },
        label: const Text("All Listings Page"),
      ),
      body: ValueListenableBuilder(
        valueListenable: xLoaded,
        builder: (context, xLoaded, child) {
          if (!xLoaded) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              padding: EdgeInsets.all(AppConstants.basePadding),
              children: [
                ["Currency List Page", const CurrencyListPage()],
                [
                  "Listing Attribute List Page",
                  const ListingAttributeListPage()
                ],
                ["Listing Tags List Page", const ListingTagsListPage()],
                ["Listing Offer List Page", const ListingOfferListPage()],
                ["Listing Place List Page", const ListingPlaceListPage()],
              ].map((e) {
                String label = e.first.toString();
                Widget page = e.last as Widget;
                return Container(
                  height: 80,
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => page);
                    },
                    child: Text(label),
                  ),
                );
              }).toList(),
            );
          }
          return Container();
        },
      ),
    );
  }
}
