import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:universe_rental/constants/app_constants.dart';
import 'package:universe_rental/constants/app_functions.dart';
import 'package:universe_rental/modules/_common/widgets/w_fitted_widget.dart';
import 'package:universe_rental/modules/home/explore/c_explore_controller.dart';
import 'package:universe_rental/modules/home/explore/sub_widgets/header/w_explore_header_tags_widget.dart';
import 'package:universe_rental/modules/home/explore/sub_widgets/header/w_explore_header_where_to_widget.dart';
import 'package:universe_rental/modules/where_to/v_where_to_page.dart';
import 'package:universe_rental/services/others/extensions.dart';

import '../../../../../constants/app_colors.dart';

class ExploreHeader extends StatelessWidget {
  final Size baseSize;
  const ExploreHeader({super.key,required this.baseSize});

  @override
  Widget build(BuildContext context) {
    ExploreController controller = Get.find();
    return LayoutBuilder(
      builder: (c1,c2) {
        final baseHeaderHeight = baseSize.height * controller.headerBarHeight;
        return Card(
          margin: EdgeInsets.zero,
          elevation: 2,
          shadowColor: AppColors.grey.withOpacity(0.4),
          child: Container(
            width: double.infinity,
            height: baseHeaderHeight,
            decoration: const BoxDecoration(
              color: Colors.white
            ),
            child: const Column(
              children: [
                Expanded(
                  flex: 4,
                  child: Row(
                    children: [
                      Expanded(
                        child: ExploreHeaderWhereToWidget(),
                      )
                    ],
                  )
                ),
                Expanded(
                  flex: 5,
                  child: ExploreHeaderTagsWidget(),
                ),
              ],
            ),
          ),
        );
      }
    );
  }



}
