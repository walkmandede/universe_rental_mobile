import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:universe_rental/constants/app_colors.dart';
import 'package:universe_rental/constants/app_constants.dart';
import 'package:universe_rental/modules/_common/flutter_super_scaffold.dart';
import 'package:universe_rental/modules/_common/models/m_listing_detail.dart';
import 'package:universe_rental/modules/_common/models/m_listing_offer.dart';
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
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: Hero(
                      tag: "imageList$id",
                      child: PageView(
                        controller:
                            PageController(initialPage: imageShownIndex),
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
                                AboutPlaceWidget(listing: _listing),
                                placesImages(),
                                divider(),
                                (Get.height * 0.02).heightBox(),
                                OfferListWidget(listing: _listing),
                                // location(),
                                LocationWidget(listing: _listing),
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
        const Text(
          "4 nights in Tambon Hua Hin",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        Text(
          'Apr 13, 2024 - Apr 17, 2024',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w400, color: AppColors.grey),
        ),
        ValueListenableBuilder(
            valueListenable: controller.selectedDateTimeRange,
            builder: (context, value, child) {
              return Container(
                  // color: Colors.amber,
                  height: Get.height * 0.42,
                  child: MyCalendarTestPage(
                    selectedDateTimeRange: value,
                  ));
            }),
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
      padding: const EdgeInsets.only(top: 12, bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Place photo Tour",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          (Get.height * 0.02).heightBox(),
          SizedBox(
            height: Get.height * 0.28,
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

  // Widget offerList(ListingDetail listing) {
  //   return Column(
  //     children: [
  //       const Text(
  //         "Offer Lists",
  //       ),
  //       Container(
  //           height: Get.height * 0.18,
  //           child: Column(
  //             children:
  //                 List.generate(3, (index) => Text(index.toString())).toList(),
  //           ))
  //     ],
  //   );
  // }

  // Widget location() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 20),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         const Text(
  //           'Locations',
  //           style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
  //         ),
  //         (Get.height * 0.02).heightBox(),
  //         Container(
  //           height: Get.height * 0.3,
  //           width: double.infinity,
  //           color: Colors.red,
  //         ),
  //         (Get.height * 0.02).heightBox(),
  //         const Text(
  //           "Entire villa in Tambon Hua Hin, Thailand",
  //           style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
  //         ),
  //         (Get.height * 0.01).heightBox(),
  //         const Text(
  //             "Nearby Place \n -place near shwedagon \n -near xsphere n -near sule pagoda"),
  //         (Get.height * 0.01).heightBox(),
  //         // topBoxShadow()
  //       ],
  //     ),
  //   );
  // }

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
      if (!xSeeMoreClick)
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
          height: _xClickSeeMore ? null : Get.height * 0.1,
          child: Text(
            widget.listing.description,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        10.heightBox(),
        topBoxShadow(_xClickSeeMore, () {
          setState(() {
            _xClickSeeMore = !_xClickSeeMore;
            print(_xClickSeeMore);
          });
        }),
      ],
    );
  }
}

class OfferListWidget extends StatefulWidget {
  final ListingDetail listing;
  OfferListWidget({super.key, required this.listing});

  @override
  State<OfferListWidget> createState() => _OfferListWidgetState();
}

class _OfferListWidgetState extends State<OfferListWidget> {
  bool _xClickSeeMore = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Offer Lists",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        (Get.height * 0.02).heightBox(),
        SizedBox(
          height: _xClickSeeMore ? null : Get.height * 0.14,
          child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.listing.listingOffers.length,
              itemBuilder: (context, index) {
                ListingOffer offer = widget.listing.listingOffers[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      SvgPicture.string(
                        offer.icon,
                      ),
                      10.widthBox(),
                      Text(
                        offer.name,
                        style: const TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                );
              }),
        ),
        10.heightBox(),
        topBoxShadow(_xClickSeeMore, () {
          setState(() {
            _xClickSeeMore = !_xClickSeeMore;
            print(_xClickSeeMore);
          });
        }),
      ],
    );
  }
}

class LocationWidget extends StatefulWidget {
  final ListingDetail listing;
  const LocationWidget({super.key, required this.listing});

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  bool _xClickSeeMore = false;
  @override
  Widget build(BuildContext context) {
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
          SizedBox(
            height: Get.height * 0.3,
            width: double.infinity,
            child: MapWidget(
              latLng: widget.listing.listingLocation.latLng,
            ),
          ),
          (Get.height * 0.02).heightBox(),
          Text(
            widget.listing.listingLocation.fullAddress,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          (Get.height * 0.01).heightBox(),
          Text(widget.listing.listingLocation.remark),
          (Get.height * 0.01).heightBox(),
          // topBoxShadow()
          10.heightBox(),
          topBoxShadow(_xClickSeeMore, () {
            setState(() {
              _xClickSeeMore = !_xClickSeeMore;
              print(_xClickSeeMore);
            });
          }),
        ],
      ),
    );
  }
}

class MapWidget extends StatelessWidget {
  final LatLng latLng;
  const MapWidget({super.key, required this.latLng});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.4,
      height: Get.width * 0.4 * 0.8,
      decoration: BoxDecoration(border: Border.all()),
      child: FlutterMap(
        options: MapOptions(
          initialCenter: latLng,
          initialZoom: 17.5,
          interactionOptions:
              const InteractionOptions(enableMultiFingerGestureRace: true),
          maxZoom: 20,
        ),
        children: [
          TileLayer(
            urlTemplate:
                "https://s.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png",
          ),
          MarkerLayer(
            markers: [
              Marker(
                  point: latLng,
                  width: 25,
                  height: 25,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: const BoxDecoration(
                        color: Colors.red, shape: BoxShape.circle),
                    padding: const EdgeInsets.all(4),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      alignment: Alignment.center,
                      child: const FittedBox(child: Icon(Icons.pin_drop)),
                    ),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
