import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:universe_rental/constants/app_colors.dart';
import 'package:universe_rental/constants/app_constants.dart';
import 'package:universe_rental/constants/app_functions.dart';
import 'package:universe_rental/modules/home/explore/c_explore_controller.dart';
import 'package:universe_rental/modules/home/explore/sub_widgets/listing/c_listing_controller.dart';
import 'package:universe_rental/modules/home/explore/sub_widgets/listing/w_listing_data_widget.dart';
import 'package:universe_rental/modules/home/explore/sub_widgets/listing/w_listing_header_widget.dart';

class ExploreListing extends StatelessWidget {
  final Size baseSize;
  const ExploreListing({super.key,required this.baseSize});

  @override
  Widget build(BuildContext context) {
    //flutter: - Size(390.0, 844.0) - package:universe_rental/modules/home/explore/sub_widgets/v_explore_header.dart:20:9
    //flutter: Size(390.0, 797.0)
    ExploreController controller = Get.find();
    ListingController listingController = Get.put(ListingController());
    return DraggableScrollableSheet(
      initialChildSize: controller.listingPanelHeight,
      maxChildSize: controller.listingPanelHeight,
      minChildSize: controller.getListingHeaderHeightPortion(),
      snap: true,
      controller: controller.draggableScrollableController,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
              color: AppColors.bgGrey,
              borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppConstants.baseBorderRadiusXL)
            )
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                ListingHeaderWidget(baseSize: baseSize,),
                ListingDataWidget(baseSize: baseSize)
              ],
            ),
          ),
        );
      },
    );
  }
}
