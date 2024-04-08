import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:universe_rental/constants/app_colors.dart';
import 'package:universe_rental/constants/app_constants.dart';
import 'package:universe_rental/modules/_common/flutter_super_scaffold.dart';
import 'package:universe_rental/modules/_common/widgets/w_circle_profile_widget.dart';
import 'package:universe_rental/modules/home/explore/sub_widgets/detail/c_detail_controller.dart';
import 'package:universe_rental/services/others/extensions.dart';

class DetailPage extends StatelessWidget {
  DetailPage({super.key});
  final DetailController controller = Get.put(DetailController());
  @override
  Widget build(BuildContext context) {
    return FlutterSuperScaffold(
      isTopSafe: false,
      isBotSafe: false,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          SingleChildScrollView(
            controller: controller.scrollController,
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 4 / 3,
                  child: Image.asset(
                    "assets/dummy_images/image1.png",
                    // height: controller.imagePreviewHeight,
                    // width: Get.width,
                    fit: BoxFit.fill,
                  ),
                ),
                const ShortInfoWidget(),
                (Get.height * 0.01).heightBox(),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: AppConstants.paddingXXL),
                  child: Divider(
                    height: 3,
                    color: AppColors.grey,
                  ),
                ),
                const HosterWidget(),
                const AboutThisWidget(),
                (Get.height * 0.75).heightBox(),
              ],
            ),
          ),
          const Align(
              alignment: Alignment.bottomCenter, child: BottomButtomWidget()),
          Align(
            alignment: Alignment.topCenter,
            child: detailPageAppBar(),
          )
          // Positioned(
          //   top: 40,
          //   left: 20,
          //   child: IconButton(
          //       onPressed: () {},
          //       icon: CircleAvatar(
          //           backgroundColor: AppColors.white,
          //           child: Icon(Icons.keyboard_arrow_left))),
          // ),
          // Positioned(
          //   top: 40,
          //   child: Align(
          //     alignment: Alignment.topCenter,
          //     child: IconButton(
          //         onPressed: () {},
          //         icon: CircleAvatar(
          //             backgroundColor: AppColors.white,
          //             child: Icon(
          //               TablerIcons.share_2,
          //               size: AppConstants.fontSizeL,
          //             ))),
          //   ),
          // ),
          // Positioned(
          //   top: 40,
          //   right: 20,
          //   child: Align(
          //       alignment: Alignment.topCenter,
          //       child: IconButton(
          //           onPressed: () {},
          //           icon: CircleAvatar(
          //               backgroundColor: AppColors.white,
          //               child: Icon(
          //                 TablerIcons.heart,
          //                 size: AppConstants.fontSizeL,
          //               )))),
          // )
        ],
      ),
    );
  }

  Widget detailPageAppBar() {
    DetailController detailController = Get.find();
    return AnimatedBuilder(
      animation: detailController.appbarAnimationController,
      builder: (context, child) {
        final animatedValue = detailController.appbarAnimationController.value;
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: AppColors.white.withOpacity(animatedValue),
              boxShadow: [
                BoxShadow(
                    color: AppColors.grey.withOpacity(0.1 * animatedValue),
                    blurRadius: 10,
                    spreadRadius: 10)
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (Get.mediaQuery.padding.top).heightBox(),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppConstants.basePadding,
                    vertical: AppConstants.basePadding / 2),
                child: LayoutBuilder(builder: (a1, b1) {
                  return Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Transform.translate(
                        offset: Offset(
                            -(b1.maxWidth * 0.5) + AppConstants.basePadding, 0),
                        child: eachAppBarIcon(),
                      ),
                      Transform.translate(
                        offset: Offset(-(b1.maxWidth * 0.1) * animatedValue, 0),
                        child: eachAppBarIcon(),
                      ),
                      Transform.translate(
                        offset: Offset(
                            (b1.maxWidth * 0.5) -
                                AppConstants.basePadding -
                                (b1.maxWidth * 0.4 * animatedValue),
                            0),
                        child: eachAppBarIcon(),
                      ),
                    ],
                  );
                }),
              )
            ],
          ),
        );
      },
    );
  }

  Widget eachAppBarIcon() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.white,
        border: Border.all(color: AppColors.borderGrey, width: 1.2),
      ),
      alignment: Alignment.center,
      child: Icon(
        Icons.arrow_back_ios_new_rounded,
        size: 15,
      ),
    );
  }
}

class ShortInfoWidget extends StatelessWidget {
  const ShortInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppConstants.paddingXXXL,
          vertical: AppConstants.paddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "HER HUAHIN POOL VILLA",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: AppConstants.fontSizeXXL),
          ),
          (Get.height * 0.01).heightBox(),
          Text(
            "Entire villa in Tambon Hua Hin, Thailand",
            style: TextStyle(
                fontWeight: FontWeight.w700, fontSize: AppConstants.fontSizeM),
          ),
          Row(
            children: [
              Text(
                "8 guests . ",
                style: TextStyle(fontSize: AppConstants.fontSizeM),
              ),
              Text(
                "4 bedrooms . ",
                style: TextStyle(fontSize: AppConstants.fontSizeM),
              ),
              Text(
                "6 beds . ",
                style: TextStyle(fontSize: AppConstants.fontSizeM),
              ),
              Text(
                "1 bath",
                style: TextStyle(fontSize: AppConstants.fontSizeM),
              ),
            ],
          ),
          (Get.height * 0.006).heightBox(),
          Row(
            children: [
              const Icon(
                TablerIcons.star_filled,
                size: 16,
              ),
              const Text(" 4.9  .  "),
              Text(
                "15 views ",
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    decoration: TextDecoration.underline,
                    fontSize: AppConstants.fontSizeM),
              )
            ],
          )
        ],
      ),
    );
  }
}

class HosterWidget extends StatelessWidget {
  const HosterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: AppConstants.paddingXXXL,
          vertical: AppConstants.paddingL),
      padding: EdgeInsets.symmetric(
          horizontal: AppConstants.paddingXXXL,
          vertical: AppConstants.paddingXXXL),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(blurRadius: 2, spreadRadius: 3, color: AppColors.bgGrey)
      ]),
      child: Row(
        children: [
          const CircleProfileWidget(),
          20.widthBox(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hosted by Tanakan",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: AppConstants.fontSizeM),
              ),
              const Row(
                children: [Text('Normalhost . '), Text('2 years hosting')],
              )
            ],
          )
        ],
      ),
    );
  }
}

class AboutThisWidget extends StatelessWidget {
  const AboutThisWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppConstants.paddingXXXL,
          vertical: AppConstants.paddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "About This space",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: AppConstants.fontSizeM),
          ),
          (Get.height * 0.008).heightBox(),
          Text(
            "Location is Huahin soi 88. Hua Hin vacation home style minimalist. private Suitable for guests who are couples up to 4 couples and can also sleep up to 8-12 persons (Maximum 12 persons)",
            style: TextStyle(fontSize: AppConstants.fontSizeMS, height: 1.4),
          )
        ],
      ),
    );
  }
}

class BottomButtomWidget extends StatelessWidget {
  const BottomButtomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.14,
      decoration: BoxDecoration(color: AppColors.white, boxShadow: [
        BoxShadow(
            spreadRadius: 10,
            blurRadius: 20,
            offset: const Offset(0, -20),
            color: AppColors.bgGrey.withOpacity(0.8)),
      ]),
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.paddingXXL,
        vertical: AppConstants.paddingXXL,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "13-23 Mar",
                style: TextStyle(
                    color: AppColors.grey, fontSize: AppConstants.fontSizeM),
              ),
              Text(
                " \$115 night",
                style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: AppConstants.fontSizeM),
              )
            ],
          ),
          (Get.height * 0.008).heightBox(),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              backgroundColor: AppColors.black,
              minimumSize: Size(Get.width, Get.height * 0.06),
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.circular(20), // button's shape
              // ),
            ),
            child: const Text("Reserve"),
          )
        ],
      ),
    );
  }
}
