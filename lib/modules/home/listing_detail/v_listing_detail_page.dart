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
import 'package:universe_rental/constants/app_functions.dart';
import 'package:universe_rental/modules/_common/flutter_super_scaffold.dart';
import 'package:universe_rental/modules/_common/models/m_listing_detail.dart';
import 'package:universe_rental/modules/_common/models/m_listing_offer.dart';
import 'package:universe_rental/modules/_common/models/m_night_fee_model.dart';
import 'package:universe_rental/modules/_common/widgets/w_fitted_widget.dart';
import 'package:universe_rental/modules/home/listing_detail/c_listing_detail.dart';
import 'package:universe_rental/modules/home/listing_detail/w_listing_detail_app_bar.dart';
import 'package:universe_rental/modules/home/listing_detail/w_shimmer_page.dart';
import 'package:universe_rental/modules/my_calendar/_my_calendar_test_page.dart';
import 'package:universe_rental/services/others/extensions.dart';

class ListingDetailPage extends StatefulWidget {
  final String id;
  final List<String> images;
  final int imageShownIndex;
  ListingDetailPage(
      {super.key,
      required this.id,
      required this.images,
      required this.imageShownIndex});

  @override
  State<ListingDetailPage> createState() => _ListingDetailPageState();
}

class _ListingDetailPageState extends State<ListingDetailPage>
    with TickerProviderStateMixin {
  final controller = Get.put(ListingDetailController());
  late AnimationController animatedController;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    initLoad();
    super.initState();
  }

  initLoad() {
    animatedController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    scrollController.addListener(() {
      if (scrollController.position.pixels > Get.width) {
        animatedController.forward();
      } else {
        animatedController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    controller.initLoad(id: widget.id, shownPageIndex: widget.imageShownIndex);
    return FlutterSuperScaffold(
      isTopSafe: false,
      isBotSafe: false,
      superBarColor: SuperBarColor(topBarColor: Colors.transparent),
      onWillPop: () {
        // EachListingWidgetController eachListingWidgetController = Get.find();
        // eachListingWidgetController.movePage(pageIndex: controller.currentShownPageIndex.value, id: id);
      },
      body: Container(
        color: Colors.white.withOpacity(0.002),
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: Hero(
                      tag: "imageList${widget.id}",
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          PageView(
                            controller: PageController(
                                initialPage: widget.imageShownIndex),
                            onPageChanged: (value) {
                              // setState(() {
                              controller.currentIndex.value = value;
                              controller.currentIndex.notifyListeners();
                              // });
                            },
                            children: [
                              ...widget.images.map((e) {
                                return CachedNetworkImage(
                                  imageUrl: e.getServerPath(),
                                  fit: BoxFit.cover,
                                  width: Get.width,
                                  height: Get.height,
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
                          Material(
                            color: Colors.transparent,
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.7),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(6))),
                              child: ValueListenableBuilder(
                                  valueListenable: controller.currentIndex,
                                  builder: (context, index, child) {
                                    return Text(
                                      "${index + 1}/ ${widget.images.length}",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                    );
                                  }),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  ValueListenableBuilder(
                      valueListenable: controller.xLoading,
                      builder: (context, loading, child) {
                        if (loading) {
                          return const ShimmerListingDetailPage();
                        }
                        ListingDetail? _listing = controller.listingData.value;
                        if (_listing != null) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 22, vertical: 18),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                listingData(_listing),
                                (Get.height * 0.02).heightBox(),
                                divider(),
                                hostCard(_listing),
                                AboutPlaceWidget(listing: _listing),
                                placesImages(listing: _listing),
                                divider(),
                                (Get.height * 0.02).heightBox(),
                                OfferListWidget(listing: _listing),
                                // location(),
                                LocationWidget(listing: _listing),
                                booking(listing: _listing),
                                ValueListenableBuilder(
                                    valueListenable:
                                        controller.xContainNightDate,
                                    builder: (context, value, child) {
                                      if (controller.xContainNightDate.value) {
                                        return SizedBox(
                                          height: Get.height * 0.14,
                                        );
                                      } else if (controller
                                              .xSelectedDates.value &&
                                          !controller.xContainNightDate.value &&
                                          controller.selectedDateTimeRange.value
                                                  .start
                                                  .getDateKey() ==
                                              DateTime.now().getDateKey()) {
                                        return SizedBox(
                                          height: Get.height * 0.08,
                                        );
                                      } else {
                                        return const SizedBox();
                                      }
                                    })
                              ],
                            ),
                          );
                        }
                        return const SizedBox();
                      })
                ],
              ),
            ),
            AnimatedBuilder(
                animation: animatedController,
                builder: (context, child) {
                  final animationValue = animatedController.value;
                  return Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: Get.height * 0.14,
                      padding: EdgeInsets.only(top: Get.mediaQuery.padding.top),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(animationValue)),
                      child: ListingDetailAppBar(
                        id: widget.id,
                        animatedValue: animationValue,
                        animatedController: animatedController,
                      ),
                    ),
                  );
                }),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: reserveButtom(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget reserveButtom() {
    return ValueListenableBuilder(
      valueListenable: controller.xContainNightDate,
      builder: (context, value, child) {
        if (value) {
          return Container(
              height: Get.height * 0.14,
              padding: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: const Offset(0, -14),
                    color: AppColors.grey.withOpacity(0.2))
              ]),
              child: ValueListenableBuilder(
                valueListenable: controller.selectedDateTimeRange,
                builder: (context, sDate, child) {
                  NightFeeModel _firstNightDate = controller
                      .listingData.value!.nightData
                      .firstWhere((element) =>
                          element.date.getDateKey() ==
                          controller.xHasNightDataDate.value)
                      .nightFees
                      .first;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                        ),
                        child: Row(
                          children: [
                            Text(
                              AppFunctions().getDateRangeString(
                                  firstDate: sDate.start, lastDate: sDate.end),
                              style:
                                  TextStyle(fontSize: AppConstants.fontSizeL),
                            ),
                            Flexible(
                              child: FittedBox(
                                child: Text(
                                  '  ${_firstNightDate.currencyModel.sign} ${_firstNightDate.perNightFee} per night  ',
                                  style: TextStyle(
                                      fontSize: AppConstants.fontSizeL,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 16)),
                              onPressed: () {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: const Text("Reservation Done!"),
                                  backgroundColor: AppColors.bgBlack,
                                ));
                              },
                              child: Text(
                                'Reserve',
                                style: TextStyle(
                                    fontSize: AppConstants.fontSizeL,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )),
                        ),
                      )
                    ],
                  );
                },
              ));
        } else if (controller.xSelectedDates.value &&
            !value &&
            controller.selectedDateTimeRange.value.start.getDateKey() ==
                DateTime.now().getDateKey()) {
          return Container(
              color: Colors.white,
              height: Get.height * 0.08,
              width: double.infinity,
              alignment: Alignment.center,
              child: const Text("No Data Available"));
        }
        return const SizedBox();
      },
    );
  }

  Widget listingData(ListingDetail listing) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          listing.title.toUpperCase(),
          style: TextStyle(
              fontSize: AppConstants.fontSizeXXL, fontWeight: FontWeight.w700),
        ),
        (Get.height * 0.02).heightBox(),
        Text(
          listing.subTitle,
          style: TextStyle(
              fontSize: AppConstants.fontSizeM, fontWeight: FontWeight.w600),
        ),
        (Get.height * 0.01).heightBox(),
        Wrap(
          runSpacing: 10,
          spacing: 10,
          children: [
            ...listing.listingOnAttributes.map((e) {
              ListingOnAttribute _attribute = e;
              int index = listing.listingOnAttributes.indexOf(e);

              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // if (index != 0) (Get.width * 0.02).widthBox(),
                  Text(
                    '${_attribute.quantity} ${_attribute.listingAttribute.name}',
                    style: TextStyle(fontSize: AppConstants.fontSizeM),
                  ),
                  if (index != 3) (Get.width * 0.02).widthBox(),
                  if (index < listing.listingOnAttributes.length - 1) bubble(),
                ],
              );
            })
          ],
        ),
        (Get.height * 0.01).heightBox(),
        Row(
          children: [
            const Icon(
              TablerIcons.star_filled,
              size: 18,
            ),
            4.widthBox(),
            Text(
              "4.3",
              style: TextStyle(
                  fontSize: AppConstants.fontSizeM,
                  fontWeight: FontWeight.w700),
            ),
            8.widthBox(),
            bubble(),
            8.widthBox(),
            Text(
              "15 reviews",
              style: TextStyle(
                fontSize: AppConstants.fontSizeM,
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
          color: Colors.white.withOpacity(0.9),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                spreadRadius: 4,
                blurRadius: 10,
                color: AppColors.grey.withOpacity(0.16))
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
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hosted by ${listing.hostName}",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: AppConstants.fontSizeM,
                        overflow: TextOverflow.ellipsis),
                  ),
                  Text(
                    "Normalhost . 2 years hosting ",
                    style: TextStyle(
                      fontSize: AppConstants.fontSizeM,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget booking({required ListingDetail listing}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ValueListenableBuilder(
            valueListenable: controller.selectedDateTimeRange,
            builder: (context, selectDate, child) {
              return Text(
                "${AppFunctions().getBetweenDates(dtr: DateTimeRange(start: selectDate.start, end: selectDate.end)).length} nights in ${controller.listingData.value!.title}",
                style: TextStyle(
                    fontSize: AppConstants.fontSizeL,
                    fontWeight: FontWeight.w600),
              );
            }),
        4.heightBox(),
        ValueListenableBuilder(
            valueListenable: controller.selectedDateTimeRange,
            builder: (context, value, child) {
              return Text(
                "${controller.selectedDateTimeRange.value.start.getMDY()} - ${controller.selectedDateTimeRange.value.end.getMDY()}",
                style: TextStyle(
                    fontSize: AppConstants.fontSizeM,
                    fontWeight: FontWeight.w400,
                    color: AppColors.grey),
              );
            }),
        ValueListenableBuilder(
            valueListenable: controller.selectedDateTimeRange,
            builder: (context, value, child) {
              return SizedBox(
                  height: Get.height * 0.42,
                  child: MyCalendarTestPage(
                    selectedDateTimeRange: value,
                    validDates: controller.validDates,
                    onChangeDate: controller.onChangedSelectedDate,
                  ));
            }),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: GestureDetector(
            onTap: () {
              controller.onChangedSelectedDate(
                  DateTimeRange(start: DateTime.now(), end: DateTime.now()));
            },
            child: Text(
              "Restart Date",
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: AppConstants.fontSizeM),
            ),
          ),
        ),
      ],
    );
  }

  Widget placesImages({required ListingDetail listing}) {
    double _imgHeight = Get.height * 0.21;
    double _imgWidth = Get.width * 0.68;
    double _borderRaius = 20;
    bool xHasAllImgs = true;
    for (var v in listing.listingOnPlaces) {
      if (v.images.isEmpty) {
        xHasAllImgs = false;
        break;
      }
    }
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Place photo Tour",
            style: TextStyle(
                fontSize: AppConstants.fontSizeL, fontWeight: FontWeight.bold),
          ),
          (Get.height * 0.02).heightBox(),
          if (xHasAllImgs)
            SizedBox(
              height: Get.height * 0.28,
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  itemCount: listing.listingOnPlaces.length,
                  itemBuilder: (context, index) {
                    ListingOnPlace _currentListingPlace =
                        listing.listingOnPlaces[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            height: _imgHeight,
                            width: _imgWidth,
                            margin:
                                const EdgeInsets.only(bottom: 10, right: 10),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: _currentListingPlace.images.length == 1
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                        _currentListingPlace.images.first,
                                        fit: BoxFit.cover),
                                  )
                                : _currentListingPlace.images.length == 2
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(
                                                    _borderRaius),
                                                bottomLeft: Radius.circular(
                                                    _borderRaius)),
                                            child: Image.network(
                                                _currentListingPlace
                                                    .images.first,
                                                width: _imgWidth / 2.03,
                                                height: _imgHeight,
                                                fit: BoxFit.cover),
                                          ),
                                          ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(
                                                    _borderRaius),
                                                bottomRight: Radius.circular(
                                                    _borderRaius)),
                                            child: Image.network(
                                                _currentListingPlace
                                                    .images.last,
                                                width: _imgWidth / 2.03,
                                                height: _imgHeight,
                                                fit: BoxFit.cover),
                                          )
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(
                                                    _borderRaius),
                                                topLeft: Radius.circular(
                                                    _borderRaius)),
                                            child: Image.network(
                                                _currentListingPlace
                                                    .images.first,
                                                width: _imgWidth / 1.52,
                                                height: _imgHeight,
                                                fit: BoxFit.cover),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                    topRight: Radius.circular(
                                                        _borderRaius)),
                                                child: Image.network(
                                                    _currentListingPlace
                                                        .images[1],
                                                    width: _imgWidth / 3.1,
                                                    height: _imgHeight / 2.05,
                                                    fit: BoxFit.cover),
                                              ),
                                              Stack(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            bottomRight:
                                                                Radius.circular(
                                                                    _borderRaius)),
                                                    child: Image.network(
                                                        _currentListingPlace
                                                            .images.last,
                                                        width: _imgWidth / 3.1,
                                                        height:
                                                            _imgHeight / 2.05,
                                                        fit: BoxFit.cover),
                                                  ),
                                                  if (_currentListingPlace
                                                          .images.length >
                                                      3)
                                                    GestureDetector(
                                                      onTap: () {
                                                        _showImageDialog(
                                                            context,
                                                            _currentListingPlace
                                                                .images);
                                                      },
                                                      child: Container(
                                                        width: _imgWidth / 3.1,
                                                        height:
                                                            _imgHeight / 2.05,
                                                        decoration: BoxDecoration(
                                                            color: AppColors
                                                                .grey
                                                                .withOpacity(
                                                                    0.4),
                                                            borderRadius:
                                                                BorderRadius.only(
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            _borderRaius))),
                                                        child: IconButton(
                                                            onPressed: () {
                                                              _showImageDialog(
                                                                  context,
                                                                  _currentListingPlace
                                                                      .images);
                                                            },
                                                            icon: const Icon(
                                                              Icons.add,
                                                              color:
                                                                  Colors.white,
                                                              size: 34,
                                                            )),
                                                      ),
                                                    )
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      )),
                        Text(
                          _currentListingPlace.listingPlace.name,
                          style: TextStyle(fontSize: AppConstants.fontSizeM),
                        )
                      ],
                    );
                  }),
            )
        ],
      ),
    );
  }

  void _showImageDialog(BuildContext context, List<String> imgList) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            child: PageView(
          children: [
            ...imgList.map(
              (e) => SizedBox(
                width: Get.width,
                height: Get.height / 2,
                child: Image.network(
                  e, // Replace with your image URL
                  fit: BoxFit.contain,
                ),
              ),
            )
          ],
        ));
      },
    );
  }
}

Widget bubble() {
  return Container(
    width: Get.width * 0.01,
    height: Get.height * 0.01,
    decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.black),
  );
}

Widget divider() {
  return Container(
    height: Get.height * 0.003,
    color: Colors.grey.withOpacity(0.1),
  );

  //  Divider(
  //   thickness: 1,
  //   color: Colors.grey.withOpacity(0.4),
  //   height: Get.height * 0.02,
  // );
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
                  child: Text(
                    "See More",
                    style: TextStyle(fontSize: AppConstants.fontSizeM),
                  ),
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
        Text(
          'About this space',
          style: TextStyle(
              fontSize: AppConstants.fontSizeL, fontWeight: FontWeight.bold),
        ),
        (Get.height * 0.02).heightBox(),
        SizedBox(
          height: widget.listing.description.length > 250
              ? _xClickSeeMore
                  ? null
                  : Get.height * 0.1
              : null,
          child: Text(
            widget.listing.description,
            style: TextStyle(fontSize: AppConstants.fontSizeL),
          ),
        ),
        10.heightBox(),
        if (widget.listing.description.length > 50)
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
        Text(
          "Offer Lists",
          style: TextStyle(
              fontSize: AppConstants.fontSizeL, fontWeight: FontWeight.bold),
        ),
        (Get.height * 0.02).heightBox(),
        SizedBox(
          height: widget.listing.listingOffers.length > 3
              ? _xClickSeeMore
                  ? null
                  : Get.height * 0.14
              : null,
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
                        width: Get.width * 0.06,
                      ),
                      10.widthBox(),
                      Text(
                        offer.name,
                        style: TextStyle(fontSize: AppConstants.fontSizeM),
                      )
                    ],
                  ),
                );
              }),
        ),
        10.heightBox(),
        if (widget.listing.listingOffers.length > 3)
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
          Text(
            'Locations',
            style: TextStyle(
                fontSize: AppConstants.fontSizeL, fontWeight: FontWeight.bold),
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
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: AppConstants.fontSizeM,
            ),
          ),
          (Get.height * 0.01).heightBox(),
          Text(
            widget.listing.listingLocation.remark,
            style: TextStyle(
                fontSize: AppConstants.fontSizeM,
                fontWeight: FontWeight.w200,
                color: AppColors.textGrey),
          ),
          (Get.height * 0.01).heightBox(),
          // topBoxShadow()
          10.heightBox(),
          if (widget.listing.listingLocation.remark.length > 50)
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        width: Get.width * 0.4,
        height: Get.width * 0.4 * 0.8,
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
                    // "https://s.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png",
                    "https://api.maptiler.com/maps/350b059e-93c6-428e-8a5a-da7f1cda974f/{z}/{x}/{y}.png?key=SD6Ev9Xf11MLip5FQDt5"),
            MarkerLayer(
              markers: [
                Marker(
                    point: latLng,
                    width: Get.width * 0.14,
                    height: Get.width * 0.14,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset('assets/images/map_pin.png'),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Icon(
                            TablerIcons.smart_home,
                            color: Colors.white,
                          ),
                        )
                      ],
                    )
                    // Container(
                    //   width: double.infinity,
                    //   height: double.infinity,
                    //   decoration: const BoxDecoration(
                    //       color: Colors.red, shape: BoxShape.circle),
                    //   padding: const EdgeInsets.all(4),
                    //   child: Container(
                    //     width: double.infinity,
                    //     height: double.infinity,
                    //     decoration: const BoxDecoration(
                    //         color: Colors.white, shape: BoxShape.circle),
                    //     alignment: Alignment.center,
                    //     child: const FittedBox(child: Icon(Icons.pin_drop)),
                    //   ),
                    // ),
                    )
              ],
            )
          ],
        ),
      ),
    );
  }
}
