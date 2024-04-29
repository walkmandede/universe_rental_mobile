import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:universe_rental/constants/app_constants.dart';
import 'package:universe_rental/constants/app_functions.dart';
import 'package:universe_rental/modules/_common/widgets/w_fitted_widget.dart';
import 'package:universe_rental/services/overlays_services/dialog/dialog_service.dart';
import 'package:universe_rental/web_data_entry/fary_poi/c_fary_poi.dart';

class FaryPoiPage extends StatelessWidget {
  FaryPoiPage({super.key});
  final controller = Get.put(FaryPoiController());

  @override
  Widget build(BuildContext context) {
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
        body: FlutterMap(
          mapController: controller.mapController,
          options: MapOptions(
            initialCenter: const LatLng(16.813451759154145, 96.13404351529357),
            initialZoom: 17.5,
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
            //pickUpPointsLayer
            ValueListenableBuilder(
              valueListenable: controller.pickUpPoints,
              builder: (context, pickUpPoints, child) {
                return MarkerLayer(
                  markers: pickUpPoints.map((e) {
                    return Marker(
                        point: e.latLng,
                        child: GestureDetector(
                          onTap: () {
                            DialogService().showSnack(title: "Pick Up Point Name : "+e.nameEn,message: e.latLng.toString());
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
            //polyPointsLayer
            ValueListenableBuilder(
              valueListenable: controller.poiPoints,
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
            //polyArea
            ValueListenableBuilder(
              valueListenable: controller.poiPoints,
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
                        isFilled: true
                    );
                  }).toList(),
                );
              },
            ),
            //shownDataPickUpPoints
            ValueListenableBuilder(
              valueListenable: controller.shownPickUpPoints,
              builder: (context, shownPickUpPoints, child) {
                return MarkerLayer(
                  markers: [
                    ...shownPickUpPoints.map((e) {
                      return Marker(
                          point: e.latLng,
                          child: GestureDetector(
                            onTap: () {

                            },
                            onDoubleTap: () {
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
            ),
          ],
        ),
      ),
    );
  }
}