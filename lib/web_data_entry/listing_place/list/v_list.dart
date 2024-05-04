import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe_rental/constants/app_constants.dart';
import 'package:universe_rental/web_data_entry/listing_place/list/c_list.dart';
import 'package:universe_rental/web_data_entry/listing_place/new/v_add.dart';

class ListingPlaceListPage extends StatefulWidget {
  const ListingPlaceListPage({super.key});

  @override
  State<ListingPlaceListPage> createState() => _ListingPlaceListPageState();
}

class _ListingPlaceListPageState extends State<ListingPlaceListPage> {
  final controller = Get.put(ListingPlaceListController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<ListingPlaceListController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1)),
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Listing Place List Page"),
            actions: [
              IconButton(
                  onPressed: () {
                    Get.to(() => const ListingPlaceAddPage());
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
                                  eachData.id,
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
