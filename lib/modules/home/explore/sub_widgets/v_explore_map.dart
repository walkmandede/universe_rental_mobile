import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class ExploreMap extends StatelessWidget {
  final Size baseSize;
  const ExploreMap({super.key,required this.baseSize});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: FlutterMap(
        options: const MapOptions(
          initialCenter: LatLng(16.813451759154145, 96.13404351529357),
          initialZoom: 17.5,
          interactionOptions: InteractionOptions(
            enableMultiFingerGestureRace: true
          ),
          maxZoom: 20,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://s.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png",
          ),
        ],
      ),
    );
  }
}
