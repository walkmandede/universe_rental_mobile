
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe_rental/constants/app_colors.dart';
import 'package:universe_rental/constants/app_constants.dart';
import 'package:universe_rental/constants/app_functions.dart';
import 'package:universe_rental/modules/_common/models/m_listing_detail.dart';
import 'package:universe_rental/modules/home/explore/sub_widgets/listing/each_listing/c_each_listing.dart';
import 'package:universe_rental/modules/home/listing_detail/v_listing_detail_page.dart';
import 'package:universe_rental/services/others/extensions.dart';

class EachListingWidget extends StatelessWidget {
  final ListingDetail each;
  EachListingWidget({super.key,required this.each});
  final controller = Get.put(EachListingWidgetController());

  @override
  Widget build(BuildContext context) {

    var dateString = "-";
    var nightDataString = "-";
    if(each.nightData.isNotEmpty){
      dateString = AppFunctions().getDateRangeString(firstDate: each.nightData.first.date, lastDate: each.nightData.last.date);
      if(each.nightData.first.nightFees.isNotEmpty){
        nightDataString = "${each.nightData.first.nightFees.first}";
      }
    }

    controller.initLoad(each: each);
    return GestureDetector(
      onTap: () {
        superPrint(each.id);
        Get.to(()=> ListingDetailPage(
            id: each.id,
            images: each.imageList,
            imageShownIndex: controller.currentShownImageIndex.value,
        ));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppConstants.baseBorderRadius),
                child: SizedBox.expand(
                  child: Stack(
                    children: [
                      Hero(
                        tag: "imageList${each.id}",
                        child: PageView(
                          key: GlobalKey(),
                          controller: controller.pageController,
                          // restorationId: "dafs",
                          onPageChanged: (value) {
                            controller.onPageChanged(value);
                          },
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
                                        borderRadius: BorderRadius.circular(AppConstants.baseBorderRadius)
                                    ),
                                    child: const Icon(Icons.image_not_supported_rounded),
                                  );
                                },
                              );
                            }).toList()
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                      )
                    ],
                  ),
                ),
              )
          ),
          5.heightBox(),
          Text(
            each.title,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: AppConstants.fontSizeM
            ),
          ),
          Text(
            each.subTitle,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: AppConstants.fontSizeM,
                color: AppColors.textGrey
            ),
          ),
          Text(
            dateString,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: AppConstants.fontSizeM,
                color: AppColors.textGrey
            ),
          ),
          (AppConstants.basePadding).heightBox(),
        ],
      ),
    );
  }
}