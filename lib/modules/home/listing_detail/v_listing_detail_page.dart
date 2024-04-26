import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:universe_rental/constants/app_colors.dart';
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
  ListingDetailPage(
      {super.key,
      required this.id,
      required this.images,
      required this.imageShownIndex});
  final controller = Get.put(ListingDetailController());

  @override
  Widget build(BuildContext context) {
    controller.initLoad(id: id, shownPageIndex: imageShownIndex);
    superPrint(imageShownIndex);
    return FlutterSuperScaffold(
      isTopSafe: false,
      superBarColor: SuperBarColor(topBarColor: Colors.transparent),
      onWillPop: () {
        // EachListingWidgetController eachListingWidgetController = Get.find();
        // eachListingWidgetController.movePage(pageIndex: controller.currentShownPageIndex.value, id: id);
      },
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                //   AspectRatio(
                //     aspectRatio: 1,
                //     child: Hero(
                //       tag: "imageList$id",
                //       child: PageView(
                //         controller: PageController(initialPage: imageShownIndex),
                //         onPageChanged: (value) {
                //         },
                //         children: [
                //           ...images.map((e) {
                //             return CachedNetworkImage(
                //               imageUrl: e.getServerPath(),
                //               fit: BoxFit.cover,
                //               errorWidget: (context, url, error) {
                //                 return Container(
                //                   width: double.infinity,
                //                   height: double.infinity,
                //                   alignment: Alignment.center,
                //                   decoration: BoxDecoration(
                //                       border: Border.all(),
                //                       borderRadius: BorderRadius.circular(AppConstants.baseBorderRadius)
                //                   ),
                //                   child: const Icon(Icons.image_not_supported_rounded),
                //                 );
                //               },
                //             );
                //           }).toList()
                //         ],
                //       ),
                //     ),
                //   )
                Container(
                  color: Colors.red,
                  width: double.infinity,
                  height: 300,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'HER HUAHIN POOL VILLA'.toUpperCase(),
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w700),
                      ),
                      (Get.height * 0.02).heightBox(),
                      const Text(
                        'Entire villa in Tambon Hua Hin, Thailand',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      (Get.height * 0.01).heightBox(),
                      Row(
                        children: List.generate(
                            4,
                            (index) => Row(
                                  children: [
                                    if (index != 0)
                                      (Get.width * 0.02).widthBox(),
                                    const Text('3 beds'),
                                    if (index != 3)
                                      (Get.width * 0.02).widthBox(),
                                    if (index != 3) bubble(),
                                  ],
                                )).toList(),
                      ),
                      (Get.height * 0.01).heightBox(),
                      Row(
                        children: [
                          const Icon(TablerIcons.star_filled),
                          4.widthBox(),
                          const Text(
                            "4.3",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          8.widthBox(),
                          bubble(),
                          8.widthBox(),
                          const Text(
                            "15 reviews",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          )
                        ],
                      ),
                      (Get.height * 0.02).heightBox(),
                      divider(),
                      Card(
                        margin: const EdgeInsets.symmetric(vertical: 16),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 16),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                  backgroundImage: AssetImage(
                                      'assets/images/fakeprofile.png')),
                              10.widthBox(),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Hosted by Tanakan",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    "Normalhost . 2 years hosting ",
                                    style: TextStyle(fontSize: 16),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: EdgeInsets.only(top: Get.mediaQuery.padding.top),
              decoration: const BoxDecoration(color: Colors.transparent),
              child: const ListingDetailAppBar(),
            ),
          )
        ],
      ),
    );
  }

  Widget divider() {
    return Divider(
      thickness: 1,
      color: Colors.grey,
      height: Get.height * 0.02,
    );
  }

  Widget bubble() {
    return Container(
      width: Get.width * 0.02,
      height: Get.height * 0.02,
      decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.black),
    );
  }
}
