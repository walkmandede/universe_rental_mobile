import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universe_rental/constants/app_constants.dart';
import 'package:universe_rental/web_data_entry/listing_offers/list/c_list.dart';
import 'package:universe_rental/web_data_entry/listing_offers/new/v_add.dart';

class ListingOfferListPage extends StatefulWidget {
  const ListingOfferListPage({super.key});

  @override
  State<ListingOfferListPage> createState() => _ListingOfferListPageState();
}

class _ListingOfferListPageState extends State<ListingOfferListPage> {
  final controller = Get.put(ListingOfferListController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<ListingOfferListController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1)),
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Listing Offers List Page"),
            actions: [
              IconButton(
                  onPressed: () {
                    Get.to(() => const ListingOfferAddPage());
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
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: SvgPicture.string(
                            eachData.icon,
                          ),
                        ),
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
                                )
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
