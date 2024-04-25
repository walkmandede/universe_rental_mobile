import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe_rental/constants/app_constants.dart';
import 'package:universe_rental/constants/app_functions.dart';
import 'package:universe_rental/services/others/extensions.dart';
import 'package:universe_rental/web_data_entry/all_listings/add_new_listing/c_add_new_listing.dart';
import 'package:universe_rental/web_data_entry/all_listings/add_new_listing/sub_modules/address/v_anl_address_widget.dart';
import 'package:universe_rental/web_data_entry/all_listings/add_new_listing/sub_modules/attributes/v_anl_attributes_widget.dart';
import 'package:universe_rental/web_data_entry/all_listings/add_new_listing/sub_modules/data_info/v_anl_data_info_widget.dart';
import 'package:universe_rental/web_data_entry/all_listings/add_new_listing/sub_modules/host/v_anl_host_widget.dart';
import 'package:universe_rental/web_data_entry/all_listings/add_new_listing/sub_modules/listing_images/v_anl_listing_images_widget.dart';
import 'package:universe_rental/web_data_entry/all_listings/add_new_listing/sub_modules/listing_places/v_anl_listing_places_widget.dart';
import 'package:universe_rental/web_data_entry/all_listings/add_new_listing/sub_modules/night_data/v_anl_night_data_widget.dart';
import 'package:universe_rental/web_data_entry/all_listings/add_new_listing/sub_modules/offers/v_anl_offers_widget.dart';
import 'package:universe_rental/web_data_entry/all_listings/add_new_listing/sub_modules/tags/v_anl_tags_widget.dart';
import 'package:universe_rental/web_data_entry/all_listings/add_new_listing/sub_modules/type/v_anl_type_widget.dart';

class AddNewListingPage extends StatefulWidget {
  const AddNewListingPage({super.key});

  @override
  State<AddNewListingPage> createState() => _AddNewListingPageState();
}

class _AddNewListingPageState extends State<AddNewListingPage> {
  final controller = Get.put(AddNewListingController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<AddNewListingController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add New Listing Page"),
          actions: [
            IconButton(
              onPressed: () {
                controller.onClickSave();
              },
              icon: const Icon(Icons.save),
            )
          ],
        ),
        body: ListView(
          padding: EdgeInsets.only(
            top: AppConstants.basePadding,
            left: AppConstants.basePadding,
            right: AppConstants.basePadding,
          ),
          children: [
            const AnlDataInfoWidget(),
            divider(),
            const AnlAddressWidget(),
            divider(),
            const AnlHostWidget(),
            divider(),
            const AnlTypeWidget(),
            divider(),
            const AnlTagsWidget(),
            divider(),
            const AnlOffersWidget(),
            divider(),
            const AnlAttributesWidget(),
            divider(),
            const AnlListingImagesWidget(),
            divider(),
            const AnlListingPlacesWidget(),
            divider(),
            const AnlNightDataWidget(),
            divider(),
          ],
        ),
      ),
    );
  }

  Widget divider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppConstants.basePadding),
      child: const Divider(),
    );
  }
}
