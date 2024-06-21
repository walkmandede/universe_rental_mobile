import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:universe_rental/constants/app_constants.dart';
import 'package:universe_rental/constants/app_functions.dart';
import 'package:universe_rental/modules/_common/widgets/w_fitted_widget.dart';
import 'package:universe_rental/services/overlays_services/dialog/dialog_service.dart';
import 'package:universe_rental/web_data_entry/fary_poi/c_fary_poi.dart';

import 'm_fary_poi.dart';

class FaryPoiPage extends StatelessWidget {
  const FaryPoiPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FaryPoiController());
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Fary POI Page"
          ),
          actions: [
            IconButton(
              onPressed: () {
                controller.onClickSearch();
              },
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {
                controller.onClickHelp();
              },
              icon: const Icon(Icons.help),
            ),
            IconButton(
              onPressed: () {
                controller.clearData();
              },
              icon: const Icon(Icons.clear),
            ),
            IconButton(
              onPressed: () {
                controller.onClickSave();
              },
              icon: const Icon(Icons.save),
            )
          ],
        ),
        body: Stack(
          children: [
            FlutterMap(
              mapController: controller.mapController,
              options: MapOptions(
                initialCenter: const LatLng(16.813451759154145, 96.13404351529357),
                initialZoom: controller.currentZoomLevel,
                interactionOptions: const InteractionOptions(
                    enableMultiFingerGestureRace: false
                ),
                maxZoom: 20,
                onMapEvent: (p0) {
                  controller.onMapMove();
                },
                onLongPress: (tapPosition, point) {
                  controller.addPickUpPoint(point);
                },
                onTap: (tapPosition, point) {
                  controller.addPoiPoint(latLng: point);
                },
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://cartodb-basemaps-{s}.global.ssl.fastly.net/light_all/{z}/{x}/{y}.png",
                ),
                //addedPickUpPointsLayer
                ValueListenableBuilder(
                  valueListenable: controller.addedPickUpPoints,
                  builder: (context, pickUpPoints, child) {
                    return MarkerLayer(
                      markers: pickUpPoints.map((e) {
                        return Marker(
                            point: e.latLng,
                            child: GestureDetector(
                              onTap: () {
                                DialogService().showSnack(title: "Pick fffUp Point Name : ${e.nameEn}",message: e.latLng.toString());
                              },
                              onDoubleTap: () {
                                controller.removePickUpPoints(faryPickUpPoint: e);
                              },
                              child: const Card(
                                shape: CircleBorder(),
                                color: Colors.black,
                                child: Center(
                                  child: FittedWidget(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    child: Text("P",style: TextStyle(color: Colors.white),),
                                  ),
                                ),
                              ),
                            )
                        );
                      }).toList(),
                    );
                  },
                ),
                //addedPolyPointsLayer
                ValueListenableBuilder(
                  valueListenable: controller.addedPoiPoints,
                  builder: (context, poiPoints, child) {
                    return MarkerLayer(
                      markers: poiPoints.map((e) {
                        final index = poiPoints.indexOf(e)+1;
                        return Marker(
                            point: e,
                            child: GestureDetector(
                              onTap: () {

                              },
                              onDoubleTap: () {
                                controller.removePoiPoint(latLng: e);
                              },
                              child: Card(
                                shape: const CircleBorder(),
                                color: Colors.blue,
                                child: Center(
                                  child: FittedWidget(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    child: Text("$index",style: const TextStyle(color: Colors.white),),
                                  ),
                                ),
                              ),
                            )
                        );
                      }).toList(),
                    );
                  },
                ),
                //addedPolyArea
                ValueListenableBuilder(
                  valueListenable: controller.addedPoiPoints,
                  builder: (context, poiPoints, child) {
                    if(poiPoints.length<2){
                      return Container();
                    }
                    else{
                      return PolygonLayer(
                        polygons: [
                          Polygon(
                            points: poiPoints,
                            color: Colors.blue.withOpacity(0.2),
                            borderColor: Colors.blue,
                            isFilled: true
                          )
                        ],
                      );
                    }
                  },
                ),
                //shownDataPoi
                ValueListenableBuilder(
                  valueListenable: controller.xShowPolygon,
                  builder: (context, xShowPolygon, child) {
                    if(!xShowPolygon){
                      return const SizedBox.shrink();
                    }
                    else{
                      return ValueListenableBuilder(
                        valueListenable: controller.shownData,
                        builder: (context, shownData, child) {
                          return PolygonLayer(
                            polygons: shownData.map((e) {
                              return Polygon(
                                points: e.poiPoints,
                                strokeCap: StrokeCap.round,
                                color: Colors.green.withOpacity(0.2),
                                borderColor: Colors.green,
                                label: '${e.nameEn}\n${e.nameMm}',
                                labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: AppConstants.fontSizeS
                                ),
                                isFilled: true,
                              );
                            }).toList(),
                          );
                        },
                      );
                    }
                  },
                ),
                //shownDataPickUpPoints
                ValueListenableBuilder(
                  valueListenable: controller.xShowPolygon,
                  builder: (context, xShowPolygon, child) {
                    if(!xShowPolygon){
                      return const SizedBox.shrink();
                    }
                    else{
                      return ValueListenableBuilder(
                        valueListenable: controller.shownPickUpPoints,
                        builder: (context, shownPickUpPoints, child) {
                          return MarkerLayer(
                            markers: [
                              ...shownPickUpPoints.map((e) {
                                return Marker(
                                    point: e.latLng,
                                    child: GestureDetector(
                                      onTap: () async{
                                        // DialogService().showSnack(title: "${e.nameEn} (${e.nameMm})", message: e.latLng.toString());
                                        FaryPoi? faryPoi = controller.shownData.value.where((element) => element.id == e.poiId,).firstOrNull;
                                        if(faryPoi!=null){
                                          final result = faryPoi.faryPickUpPoints.map((e) {
                                            return "'${e.latLng.latitude},${e.latLng.longitude}'";
                                          },).toList().toString();
                                          await Clipboard.setData(ClipboardData(text: result));
                                          DialogService().showSnack(title: "Copied to clipboard", message: e.latLng.toString());

                                        }
                                      },
                                      onDoubleTap: () {
                                        final result = controller.shownData.value.where((element) => element.id == e.poiId).firstOrNull;
                                        if(result!=null){
                                          controller.onClickDeletePoi(faryPoi: result);
                                        }
                                      },
                                      child: const Card(
                                        shape: CircleBorder(),
                                        color: Colors.green,
                                        child: Center(
                                          child: FittedWidget(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            child: Text("P",style: TextStyle(color: Colors.white),),
                                          ),
                                        ),
                                      ),
                                    )
                                );
                              }).toList()
                            ],
                          );
                        },
                      );
                    }
                  },
                ),
                //shownDataMarkerOnly
                ValueListenableBuilder(
                  valueListenable: controller.xShowPolygon,
                  builder: (context, xShowPolygon, child) {
                    if(xShowPolygon){
                      return const SizedBox.shrink();
                    }
                    else{
                      return ValueListenableBuilder(
                        valueListenable: controller.shownData,
                        builder: (context, shownData, child) {
                          return MarkerClusterLayerWidget(
                            options: MarkerClusterLayerOptions(
                              spiderfyCircleRadius: 80,
                              spiderfySpiralDistanceMultiplier: 2,
                              circleSpiralSwitchover: 12,
                              maxClusterRadius: 250,
                              rotate: true,
                              size: const Size(40, 40),
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(50),
                              maxZoom: 15,
                              markers: shownData.map((e) {
                                return Marker(
                                  point: e.poiPoints.first,
                                  width: Get.width * 0.1,
                                  child: Card(
                                    color: Colors.green,
                                    child: Text(e.nameMm.toString(),style: const TextStyle(color: Colors.white),),
                                  )
                                );
                              }).toList(),
                              polygonOptions: const PolygonOptions(
                                  borderColor: Colors.blueAccent,
                                  color: Colors.black12,
                                  borderStrokeWidth: 3),
                              builder: (context, markers) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.green,
                                  ),
                                  child: Center(
                                    child: Text(
                                      markers.length.toString(),
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ],
            ),
            ValueListenableBuilder(
              valueListenable: controller.xFetching,
              builder: (context, xFetching, child) {
                if(!xFetching){
                  return const SizedBox.shrink();
                }
                else{
                  return Align(
                    alignment: Alignment.topCenter,
                    child: Card(
                      elevation: 20,
                      margin: EdgeInsets.only(
                        top: Get.height * 0.05,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                            "Fetching Data ..."
                        ),
                      ),
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}