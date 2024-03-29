import 'package:backdrop/backdrop.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe_rental/constants/app_functions.dart';
import 'package:universe_rental/modules/home/explore/c_explore_controller.dart';
import 'package:universe_rental/modules/home/explore/sub_widgets/v_explore_header.dart';
import 'package:universe_rental/modules/home/explore/sub_widgets/v_explore_listing.dart';
import 'package:universe_rental/modules/home/explore/sub_widgets/v_explore_map.dart';
import 'package:universe_rental/modules/home/sub_widgets/w_home_navi_bar.dart';

class ExploreMainPage extends StatelessWidget {
  const ExploreMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =  Get.put(ExploreController());
    return ValueListenableBuilder(
      valueListenable: controller.xLoaded,
      builder: (context, xLoaded, child) {
        if(!xLoaded){
          return Container();
        }
        else{
          return const Stack(
            children: [
              ExploreMap(),
              ExploreListing(),
              Align(
                alignment: Alignment.topCenter,
                child: ExploreHeader(),
              ),
            ],
          );
        }
      },
    );
  }
}
