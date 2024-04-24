import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universe_rental/constants/app_constants.dart';
import 'package:universe_rental/web_data_entry/currency/list/c_list.dart';
import 'package:universe_rental/web_data_entry/listing_attribute/list/c_list.dart';
import 'package:universe_rental/web_data_entry/listing_attribute/list/c_list.dart';
import 'package:universe_rental/web_data_entry/listing_attribute/new/v_add.dart';
import 'package:universe_rental/web_data_entry/listing_offers/new/v_add.dart';
import 'package:universe_rental/web_data_entry/listing_place/list/c_list.dart';
import 'package:universe_rental/web_data_entry/listing_place/list/c_list.dart';
import 'package:universe_rental/web_data_entry/listing_place/new/v_add.dart';

class ListingAttributeListPage extends StatefulWidget {
  const ListingAttributeListPage({super.key});

  @override
  State<ListingAttributeListPage> createState() =>
      _ListingAttributeListPageState();
}

class _ListingAttributeListPageState extends State<ListingAttributeListPage> {
  final controller = Get.put(ListingAttributeListController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<ListingAttributeListController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1)),
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Listing Attribute List Page"),
            actions: [
              IconButton(
                  onPressed: () {
                    Get.to(() => const ListingAttributeAddPage());
                  },
                  icon: const Icon(Icons.add))
            ],
          ),
          body: ValueListenableBuilder(
            valueListenable: controller.shownData,
            builder: (context, shownData, child) {
              return ListView.builder(
                itemCount: shownData.length,
                itemBuilder: (context, index) {
                  final eachData = shownData[index];
                  return Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(AppConstants.basePadding),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppConstants.basePadding,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  eachData.name,
                                ),
                                Text(
                                  eachData.description,
                                ),
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            controller.deleteData(data: eachData);
                          },
                          icon: const Icon(Icons.delete),
                        )
                      ],
                    ),
                  );
                },
              );
            },
          )),
    );
  }
}
