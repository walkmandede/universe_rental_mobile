import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:universe_rental/constants/app_colors.dart';
import 'package:universe_rental/constants/app_constants.dart';
import 'package:universe_rental/modules/_common/controllers/c_data_controller.dart';

class ListingDetailAppBar extends StatelessWidget {
  final double animatedValue;
  final AnimationController animatedController;
  final String id;
  ListingDetailAppBar(
      {super.key,
      required this.id,
      required this.animatedValue,
      required this.animatedController});
  DataController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animatedController,
        builder: (context, child) {
          final animationValue = animatedController.value;
          return Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: AppConstants.basePadding,
              vertical: 0,
            ),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(animatedValue),
                boxShadow: [
                  if (animationValue != 0)
                    BoxShadow(
                        offset: Offset(0, 20 * animationValue),
                        spreadRadius: 3 * animationValue,
                        blurRadius: 14 * animationValue,
                        color: AppColors.borderGrey.withOpacity(0.1))
                ]),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                containerWithBorder(
                    Icon(
                      Icons.arrow_back_ios_new,
                      size: AppConstants.fontSizeL,
                    ), () {
                  Get.back();
                }),
                Container(
                  padding: EdgeInsets.only(
                    left: (Get.width * (0.5 - (animationValue * 0.1))) - 40,
                  ),
                  child: containerWithBorder(
                      Icon(
                        TablerIcons.share_2,
                        size: AppConstants.fontSizeL,
                      ),
                      () {}),
                ),
                ValueListenableBuilder(
                    valueListenable: controller.favoriteListingIds,
                    builder: (context, value, child) {
                      return Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: EdgeInsets.only(
                            right: (Get.width * (0.3 * animationValue)),
                          ),
                          child: containerWithBorder(
                              controller.favoriteListingIds.value.contains(id)
                                  ? Icon(
                                      Icons.favorite_rounded,
                                      color: Colors.red,
                                      size: AppConstants.fontSizeL,
                                    )
                                  : Icon(
                                      Icons.favorite_border_rounded,
                                      size: AppConstants.fontSizeL,
                                    ), () {
                            controller.toggleSpFavorites(listingId: id);
                          }),
                        ),
                      );
                    })
              ],
            ),
          );
        });
  }

  Widget containerWithBorder(Widget wid, void Function()? onPressed,
      [Color? color]) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(8),
        // alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.grey.withOpacity(0.4))),
        child: wid,
      ),
    );
  }
}
