import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:universe_rental/constants/app_colors.dart';
import 'package:universe_rental/constants/app_constants.dart';
import 'package:universe_rental/constants/app_functions.dart';
import 'package:universe_rental/modules/_common/controllers/c_data_controller.dart';
import 'package:universe_rental/modules/home/explore/sub_widgets/header/c_explore_header_controller.dart';
import '../../../../_common/size_reporting_widget.dart';

class ExploreHeaderTagsWidget extends StatelessWidget {
  const ExploreHeaderTagsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ExploreHeaderController controller = Get.find();
    return LayoutBuilder(
      builder: (a1, c1) {
        return GetBuilder<DataController>(
          builder: (dataController) {
            return ValueListenableBuilder(
              valueListenable: dataController.allListingTags,
              builder: (context, allListingTags, child) {

                if(allListingTags.isEmpty){
                  return Center(
                    child: Text(
                      "There is no tag available",
                      style: TextStyle(
                        color: AppColors.grey
                      ),
                    ),
                  );
                }
                return SizedBox(
                  width: c1.maxWidth,
                  child: SingleChildScrollView(
                    // physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(
                      horizontal: AppConstants.basePadding/2
                    ),
                    child: ValueListenableBuilder(
                      valueListenable: controller.selectedTag,
                      builder: (context, selectedTag, child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: allListingTags.map((each) {
                            final xSelected = selectedTag == each;
                            return GestureDetector(
                              onTap: () {
                                vibrateNow();
                                controller.updateSelectedTag(listingTag: each);
                              },
                              child: Container(
                                height: double.infinity,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 18,
                                    vertical: c1.maxHeight * 0.2
                                ),
                                decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: AspectRatio(
                                        aspectRatio: 1,
                                        child: SvgPicture.string(
                                          each.icon,
                                          colorFilter: ColorFilter.mode(xSelected?AppColors.black:AppColors.iconGrey, BlendMode.srcIn)
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: FittedBox(
                                        child: Text(
                                          each.name,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}