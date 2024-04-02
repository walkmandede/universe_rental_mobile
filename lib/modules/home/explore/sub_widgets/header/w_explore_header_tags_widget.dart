import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe_rental/constants/app_functions.dart';
import 'package:universe_rental/modules/home/explore/sub_widgets/header/c_explore_header_controller.dart';
import 'package:universe_rental/services/others/extensions.dart';

import '../../../../../constants/app_colors.dart';
import '../../../../../constants/app_constants.dart';
import '../../../../_common/size_reporting_widget.dart';
import '../../../../where_to/v_where_to_page.dart';

class ExploreHeaderTagsWidget extends StatelessWidget {
  const ExploreHeaderTagsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ExploreHeaderController());
    return LayoutBuilder(
      builder: (c1, c2) {
        return Stack(
          children: [
            SingleChildScrollView(
              // physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              controller: controller.scrollController,
              padding: EdgeInsets.zero,
              child: Row(
                children: controller.tags.map((e) {
                  return SizeReportingWidget(
                    onSizeChanged: (p0) {
                      controller.eachTagSize[e] = p0;
                    },
                    child: Container(
                      height: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(Icons.telegram),
                          Text(
                            e,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(
                  // horizontal: AppConstants.basePadding
                ),
                child: Row(
                  children: [
                    Flexible(
                      child: LayoutBuilder(
                        builder: (d1, d2) {
                          return ValueListenableBuilder(
                            valueListenable: controller.scrollPositionInPotion,
                            builder: (context, scrollPositionInPotion, child) {
                              final xOffset = (d2.maxWidth * scrollPositionInPotion)-(40*scrollPositionInPotion);
                              return Transform.translate(
                                offset: Offset(xOffset,0),
                                child: Container(
                                  // width: max(0,(d2.maxWidth * scrollPositionInPotion)-40),
                                  width: 30,
                                  height: 1.5,
                                  color: AppColors.black,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}