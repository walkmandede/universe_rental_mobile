import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:universe_rental/constants/app_colors.dart';
import 'package:universe_rental/constants/app_constants.dart';
import 'package:universe_rental/services/others/extensions.dart';

class ListingShimmerWidget extends StatelessWidget {
  const ListingShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.grey.withOpacity(0.4),
      highlightColor: AppColors.grey.withOpacity(0.2),
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(4, (index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: AppColors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(
                            AppConstants.baseBorderRadius)),
                  ),
                ),
                Text("------" * 4),
                Text("------" * 4),
                10.heightBox(),
              ],
            );
          }),
        ),
      ),
    );
  }
}
