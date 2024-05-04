import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universe_rental/modules/home/explore/sub_widgets/header/v_explore_header.dart';
import 'package:universe_rental/modules/home/explore/sub_widgets/listing/v_explore_listing.dart';
import 'package:universe_rental/modules/home/explore/sub_widgets/listing_map/v_listing_map.dart';

class ExploreMainPage extends StatelessWidget {
  const ExploreMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (c1, c2) {
        final baseSize = Size(c2.maxWidth, c2.maxHeight);
        return Stack(
          children: [
            ListingMapPage(
              baseSize: baseSize,
            ),
            ExploreListing(
              baseSize: baseSize,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: ExploreHeader(
                baseSize: baseSize,
              ),
            ),
          ],
        );
      },
    );
  }
}
