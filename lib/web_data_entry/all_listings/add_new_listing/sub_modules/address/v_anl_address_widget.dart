import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:universe_rental/services/others/extensions.dart';
import 'package:universe_rental/web_data_entry/all_listings/add_new_listing/c_add_new_listing.dart';

class AnlAddressWidget extends StatefulWidget {
  const AnlAddressWidget({super.key});

  @override
  State<AnlAddressWidget> createState() => _AnlAddressWidgetState();
}

class _AnlAddressWidgetState extends State<AnlAddressWidget> {
  @override
  Widget build(BuildContext context) {
    AddNewListingController controller = Get.find();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Address Data",
          style: TextStyle(fontSize: 20),
        ),
        TextField(
          controller: controller.txtFullAddress,
          decoration: const InputDecoration(labelText: "Full Address"),
          maxLines: null,
        ),
        TextField(
          controller: controller.txtAddressRemark,
          decoration: const InputDecoration(labelText: "Address Remark"),
          maxLines: null,
        ),
        10.heightBox(),
        ValueListenableBuilder(
          valueListenable: controller.addressLocation,
          builder: (context, addressLocation, child) {
            return Container(
              width: Get.width * 0.5,
              height: Get.width * 0.4 * 0.8,
              decoration: BoxDecoration(border: Border.all()),
              child: FlutterMap(
                options: MapOptions(
                  onTap: (tapPosition, point) {
                    controller.addressLocation.value = point;
                    controller.addressLocation.notifyListeners();
                  },
                  initialCenter:
                      const LatLng(16.813451759154145, 96.13404351529357),
                  // initialCenter: LatLng(22.00591163440544, 96.1038427774457),
                  initialZoom: 17.5,
                  interactionOptions: const InteractionOptions(
                      enableMultiFingerGestureRace: true),
                  maxZoom: 20,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://s.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png",
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                          point: addressLocation,
                          width: 25,
                          height: 25,
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: const BoxDecoration(
                                color: Colors.red, shape: BoxShape.circle),
                            padding: const EdgeInsets.all(4),
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: const BoxDecoration(
                                  color: Colors.white, shape: BoxShape.circle),
                              alignment: Alignment.center,
                              child:
                                  const FittedBox(child: Icon(Icons.pin_drop)),
                            ),
                          ))
                    ],
                  )
                ],
              ),
            );
          },
        )
      ],
    );
  }
}
