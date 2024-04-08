import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:universe_rental/constants/app_constants.dart';
import 'package:universe_rental/modules/home/explore/c_explore_controller.dart';
import 'package:universe_rental/modules/home/explore/sub_widgets/detail/v_detail_page.dart';
import 'package:universe_rental/modules/home/explore/sub_widgets/listing/c_listing_controller.dart';
import 'package:universe_rental/modules/home/explore/sub_widgets/listing/m_listing_model.dart';
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
    return Column(
      children: [
        ValueListenableBuilder(
            valueListenable: listingController.shownData,
            builder: (context, data, widget) {
              return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: listingController.shownData.value.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => DetailPage());
                      },
                      child: EachPlaceWidget(
                          baseSize: baseSize,
                          place: listingController.shownData.value[index]),
                    );
                  });
            }),
        AppConstants.baseNaviBarHeight.heightBox()
      ],
    );
  }
}

class EachPlaceWidget extends StatelessWidget {
  EachPlaceWidget({super.key, required this.place, required this.baseSize});
  DummyPlaces place;
  final Size baseSize;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                child: Image.asset(
                  place.images.first,
                  // height: baseSize.height * 0.2,
                  // width: baseSize.width,
                  fit: BoxFit.fill,
                  height: Get.height * 0.4,

                  width: Get.width,
                ),
              ),
              if (place.popular)
                Positioned(
                  top: 20,
                  left: 20,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: const Text("Popular"),
                  ),
                ),
              const Positioned(
                  top: 20,
                  right: 20,
                  child: Icon(
                    TablerIcons.heart,
                    color: Colors.white,
                  ))
            ],
          ),
          SizedBox(
            height: Get.height * 0.12,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppConstants.paddingXL,
                  vertical: AppConstants.paddingXS),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Text(
                        place.name,
                        style: TextStyle(
                            fontSize: AppConstants.fontSizeM,
                            fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      const Icon(
                        TablerIcons.star_filled,
                        size: 16,
                      ),
                      Text(place.rating)
                    ],
                  ),
                  Text(
                    place.type,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: AppConstants.fontSizeMS,
                    ),
                  ),
                  Text(
                    place.date,
                    style: TextStyle(
                        color: Colors.grey, fontSize: AppConstants.fontSizeMS),
                  ),
                  Text(
                    place.price,
                    style: TextStyle(
                        fontSize: AppConstants.fontSizeM,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
