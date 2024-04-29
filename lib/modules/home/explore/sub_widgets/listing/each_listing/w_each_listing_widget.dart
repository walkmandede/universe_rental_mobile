
// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:universe_rental/constants/app_colors.dart';
import 'package:universe_rental/constants/app_constants.dart';
import 'package:universe_rental/constants/app_functions.dart';
import 'package:universe_rental/constants/app_svgs.dart';
import 'package:universe_rental/modules/_common/controllers/c_data_controller.dart';
import 'package:universe_rental/modules/_common/models/m_listing_detail.dart';
import 'package:universe_rental/modules/home/explore/sub_widgets/listing/each_listing/c_each_listing.dart';
import 'package:universe_rental/modules/home/listing_detail/v_listing_detail_page.dart';
import 'package:universe_rental/services/others/extensions.dart';

class EachListingWidget extends StatefulWidget {
  final ListingDetail each;
  const EachListingWidget({super.key,required this.each});

  @override
  State<EachListingWidget> createState() => _EachListingWidgetState();
}

class _EachListingWidgetState extends State<EachListingWidget> {

  ListingDetail? listingDetail;
  ValueNotifier<int> currentShownImageIndex = ValueNotifier(0);
  PageController pageController = PageController(initialPage: 0,keepPage: true);

  @override
  void initState() {
    initLoad();
    super.initState();
  }

  Future<void> initLoad() async{
    if(listingDetail==null){
      listingDetail = widget.each;
      null;
    }
  }

  void onPageChanged(int pageIndex){
    currentShownImageIndex.value = pageIndex;
    currentShownImageIndex.notifyListeners();
  }

  void movePage({required int pageIndex,required String id}){
    try{
      if(id == listingDetail!.id){
        pageController.jumpToPage(pageIndex);
      }
    }
    catch(e){
      null;
    }
  }

  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      key: GlobalKey(),
      onTap: () {
        superPrint(widget.each.id);
        Get.to(()=> ListingDetailPage(
            id: widget.each.id,
            images: widget.each.imageList,
            imageShownIndex: currentShownImageIndex.value,
        ));
      },
      child: GetBuilder<DataController>(
        builder: (dataController) {
          return ValueListenableBuilder(
            valueListenable: dataController.favoriteListingIds,
            builder: (context, favoriteListingIds, child) {
              bool xIsFavorite = favoriteListingIds.contains(widget.each.id);
              return Column(
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
                                tag: "imageList${widget.each.id}",
                                child: PageView(
                                  key: GlobalKey(),
                                  controller: pageController,
                                  onPageChanged: (value) {
                                    onPageChanged(value);
                                  },
                                  children: [
                                    ...widget.each.imageList.map((e) {
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
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ...List.generate(widget.each.imageList.length, (index) {
                                        return ValueListenableBuilder(
                                          valueListenable: currentShownImageIndex,
                                          builder: (context, currentShownImageIndex, child) {
                                            bool xSelected = index == currentShownImageIndex;
                                            return Card(
                                              color: xSelected?AppColors.white:AppColors.grey,
                                              shape: const CircleBorder(),
                                              child: const SizedBox(width: 10,height: 10,),
                                            );
                                          },
                                        );
                                      })
                                    ],
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  onPressed: () {
                                    dataController.toggleSpFavorites(listingId: widget.each.id);
                                  },
                                  icon: Icon(
                                    xIsFavorite?Icons.favorite_rounded:Icons.favorite_border_rounded,
                                    color: xIsFavorite?AppColors.red:AppColors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                  ),
                  5.heightBox(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          widget.each.title,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: AppConstants.fontSizeM
                          ),
                        ),
                      ),
                      10.widthBox(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.string(AppSvgs.star),
                          4.widthBox(),
                          Text(
                            "4.5",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: AppConstants.fontSizeM
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Text(
                    widget.each.subTitle,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: AppConstants.fontSizeM,
                        color: AppColors.textGrey
                    ),
                  ),
                  Text(
                    widget.each.getDateString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: AppConstants.fontSizeM,
                        color: AppColors.textGrey
                    ),
                  ),
                  Text(
                    widget.each.getNightDataString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: AppConstants.fontSizeM,
                        color: AppColors.black
                    ),
                  ),
                  (AppConstants.basePadding).heightBox(),
                ],
              );
            },
          );
        },
      ),
    );
  }
}