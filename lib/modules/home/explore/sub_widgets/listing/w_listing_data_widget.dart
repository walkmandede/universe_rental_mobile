import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:universe_rental/constants/app_constants.dart';
import 'package:universe_rental/modules/home/c_home_controller.dart';
import 'package:universe_rental/modules/home/explore/c_explore_controller.dart';
import 'package:universe_rental/modules/home/explore/sub_widgets/listing/c_listing_controller.dart';
import 'package:universe_rental/modules/home/explore/sub_widgets/listing/w_listing_shimmer_widget.dart';
import 'package:universe_rental/services/others/extensions.dart';

import '../../../../../constants/app_colors.dart';
import '../../../../../constants/app_functions.dart';

class ListingDataWidget extends StatelessWidget {
  final Size baseSize;
  const ListingDataWidget({super.key, required this.baseSize});

  @override
  Widget build(BuildContext context) {
    ExploreController controller = Get.find();
    ListingController listingController = Get.find();
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppConstants.basePadding,
          vertical: AppConstants.basePadding),
      child: ValueListenableBuilder(
        valueListenable: controller.xUpdatingShownList,
        builder: (context, xUpdatingShownList, child) {
          if (xUpdatingShownList) {
            return const ListingShimmerWidget();
          } else {
            return ValueListenableBuilder(
              valueListenable: controller.shownListing,
              builder: (context, shownListing, child) {
                if (shownListing.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "There is no data yet",
                        style: TextStyle(
                          color: AppColors.textGrey,
                        ),
                      ),
                    ),
                  );
                } else {
                  return ListView.builder(
                    padding:
                        EdgeInsets.only(bottom: AppConstants.baseNaviBarHeight),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: shownListing.length,
                    itemBuilder: (context, index) {
                      final each = shownListing[index];
                      var dateString = "-";
                      var nightDataString = "-";
                      if (each.nightData.isNotEmpty) {
                        dateString = AppFunctions().getDateRangeString(
                            firstDate: each.nightData.first.date,
                            lastDate: each.nightData.last.date);
                        if (each.nightData.first.nightFees.isNotEmpty) {
                          nightDataString =
                              "${each.nightData.first.nightFees.first}";
                        }
                      }
                      return GestureDetector(
                        onTap: () {
                          // Get.to(()=>)
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AspectRatio(
                                aspectRatio: 1,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      AppConstants.baseBorderRadius),
                                  child: SizedBox.expand(
                                    child: PageView(
                                      children: [
                                        ...each.imageList.map((e) {
                                          return CachedNetworkImage(
                                            imageUrl: e.getServerPath(),
                                            fit: BoxFit.cover,
                                            errorWidget: (context, url, error) {
                                              return Container(
                                                width: double.infinity,
                                                height: double.infinity,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    border: Border.all(),
                                                    borderRadius: BorderRadius
                                                        .circular(AppConstants
                                                            .baseBorderRadius)),
                                                child: const Icon(Icons
                                                    .image_not_supported_rounded),
                                              );
                                            },
                                          );
                                        }).toList()
                                      ],
                                    ),
                                  ),
                                )),
                            5.heightBox(),
                            Text(
                              each.title,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: AppConstants.fontSizeM),
                            ),
                            Text(
                              each.subTitle,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: AppConstants.fontSizeM,
                                  color: AppColors.textGrey),
                            ),
                            Text(
                              dateString,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: AppConstants.fontSizeM,
                                  color: AppColors.textGrey),
                            ),
                            (AppConstants.basePadding).heightBox(),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
