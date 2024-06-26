import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe_rental/modules/home/explore/sub_widgets/header/w_explore_search_bar.dart';
import '../../../../listing_search/v_listing_search_page.dart';

class ExploreHeaderWhereToWidget extends StatelessWidget {
  const ExploreHeaderWhereToWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (c1, c2) {
        return ExploreSearchBar(
            barSize: Size(c2.maxWidth, c2.maxHeight),
            onTap: () {
              Get.to(
                  () => ListingSearchPage(
                        barSize: Size(c2.maxWidth, c2.maxHeight),
                      ),
                  transition: Transition.noTransition,
                  duration: const Duration(milliseconds: 300),
                  opaque: false);
            },
            onChangeText: (p0) {},
            xReadOnly: true);
      },
    );
  }
}
