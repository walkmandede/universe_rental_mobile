import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe_rental/web_data_entry/all_listings/add_new_listing/v_add_new_listing_controller.dart';
import 'package:universe_rental/web_data_entry/all_listings/listing_list/c_all_listing_controller.dart';
import 'package:universe_rental/web_data_entry/all_listings/listing_list_detail/v_listing_list_detail.dart';

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

  final _controller = Get.put(AllListingController());
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
        body: ValueListenableBuilder(
          valueListenable: _controller.allData,
          builder: (context, value, child) => Column(
            children: [
              ..._controller.allData.value.map((listingData) => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: InkWell(
                      onTap: () {
                        Get.to(() => ListingDetailPage(
                              listingData: listingData,
                            ));
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Column(
                            children: [
                              Text("Name ${listingData.title}"),
                              Row(
                                children: [
                                  Text("Subtitle ${listingData.subTitle}"),
                                  const Spacer(),
                                  Text("Location ${listingData.about}")
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
