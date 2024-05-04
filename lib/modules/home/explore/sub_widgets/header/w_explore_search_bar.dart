import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universe_rental/constants/app_assets.dart';
import 'package:universe_rental/constants/app_colors.dart';
import 'package:universe_rental/constants/app_constants.dart';
import 'package:universe_rental/constants/app_functions.dart';
import 'package:universe_rental/constants/app_svgs.dart';
import 'package:universe_rental/modules/_common/widgets/w_fitted_widget.dart';
import 'package:universe_rental/services/others/extensions.dart';

class ExploreSearchBar extends StatelessWidget {
  final Size barSize;
  final Function() onTap;
  final Function(String) onChangeText;
  final bool xReadOnly;
  final TextEditingController? txtCtrl;
  const ExploreSearchBar({
    super.key,
    required this.barSize,
    required this.onTap,
    required this.onChangeText,
    required this.xReadOnly,
    this.txtCtrl
  });

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
                  )
              )
          ),
          child: Row(
            children: [
              SvgPicture.string(AppSvgs.search),
              (barSize.width*0.025).widthBox(),
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
                      hintText: "Anywhere you can search"
                  ),
                ),
              ),
              (barSize.width*0.025).widthBox(),
              if(xReadOnly)GestureDetector(
                onTap: () {
                  vibrateNow();
                },
                child: SvgPicture.string(AppSvgs.filter),
              ),
              if(xReadOnly)(barSize.width*0.025).widthBox(),
              if(xReadOnly)GestureDetector(
                onTap: () {
                  vibrateNow();
                },
                child: Image.asset(AppAssets.dummyProfile,width: barSize.width*0.085,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
