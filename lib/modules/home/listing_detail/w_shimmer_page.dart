import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:universe_rental/constants/app_colors.dart';
import 'package:universe_rental/constants/app_constants.dart';
import 'package:universe_rental/services/others/extensions.dart';

class ShimmerListingDetailPage extends StatelessWidget {
  const ShimmerListingDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Shimmer.fromColors(
        baseColor: AppColors.grey.withOpacity(0.4),
        highlightColor: AppColors.grey.withOpacity(0.2),
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(4, (index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    width: Get.width * 0.5,
                    height: Get.height * 0.02,
                    decoration: BoxDecoration(
                        color: AppColors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(
                            AppConstants.baseBorderRadius)),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    width: Get.width * 0.3,
                    height: Get.height * 0.02,
                    decoration: BoxDecoration(
                        color: AppColors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(
                            AppConstants.baseBorderRadius)),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    width: Get.width,
                    height: Get.height * 0.02,
                    decoration: BoxDecoration(
                        color: AppColors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(
                            AppConstants.baseBorderRadius)),
                  ),
                  Card(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          width: double.infinity,
                          height: Get.height * 0.02,
                          decoration: BoxDecoration(
                              color: AppColors.grey.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(
                                  AppConstants.baseBorderRadius)),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          width: Get.width * 0.5,
                          height: Get.height * 0.02,
                          decoration: BoxDecoration(
                              color: AppColors.grey.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(
                                  AppConstants.baseBorderRadius)),
                        ),
                      ],
                    ),
                  ),
                  // Text("------" * 4),
                  // Text("------" * 4),
                  10.heightBox(),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
