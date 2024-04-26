import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:universe_rental/web_data_entry/all_listings/add_new_listing/v_add_new_listing_controller.dart';
import 'package:universe_rental/web_data_entry/all_listings/listing_detail/c_listing_detail_controller.dart';
import 'package:universe_rental/web_data_entry/all_listings/listing_detail/v_listing_detail_page.dart';
import 'package:universe_rental/web_data_entry/all_listings/listing_list/c_all_listing_controller.dart';
import 'package:universe_rental/web_data_entry/all_listings/m_listing_list_model.dart';
import 'package:universe_rental/web_data_entry/all_listings/m_listing_model.dart';

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
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("All Listing Page"),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(() => const AddNewListingPage());
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: SingleChildScrollView(
          child: ValueListenableBuilder(
              valueListenable: controller.allData,
              builder: (context, data, child) => Column(
                    children: [
                      ...data.map((e) {
                        ListingListModel _data = e;
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => ListingDetailPage(),
                                arguments: {"id": e.id});
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 10,
                                  child: ListTile(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side:
                                          const BorderSide(color: Colors.black),
                                    ),
                                    title: Text(_data.id),
                                    subtitle: Column(
                                      children: [
                                        Text(_data.title),
                                        Text(_data.address)
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: IconButton(
                                    onPressed: () {
                                      controller.deleteData(_data.id);
                                    },
                                    icon: const Icon(Icons.delete),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }).toList()
                    ],
                  )),
        ),
      ),
    );
  }
}
