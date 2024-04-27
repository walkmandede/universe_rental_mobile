import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:universe_rental/constants/app_colors.dart';
import 'package:universe_rental/constants/app_constants.dart';
import 'package:universe_rental/modules/_common/flutter_super_scaffold.dart';
import 'package:universe_rental/modules/_common/models/m_listing_detail.dart';
import 'package:universe_rental/modules/home/listing_detail/c_listing_detail.dart';
import 'package:universe_rental/modules/home/listing_detail/w_listing_detail_app_bar.dart';
import 'package:universe_rental/modules/my_calendar/_my_calendar_test_page.dart';
import 'package:universe_rental/services/others/extensions.dart';
import 'package:universe_rental/web_data_entry/listing_attribute/m_listing_attribute.dart';

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
                AspectRatio(
                  aspectRatio: 1,
                  child: Hero(
                    tag: "imageList$id",
                    child: PageView(
                      controller: PageController(initialPage: imageShownIndex),
                      onPageChanged: (value) {},
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
                                    borderRadius: BorderRadius.circular(
                                        AppConstants.baseBorderRadius)),
                                child: const Icon(
                                    Icons.image_not_supported_rounded),
                              );
                            },
                          );
                        }).toList()
                      ],
                    ),
                  ),
                ),
                // Container(
                //   color: Colors.red,
                //   width: double.infinity,
                //   height: 300,
                // ),
                ValueListenableBuilder(
                    valueListenable: controller.listingData,
                    builder: (context, _listing, child) {
                      if (_listing != null) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 22, vertical: 18),
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              listingData(_listing),
                              (Get.height * 0.02).heightBox(),
                              divider(),
                              hostCard(_listing),
                              // aboutPlace(_listing),
                              AboutPlaceWidget(listing: _listing),
                              placesImages(),
                              offerList(),
                              location(),
                              booking(),
                            ],
                          ),
                        );
                      }
                      return const SizedBox();
                    })
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

  Widget listingData(ListingDetail listing) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          listing.title.toUpperCase(),
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        (Get.height * 0.02).heightBox(),
        Text(
          listing.subTitle,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        (Get.height * 0.01).heightBox(),
        Wrap(
          runSpacing: 10,
          children: [
            ...listing.listingOnAttributes.map((e) {
              ListingOnAttribute _attribute = e;
              int index = listing.listingOnAttributes.indexOf(e);
              return Row(
                children: [
                  if (index != 0) (Get.width * 0.02).widthBox(),
                  Text(
                      '${_attribute.quantity} ${_attribute.listingAttribute.name}'),
                  if (index != 3) (Get.width * 0.02).widthBox(),
                  if (index != 3) bubble(),
                ],
              );
            })
          ],
        ),
        // Wrap(
        //   direction: Axis.horizontal,
        //   children: List.generate(listing.listingOnAttributes.length, (index) {
        //     ListingOnAttribute _attribute = listing.listingOnAttributes[index];
        //     return Row(
        //       children: [
        //         if (index != 0) (Get.width * 0.02).widthBox(),
        //         Text(
        //             '${_attribute.quantity} ${_attribute.listingAttribute.name}'),
        //         if (index != 3) (Get.width * 0.02).widthBox(),
        //         if (index != 3) bubble(),
        //       ],
        //     );
        //   }).toList(),
        // ),
        (Get.height * 0.01).heightBox(),
        Row(
          children: [
            const Icon(
              TablerIcons.star_filled,
              size: 18,
            ),
            4.widthBox(),
            const Text(
              "4.3",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
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
      ],
    );
  }

  Widget hostCard(ListingDetail listing) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                spreadRadius: 4,
                blurRadius: 10,
                color: AppColors.grey.withOpacity(0.3))
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
        child: Row(
          children: [
            CircleAvatar(
                radius: Get.width * 0.08,
                backgroundImage:
                    const AssetImage('assets/images/fakeprofile.png')),
            10.widthBox(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hosted by ${listing.hostName}",
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 18),
                ),
                const Text(
                  "Normalhost . 2 years hosting ",
                  style: TextStyle(fontSize: 16),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  // Widget aboutPlace(ListingDetail listing) {

  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       const Text(
  //         'About this space',
  //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
  //       ),
  //       10.heightBox(),
  //       SizedBox(
  //         height: Get.height * 0.1,
  //         child: Text(
  //           listing.description,
  //           style: const TextStyle(fontSize: 16),
  //         ),
  //       ),
  //       10.heightBox(),
  //       topBoxShadow(),
  //     ],
  //   );
  // }

  Widget booking() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("4 nights in Tambon Hua Hin"),
        const Text('Apr 13, 2024 - Apr 17, 2024'),
        Container(
            color: Colors.amber,
            height: Get.height * 0.42,
            child: const MyCalendarTestPage()),
        const Text(
          "Restart Date",
          style: TextStyle(
            decoration: TextDecoration.underline,
          ),
        )
      ],
    );
  }

  Widget placesImages() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Place photo Tour",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          (Get.height * 0.02).heightBox(),
          SizedBox(
            height: Get.height * 0.3,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: Get.height * 0.24,
                        padding: const EdgeInsets.only(bottom: 10),
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Image.asset('assets/images/fakephoto1.png'),
                      ),
                      const Text("Living Room")
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }

  Widget offerList() {
    return Column(
      children: [
        const Text(
          "Offer Lists",
        ),
        Container(
            color: Colors.red,
            height: Get.height * 0.18,
            child: Column(
              children:
                  List.generate(3, (index) => Text(index.toString())).toList(),
            ))
      ],
    );
  }

  Widget location() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Locations',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          (Get.height * 0.02).heightBox(),
          Container(
            height: Get.height * 0.3,
            width: double.infinity,
            color: Colors.red,
          ),
          (Get.height * 0.02).heightBox(),
          const Text(
            "Entire villa in Tambon Hua Hin, Thailand",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          (Get.height * 0.01).heightBox(),
          const Text(
              "Nearby Place \n -place near shwedagon \n -near xsphere n -near sule pagoda"),
          (Get.height * 0.01).heightBox(),
          // topBoxShadow()
        ],
      ),
    );
  }

  Widget bubble() {
    return Container(
      width: Get.width * 0.01,
      height: Get.height * 0.01,
      decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.black),
    );
  }
}

Widget divider() {
  return Divider(
    thickness: 1,
    color: Colors.grey.withOpacity(0.4),
    height: Get.height * 0.02,
  );
}

Widget topBoxShadow(bool xSeeMoreClick, void Function()? onTap) {
  return Container(
    decoration: BoxDecoration(boxShadow: [
      BoxShadow(
          offset: Offset(0, -Get.height * 0.05),
          blurRadius: 4,
          spreadRadius: 3,
          color: AppColors.white.withOpacity(0.6))
    ]),
    child: xSeeMoreClick
        ? divider()
        : Stack(
            alignment: Alignment.center,
            children: [
              divider(),
              GestureDetector(
                onTap: onTap,
                child: Container(
                  height: Get.height * 0.05,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 10),
                            blurRadius: 4,
                            spreadRadius: 2,
                            color: AppColors.grey.withOpacity(0.1))
                      ],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: const Text("See More"),
                ),
              ),
            ],
          ),
  );
}

class AboutPlaceWidget extends StatefulWidget {
  final ListingDetail listing;
  const AboutPlaceWidget({super.key, required this.listing});

  @override
  State<AboutPlaceWidget> createState() => _AboutPlaceWidgetState();
}

class _AboutPlaceWidgetState extends State<AboutPlaceWidget> {
  bool _xClickSeeMore = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'About this space',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        10.heightBox(),
        SizedBox(
          height: Get.height * 0.1,
          child: Text(
            widget.listing.description,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        10.heightBox(),
        topBoxShadow(_xClickSeeMore, () {
          setState(() {
            _xClickSeeMore != _xClickSeeMore;
          });
        }),
      ],
    );
  }
}
