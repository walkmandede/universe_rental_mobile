import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe_rental/constants/app_constants.dart';
import 'package:universe_rental/constants/app_functions.dart';
import 'package:universe_rental/modules/_common/flutter_super_scaffold.dart';
import 'package:universe_rental/modules/home/explore/sub_widgets/listing/each_listing/c_each_listing.dart';
import 'package:universe_rental/modules/home/listing_detail/c_listing_detail.dart';
import 'package:universe_rental/modules/home/listing_detail/w_listing_detail_app_bar.dart';
import 'package:universe_rental/services/others/extensions.dart';

class ListingDetailPage extends StatelessWidget {
  final String id;
  final List<String> images;
  final int imageShownIndex;
  ListingDetailPage({super.key,required this.id,required this.images,required this.imageShownIndex});
  final controller = Get.put(ListingDetailController());

  @override
  Widget build(BuildContext context) {
    controller.initLoad(id: id, shownPageIndex: imageShownIndex);
    superPrint(imageShownIndex);
    return FlutterSuperScaffold(
      isTopSafe: false,
      superBarColor: SuperBarColor(
        topBarColor: Colors.transparent
      ),
      onWillPop: () {
        EachListingWidgetController eachListingWidgetController = Get.find();
        eachListingWidgetController.movePage(pageIndex: controller.currentShownPageIndex.value, id: id);
      },
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: Hero(
                    tag: "imageList$id",
                    child: PageView(
                      controller: PageController(initialPage: imageShownIndex),
                      onPageChanged: (value) {

                      },
                      children: [
                        ...images.map((e) {
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
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: EdgeInsets.only(
                top: Get.mediaQuery.padding.top
              ),
              decoration: BoxDecoration(
                color: Colors.transparent
              ),
              child: const ListingDetailAppBar(),
            ),
          )
        ],
      ),
    );
  }
}