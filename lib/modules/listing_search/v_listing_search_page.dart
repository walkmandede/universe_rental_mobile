import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:universe_rental/constants/app_constants.dart';
import 'package:universe_rental/constants/app_functions.dart';
import 'package:universe_rental/modules/home/explore/sub_widgets/header/w_explore_search_bar.dart';
import 'package:universe_rental/modules/listing_search/c_listing_search.dart';
import 'package:universe_rental/services/others/extensions.dart';
import '../../constants/app_colors.dart';

class ListingSearchPage extends StatelessWidget {
  final Size barSize;
  const ListingSearchPage({super.key, required this.barSize});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ListingSearchController());
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) async {},
      child: MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1)),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.black.withOpacity(0.3),
          body: Column(
            children: [
              Container(
                width: double.infinity,
                height: (Get.mediaQuery.padding.top),
                decoration: BoxDecoration(color: AppColors.white),
              ),
              ExploreSearchBar(
                onTap: () {},
                onChangeText: (p0) {},
                txtCtrl: controller.txtSearch,
                xReadOnly: false,
                barSize: barSize,
              ),
              Flexible(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.vertical(
                          bottom:
                              Radius.circular(AppConstants.baseBorderRadius))),
                  child: ValueListenableBuilder(
                    valueListenable: controller.shownData,
                    builder: (context, shownData, child) {
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: shownData.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final each = shownData[index];
                          return GestureDetector(
                            onTap: () {
                              vibrateNow();
                              controller.onClickEachResult(listingDetail: each);
                            },
                            child: Container(
                              width: min(Get.width * 0.175, 100),
                              height: min(Get.width * 0.175, 100),
                              decoration: const BoxDecoration(
                                  color: Colors.transparent),
                              padding: EdgeInsets.symmetric(
                                horizontal: AppConstants.basePadding,
                                vertical: 10,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Hero(
                                      tag: "imageList${each.id}",
                                      child: AspectRatio(
                                          aspectRatio: 1,
                                          child: Builder(
                                            builder: (context) {
                                              if (each.imageList.isEmpty) {
                                                return const Center(
                                                  child: Icon(Icons
                                                      .image_not_supported_rounded),
                                                );
                                              } else {
                                                return CachedNetworkImage(
                                                  imageUrl: each.imageList.first
                                                      .getServerPath(),
                                                  errorWidget:
                                                      (context, url, error) {
                                                    return const Center(
                                                      child: Icon(Icons
                                                          .image_not_supported_rounded),
                                                    );
                                                  },
                                                  fit: BoxFit.cover,
                                                );
                                              }
                                            },
                                          )),
                                    ),
                                  ),
                                  10.widthBox(),
                                  Expanded(
                                    child: Text(
                                      each.title,
                                      style: TextStyle(
                                          fontSize: AppConstants.fontSizeM),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration:
                          const BoxDecoration(color: Colors.transparent),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
