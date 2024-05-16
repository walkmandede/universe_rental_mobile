import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe_rental/constants/app_colors.dart';
import 'package:universe_rental/constants/app_constants.dart';
import 'package:universe_rental/modules/home/explore/sub_widgets/listing/each_listing/w_each_listing_widget.dart';
import 'package:universe_rental/modules/home/explore/sub_widgets/listing/w_listing_shimmer_widget.dart';
import 'package:universe_rental/modules/home/favorite/c_favorites_controller.dart';
import 'package:universe_rental/services/others/extensions.dart';

class FavoritePage extends StatelessWidget {
  FavoritePage({super.key});
  final controller = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    controller.updateData();
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1)),
      child: SizedBox.expand(
        child: Container(
          color: const Color(0xffFAFAFA),
          padding: EdgeInsets.only(
              left: AppConstants.basePadding,
              top: AppConstants.basePadding,
              right: AppConstants.basePadding),
          child: ValueListenableBuilder(
            valueListenable: controller.xLoading,
            builder: (context, xLoading, child) {
              if (xLoading) {
                return const ListingShimmerWidget();
              } else {
                return ValueListenableBuilder(
                  valueListenable: controller.shownData,
                  builder: (context, shownData, child) {
                    if (shownData.isEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Create your first Favourite",
                            style: TextStyle(
                                fontSize: AppConstants.fontSizeM,
                                fontWeight: FontWeight.w700),
                          ),
                          5.heightBox(),
                          Text(
                            "As you search, click the heart icon to save your favorite places and Experiences to a list.",
                            style: TextStyle(
                                fontSize: AppConstants.fontSizeMS,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textGrey),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Favourite lists",
                            style: TextStyle(
                                fontSize: AppConstants.fontSizeXL,
                                fontWeight: FontWeight.w700),
                          ),
                          (AppConstants.basePadding).heightBox(),
                          Expanded(
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: shownData.length,
                              itemBuilder: (context, index) {
                                final each = shownData[index];
                                return EachListingWidget(each: each);
                              },
                            ),
                          )
                        ],
                      );
                    }
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
