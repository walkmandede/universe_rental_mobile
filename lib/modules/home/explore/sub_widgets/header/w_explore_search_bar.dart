import 'package:flutter/material.dart';
import 'package:universe_rental/constants/app_colors.dart';
import 'package:universe_rental/constants/app_constants.dart';
import 'package:universe_rental/modules/_common/widgets/w_fitted_widget.dart';
import 'package:universe_rental/services/others/extensions.dart';

class ExploreSearchBar extends StatelessWidget {
  final Size barSize;
  final Function() onTap;
  final Function(String) onChangeText;
  final bool xReadOnly;
  const ExploreSearchBar({
    super.key,
    required this.barSize,
    required this.onTap,
    required this.onChangeText,
    required this.xReadOnly
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
              const Icon(Icons.search),
              (barSize.width*0.025).widthBox(),
              Expanded(
                child: TextField(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
