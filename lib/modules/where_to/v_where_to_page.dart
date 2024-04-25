import 'dart:math';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:universe_rental/constants/app_functions.dart';
import 'package:universe_rental/modules/home/explore/sub_widgets/header/w_explore_search_bar.dart';
import 'package:universe_rental/modules/where_to/c_where_to.dart';
import 'package:universe_rental/services/others/extensions.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_constants.dart';

class WhereToPage extends StatelessWidget {
  final Size barSize;
  const WhereToPage({super.key,required this.barSize});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WhereToController());
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) async{

      },
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1)),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.black.withOpacity(0.3),
          body: Column(
            children: [
              (Get.mediaQuery.padding.top).heightBox(),
              ExploreSearchBar(
                onTap: () {

                },
                onChangeText: (p0) {

                },
                xReadOnly: false,
                barSize: barSize,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.transparent
                      ),
                    )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}


