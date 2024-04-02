import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe_rental/modules/home/explore/c_explore_controller.dart';
import 'package:universe_rental/modules/home/explore/sub_widgets/listing/c_listing_controller.dart';

import '../../../../../constants/app_colors.dart';
import '../../../../../constants/app_functions.dart';

class ListingDataWidget extends StatelessWidget {
  final Size baseSize;
  const ListingDataWidget({super.key,required this.baseSize});

  @override
  Widget build(BuildContext context) {
    ExploreController controller = Get.find();
    ListingController listingController = Get.find();
    return Column(
      children: [
        ...List.generate(100, (index) {
          return TextButton(onPressed: () {
          }, child: Text(index.toString()));
        })
      ],
    );
  }
}
