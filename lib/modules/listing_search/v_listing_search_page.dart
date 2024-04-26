import 'dart:math';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:universe_rental/modules/home/explore/sub_widgets/header/w_explore_search_bar.dart';
import 'package:universe_rental/modules/listing_search/c_listing_search.dart';
import '../../constants/app_colors.dart';

class ListingSearchPage extends StatelessWidget {
  final Size barSize;
  const ListingSearchPage({super.key,required this.barSize});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ListingSearchController());
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
              Container(
                width: double.infinity,
                height: (Get.mediaQuery.padding.top),
                decoration: BoxDecoration(
                  color: AppColors.white
                ),
              ),
              ExploreSearchBar(
                onTap: () {

                },
                onChangeText: (p0) {

                },
                txtCtrl: controller.txtSearch,
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


