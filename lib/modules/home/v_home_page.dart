import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe_rental/constants/app_constants.dart';
import 'package:universe_rental/constants/app_functions.dart';
import 'package:universe_rental/modules/_common/flutter_super_scaffold.dart';
import 'package:universe_rental/modules/_common/loading/v_loading_page.dart';
import 'package:universe_rental/modules/home/c_home_controller.dart';
import 'package:universe_rental/modules/home/chat/v_chat_page.dart';
import 'package:universe_rental/modules/home/explore/v_explore_main_page.dart';
import 'package:universe_rental/modules/home/favorite/v_favorites_page.dart';
import 'package:universe_rental/modules/home/sub_widgets/w_home_navi_bar.dart';
import 'package:universe_rental/services/others/extensions.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(HomeController());

    return FlutterSuperScaffold(
      isTopSafe: true,
      isBotSafe: false,
      superBarColor: SuperBarColor(
        xTopIconWhite: false,
        topBarColor: Colors.transparent
      ),
      isResizeToAvoidBottomInset: false,
      body: SizedBox.expand(
        child: ValueListenableBuilder(
          valueListenable: controller.xLoading,
          builder: (context, xLoading, child) {
            if(xLoading){
              return const LoadingPage();
            }
            else{
              return Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: ValueListenableBuilder(
                          valueListenable: controller.currentPage,
                          builder: (context, currentPage, child) {
                            switch(currentPage){
                              case 0 : return const ExploreMainPage();
                              case 1 : return FavoritePage();
                              case 2 : return const Placeholder();
                              case 3 : return const ChatPage();
                              default: return const SizedBox.expand();
                            }
                          },
                        ),
                      ),
                      ValueListenableBuilder(
                        valueListenable: controller.currentPage,
                        builder: (context, currentPage, child) {
                          if(currentPage!=0){
                            return (AppConstants.baseNaviBarHeight).heightBox();
                          }
                          else{
                            return const SizedBox.shrink();
                          }
                        },
                      )
                    ],
                  ),
                  const Align(
                    alignment: Alignment.bottomCenter,
                    child: HomeNaviBar(),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
