import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:universe_rental/constants/app_assets.dart';
import 'package:universe_rental/constants/app_colors.dart';
import 'package:universe_rental/constants/app_constants.dart';
import 'package:universe_rental/constants/app_functions.dart';
import 'package:universe_rental/modules/_common/widgets/w_fitted_widget.dart';
import 'package:universe_rental/modules/home/explore/c_explore_controller.dart';
import 'package:universe_rental/modules/home/explore/sub_widgets/listing_map/c_listing_map.dart';

class ListingMapPage extends StatelessWidget {
  final Size baseSize;
  ListingMapPage({super.key,required this.baseSize});
  final controller = Get.put(ListingMapController());

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1)),
      child: SizedBox.expand(
        child: Stack(
          children: [
            FlutterMap(
              mapController: controller.mapController,
              options: MapOptions(
                initialCenter: const LatLng(16.813451759154145, 96.13404351529357),
                initialZoom: 17.5,
                interactionOptions: const InteractionOptions(
                    enableMultiFingerGestureRace: true
                ),
                maxZoom: 20,
                onMapEvent: (p0) {
                  controller.onMapMove();
                },
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://cartodb-basemaps-{s}.global.ssl.fastly.net/light_all/{z}/{x}/{y}.png",
                ),
                ValueListenableBuilder(
                  valueListenable: controller.shownData,
                  builder: (context, shownData, child) {
                    return MarkerLayer(
                      markers: shownData.map((eachData) {
                        return Marker(
                          point: eachData.listingLocation.latLng,
                          width: controller.baseMarkerWidth,
                          height: controller.baseMarkerWidth * 0.5,
                          child: Card(
                            color: AppColors.white,
                            elevation: 5,
                            shadowColor: AppColors.grey.withOpacity(0.4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2000)
                            ),
                            child: LayoutBuilder(
                              builder: (a1, c1) {
                                return Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: c1.maxWidth * 0.1,
                                    vertical: c1.maxWidth * 0.1
                                  ),
                                  child: FittedWidget(
                                    child: Text(
                                      eachData.getNightDataString()
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        );
                      }).toList(),
                    );
                  },
                )
              ],
            ),
            Align(
              alignment: Alignment.topCenter,
              child: GetBuilder<ExploreController>(
                builder: (exploreController) {
                  return Padding(
                    padding: EdgeInsets.only(
                      top: Get.height * exploreController.headerBarHeight
                    ),
                    child: ValueListenableBuilder(
                      valueListenable: controller.xFetching,
                      builder: (context, xFetching, child) {
                        if(xFetching){
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2000)
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppConstants.basePadding/2,
                                vertical: AppConstants.basePadding/4
                              ),
                              child: const Text("Loading"),
                            ),
                          );
                        }
                        else{
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  );
                },
              ),
            )
          ],
        ),
      )
    );
  }
}