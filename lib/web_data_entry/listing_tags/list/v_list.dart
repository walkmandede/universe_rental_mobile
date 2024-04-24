import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universe_rental/constants/app_constants.dart';
import 'package:universe_rental/web_data_entry/listing_tags/list/c_list.dart';
import 'package:universe_rental/web_data_entry/listing_tags/new/v_add.dart';

class ListingTagsListPage extends StatefulWidget {
  const ListingTagsListPage({super.key});

  @override
  State<ListingTagsListPage> createState() => _ListingTagsListPageState();
}

class _ListingTagsListPageState extends State<ListingTagsListPage> {
  final controller = Get.put(ListingTagsListController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<ListingTagsListController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1)),
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Listing Tags List Page"),
            actions: [
              IconButton(
                  onPressed: () {
                    Get.to(() => const ListingTagAddPage());
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
