import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:universe_rental/modules/_common/widgets/w_fitted_widget.dart';
import 'package:universe_rental/modules/where_to/c_where_to.dart';
import 'package:universe_rental/services/others/extensions.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_functions.dart';

class WhereToPage extends StatelessWidget {
  const WhereToPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WhereToController());
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if(controller.card1Controller!=null){
          controller.card1Controller!.reverse();
        }
        if(controller.card2Controller!=null){
          controller.card2Controller!.reverse();
        }
      },
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1)),
        child: GlassContainer(
          blur: 8,
          color: Colors.white.withOpacity(0.1),
          child: Scaffold(
            backgroundColor: AppColors.white.withOpacity(0.3),
            appBar: AppBar(
              backgroundColor: AppColors.white,
              elevation: 0,
            ),
            body: Column(
              children: [
                whereToCard(),
                10.heightBox(),
                AnimatedBuilder(
                  animation: controller.card1Controller!,
                  builder: (context, child) {
                    final value = controller.card1Controller!.value;
                    return Opacity(
                      opacity: max(value,0.8),
                      child: Transform.translate(
                        offset: Offset(0, -1 * (AppConstants.baseButtonHeightS*1) *(1 - value)),
                        child: eachCard(text: "When"),
                      ),
                    );
                  },
                ),
                10.heightBox(),
                AnimatedBuilder(
                  animation: controller.card2Controller!,
                  builder: (context, child) {
                    final value = controller.card2Controller!.value;
                    return Opacity(
                      opacity: max(value,0.8),
                      child: Transform.translate(
                        offset: Offset(0, -1 * (AppConstants.baseButtonHeightS*1) *(1 - value)),
                        child: eachCard(text: "Who"),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget whereToCard(){
    return SizedBox(
      height: Get.height * 0.25,
      child: LayoutBuilder(
        builder: (c1, c2) {
          return GestureDetector(
            onTap: () {
              // Get.to(()=> const WhereToPage(),transition: Transition.noTransition);
            },
            child: Hero(
              tag: "whereTo",
              child: Material(
                  child: Card(
                    color: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppConstants.baseBorderRadius),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.symmetric(
                        horizontal: AppConstants.basePadding,
                    ),
                    child: Container(
                      width: c2.maxWidth,
                      height: c2.maxHeight,
                      margin: EdgeInsets.symmetric(
                        horizontal: AppConstants.basePadding,
                        vertical: AppConstants.basePadding,
                      ),
                      decoration: BoxDecoration(
                          color: AppColors.white
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Where To",
                              style: TextStyle(
                                  fontSize: AppConstants.fontSizeXL,
                                  fontWeight: FontWeight.w900
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Where To",
                              style: TextStyle(
                                  fontSize: AppConstants.fontSizeXL,
                                  fontWeight: FontWeight.w900
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(5, (index) {
                                  return const Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: AspectRatio(
                                      aspectRatio: 1/1,
                                      child: ColoredBox(
                                        color: Colors.grey,
                                        child: SizedBox.expand(),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
              ),
            ),
          );
        },
      ),
    );
  }

  Widget eachCard({required String text}){
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.baseBorderRadius),
      ),
      elevation: 5,
      margin: EdgeInsets.symmetric(
          horizontal: AppConstants.basePadding,
      ),
      child: Container(
        width: Get.width,
        height: AppConstants.baseButtonHeightL,
        padding: EdgeInsets.symmetric(
          horizontal: AppConstants.basePadding,
          vertical: AppConstants.basePadding,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppConstants.baseBorderRadius)
        ),
        child: Row(
          children: [
            Text(text)
          ],
        )
      ),
    );
  }

}


