import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:universe_rental/constants/app_constants.dart';
import 'package:universe_rental/modules/home/c_home_controller.dart';
import 'package:universe_rental/modules/home/explore/c_explore_controller.dart';
import 'package:universe_rental/modules/home/explore/sub_widgets/listing/c_listing_controller.dart';
import 'package:universe_rental/modules/home/explore/sub_widgets/listing/each_listing/w_each_listing_widget.dart';
import 'package:universe_rental/modules/home/explore/sub_widgets/listing/w_listing_shimmer_widget.dart';
import 'package:universe_rental/services/others/extensions.dart';

import '../../../../../constants/app_colors.dart';
import '../../../../../constants/app_functions.dart';

class ListingDataWidget extends StatelessWidget {
  final Size baseSize;
  const ListingDataWidget({super.key,required this.baseSize});

  @override
  Widget build(BuildContext context) {
    ExploreController controller = Get.find();
    ListingController listingController = Get.find();
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.basePadding,
        vertical: AppConstants.basePadding
      ),
      decoration: BoxDecoration(
        color: AppColors.bgGrey
      ),
      child: ValueListenableBuilder(
        valueListenable: controller.xUpdatingShownList,
        builder: (context, xUpdatingShownList, child) {
          if(xUpdatingShownList){
            return const ListingShimmerWidget();
          }
          else{
            return ValueListenableBuilder(
              valueListenable: controller.shownListing,
              builder: (context, shownListing, child) {
                if(shownListing.isEmpty){
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
                }
                else{
                  return ListView.builder(
                    padding: EdgeInsets.only(
                      bottom: AppConstants.baseNaviBarHeight
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: shownListing.length,
                    itemBuilder: (context, index) {
                      final each = shownListing[index];
                      return EachListingWidget(each: each);
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
