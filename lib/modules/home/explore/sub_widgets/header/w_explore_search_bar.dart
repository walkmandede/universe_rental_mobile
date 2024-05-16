import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:universe_rental/constants/app_assets.dart';
import 'package:universe_rental/constants/app_colors.dart';
import 'package:universe_rental/constants/app_constants.dart';
import 'package:universe_rental/constants/app_functions.dart';
import 'package:universe_rental/constants/app_svgs.dart';
import 'package:universe_rental/modules/_common/widgets/w_fitted_widget.dart';
import 'package:universe_rental/modules/home/explore/sub_widgets/header/v_setting_page.dart';
import 'package:universe_rental/services/others/extensions.dart';

class ExploreSearchBar extends StatelessWidget {
  final Size barSize;
  final Function() onTap;
  final Function(String) onChangeText;
  final bool xReadOnly;
  final TextEditingController? txtCtrl;
  const ExploreSearchBar(
      {super.key,
      required this.barSize,
      required this.onTap,
      required this.onChangeText,
      required this.xReadOnly,
      this.txtCtrl});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: FittedWidget(
        child: Container(
          width: barSize.width,
          height: barSize.height,
          padding: EdgeInsets.symmetric(
            horizontal: AppConstants.basePadding,
          ),
          decoration: BoxDecoration(
              color: AppColors.white,
              border: Border(
                  bottom: BorderSide(
                color: AppColors.lineGrey,
              ))),
          child: Row(
            children: [
              SvgPicture.string(AppSvgs.search),
              (barSize.width * 0.025).widthBox(),
              Expanded(
                child: TextField(
                  controller: txtCtrl,
                  autofocus: true,
                  readOnly: xReadOnly,
                  onTap: () {
                    onTap();
                  },
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Anywhere you can search"),
                ),
              ),
              (barSize.width * 0.025).widthBox(),
              if (xReadOnly)
                GestureDetector(
                  onTap: () {
                    vibrateNow();
                  },
                  child: SvgPicture.string(AppSvgs.filter),
                ),
              if (xReadOnly) (barSize.width * 0.025).widthBox(),
              if (xReadOnly)
                GestureDetector(
                  onTap: () {
                    vibrateNow();
                    Get.to(() => const VSettingPage());
                  },
                  child: Image.asset(
                    AppAssets.dummyProfile,
                    width: barSize.width * 0.085,
                  ),
                ),
              if (!xReadOnly)
                GestureDetector(
                  onTap: () {
                    txtCtrl!.clear();
                  },
                  child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.iconGrey.withOpacity(0.8)),
                      child: SvgPicture.string(
                        AppSvgs.cencel,
                        width: Get.width * 0.05,
                        color: Colors.white,
                      )),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
