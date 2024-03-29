import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:universe_rental/constants/app_constants.dart';
import 'package:universe_rental/constants/app_functions.dart';
import 'package:universe_rental/modules/_common/widgets/w_fitted_widget.dart';
import 'package:universe_rental/modules/where_to/v_where_to_page.dart';
import 'package:universe_rental/services/others/extensions.dart';

import '../../../../constants/app_colors.dart';

class ExploreHeader extends StatelessWidget {
  const ExploreHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final baseHeaderHeight = Get.height * 0.2;
    return Container(
      width: double.infinity,
      height: baseHeaderHeight,
      decoration: const BoxDecoration(
        color: Colors.white
      ),
      child: Column(
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (c1, c2) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: c2.maxHeight *0.15,
                    horizontal: c2.maxHeight * 0.15,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: whereToCard(),
                      )
                    ],
                  ),
                );
              },
            )
          ),
          Expanded(
            child: Placeholder(),
          ),
        ],
      ),
    );
  }

  Widget whereToCard(){
    return LayoutBuilder(
      builder: (c1, c2) {
        return Column(
          children: [
            GestureDetector(
              onTap: () {
                Get.to(()=> const WhereToPage(),transition: Transition.noTransition,);
              },
              child: Hero(
                tag: "whereTo",
                child: Material(
                  child: Container(
                    width: c2.maxWidth,
                    height: c2.maxHeight,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20000),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 5,
                            spreadRadius: 5,
                          ),
                        ]
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: c2.maxHeight *0.15,
                      horizontal: c2.maxHeight * 0.2,
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search),
                        (c2.maxWidth*0.05).widthBox(),
                        Expanded(
                          child: LayoutBuilder(
                              builder: (d1,d2) {

                                return SizedBox(
                                  width: d2.maxWidth,
                                  height: d2.maxHeight,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 11,
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: FittedBox(
                                                child: Text(
                                                  "Where to?",
                                                  style: TextStyle(
                                                      color: AppColors.black,
                                                      fontSize: AppConstants.fontSizeXL,
                                                      fontWeight: FontWeight.w800
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 10,
                                        child: FittedBox(
                                          child: Text(
                                            "Anywhere . Any week . Add guests",
                                            style: TextStyle(
                                                color: AppColors.black,
                                                fontSize: AppConstants.fontSizeXL
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

  }

}
