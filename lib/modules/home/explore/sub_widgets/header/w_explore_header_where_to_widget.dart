import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe_rental/services/others/extensions.dart';

import '../../../../../constants/app_colors.dart';
import '../../../../../constants/app_constants.dart';
import '../../../../where_to/v_where_to_page.dart';

class ExploreHeaderWhereToWidget extends StatelessWidget {
  const ExploreHeaderWhereToWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (c1, c2) {
        return Column(
          children: [
            GestureDetector(
              onTap: () {
                Get.to(
                    ()=> const WhereToPage(),
                    transition: Transition.noTransition,
                    duration: const Duration(milliseconds: 300),
                    opaque: false
                );
              },
              child: Hero(
                tag: "whereTo",
                child: Material(
                  color: AppColors.white,
                  child: Card(
                    margin: EdgeInsets.symmetric(
                        horizontal: AppConstants.basePadding,
                        vertical: c2.maxHeight *0.05
                    ),
                    elevation: 4,
                    shadowColor: AppColors.black.withOpacity(0.4),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10000)
                    ),
                    child: Container(
                      width: c2.maxWidth,
                      height: c2.maxHeight * 0.8,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        border: Border.all(
                            color: AppColors.borderGrey.withOpacity(0.1),
                            width: 0.4
                        ),
                        borderRadius: BorderRadius.circular(20000),
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
                                                child: Text(
                                                  "Where to?",
                                                  style: TextStyle(
                                                      color: AppColors.black,
                                                      fontSize: AppConstants.fontSizeM,
                                                      fontWeight: FontWeight.w800
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 10,
                                          child: Text(
                                            "Anywhere . Any week . Add guests",
                                            style: TextStyle(
                                                color: AppColors.black,
                                                fontSize: AppConstants.fontSizeS
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
            ),
          ],
        );
      },
    );
  }
}
