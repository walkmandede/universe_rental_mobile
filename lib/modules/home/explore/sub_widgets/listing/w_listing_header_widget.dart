import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:universe_rental/modules/home/explore/c_explore_controller.dart';
import 'package:universe_rental/modules/home/explore/sub_widgets/header/c_explore_header_controller.dart';
import '../../../../../constants/app_colors.dart';

class ListingHeaderWidget extends StatelessWidget {
  final Size baseSize;
  const ListingHeaderWidget({super.key, required this.baseSize});

  @override
  Widget build(BuildContext context) {
    ExploreController controller = Get.find();
    return Builder(
      builder: (context) {
        final listingHeaderHeight =
            baseSize.height * controller.getListingHeaderHeightPortion();
        return Container(
          width: double.infinity,
          height: listingHeaderHeight,
          padding: EdgeInsets.symmetric(
              horizontal: baseSize.width * 0.1,
              vertical: listingHeaderHeight * 0.1),
          child: Column(
            children: [
              Container(
                width: baseSize.width * 0.15,
                height: 4,
                decoration: BoxDecoration(
                    color: AppColors.grey.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(1000)),
              ),
              const Spacer(),
              ValueListenableBuilder(
                valueListenable: controller.shownListing,
                builder: (context, shownListing, child) {
                  String label = "places";
                  ExploreHeaderController exploreHeaderController = Get.find();
                  if (exploreHeaderController.selectedTag.value != null) {
                    label = exploreHeaderController.selectedTag.value!.name;
                  }
                  return Text(
                      "${NumberFormat("###,###").format(shownListing.length)} $label");
                },
              ),
              const Spacer(),
            ],
          ),
        );
      },
    );
  }
}
