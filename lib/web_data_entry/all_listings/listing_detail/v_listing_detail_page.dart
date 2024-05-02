import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:universe_rental/web_data_entry/all_listings/listing_detail/c_listing_detail_controller.dart';
import 'package:universe_rental/web_data_entry/all_listings/m_listing_model.dart';

class ListingDetailPage extends StatelessWidget {
  ListingDetailPage({super.key});
  final controller = Get.put(ListingDetailController());
  @override
  Widget build(BuildContext context) {
    // controller.updateData(Get.arguments['id'].toString());
    return Scaffold(
      appBar: AppBar(
        title: const Text(" Listing Page"),
      ),
      body: ValueListenableBuilder(
          valueListenable: controller.listingDetail,
          builder: (context, detail, child) {
            ListingModel _data = detail;
            return SingleChildScrollView(
              child: Column(
                children: [
                  ValueWithLabelWidget(title: "Title", value: _data.title),
                  ValueWithLabelWidget(
                      title: "Subtitle", value: _data.subTitle),
                  ValueWithLabelWidget(title: "About", value: _data.about),
                  ValueWithLabelWidget(
                      title: "Full Address", value: _data.fullAddress),
                  ValueWithLabelWidget(
                      title: "Address remark", value: _data.addressRemark),
                  MapWidget(latLng: _data.addressLocation),
                  // ValueWithLabelWidget(title: "laglug", value: "laglung"),
                  ValueWithLabelWidget(
                      title: "Host Name", value: _data.hostName),
                  ValueWithLabelWidget(
                      title: "Type", value: _data.listingType.name),
                  RowAttributeWidget(
                    title: "Tags",
                    label: _data.listingTags.map((e) => e.name).toList(),
                    icon: _data.listingTags.map((e) => e.icon).toList(),
                  ),
                  RowAttributeWidget(
                    title: "Offers",
                    label: _data.offerList.map((e) => e.name).toList(),
                    icon: _data.offerList.map((e) => e.icon).toList(),
                  ),
                  RowAttributeWidget(
                    title: "Attributes",
                    label: _data.listingAttributesQty.entries
                        .map((e) => e.key.name)
                        .toList(),
                    value: _data.listingAttributesQty.entries
                        .map((e) => e.value.toString())
                        .toList(),
                  ),
                  Wrap(
                    runSpacing: 10,
                    children: [
                      ..._data.imgList.map((e) => Image.network(
                            e,
                            width: Get.width * 0.2,
                            height: Get.height * 0.2,
                          )),
                    ],
                  ),
                  ..._data.dailyNightData.entries.map((nightData) {
                    return ListTile(
                      title: Text(nightData.key),
                      subtitle: Wrap(
                        runSpacing: 10,
                        spacing: 10,
                        children: nightData.value.map((eachCurrency) {
                          return Chip(
                            label: Text(
                                "${eachCurrency.values.first} ${eachCurrency.keys.first.sign}"),
                          );
                        }).toList(),
                      ),
                    );
                  }),

                  ..._data.listingPlacesImages.entries.map((place) {
                    return ListTile(
                      title: Text(place.key.name),
                      subtitle: Wrap(
                        children: place.value
                            .map((placeimg) => Image.network(
                                  placeimg,
                                  width: Get.width * 0.2,
                                  height: Get.height * 0.1,
                                ))
                            .toList(),
                      ),
                    );
                  }),
                ],
              ),
            );
          }),
    );
  }
}

class ValueWithLabelWidget extends StatelessWidget {
  String title;
  String value;
  ValueWithLabelWidget({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            "$title  -   ",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          Text(value)
        ],
      ),
    );
  }
}

class RowAttributeWidget extends StatelessWidget {
  List<String> label;
  String title;
  List<String>? value;
  List<String>? icon;
  RowAttributeWidget(
      {super.key,
      required this.title,
      required this.label,
      this.value,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title),
        Row(
          children: [
            ...label.map(
              (e) {
                int _index = label.indexOf(e);
                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                      border: Border.all(width: 2),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12))),
                  child: Row(
                    children: [
                      if (icon != [] && icon != null)
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: SvgPicture.string(
                            icon!.elementAt(_index),
                          ),
                        ),
                      Text(e),
                      if (value != [] && value != null)
                        Text("  :  ${value!.elementAt(_index)}")
                    ],
                  ),
                );
              },
            ),
          ],
        )
      ],
    );
  }
}

class MapWidget extends StatelessWidget {
  final LatLng latLng;
  const MapWidget({super.key, required this.latLng});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.4,
      height: Get.width * 0.4 * 0.8,
      decoration: BoxDecoration(border: Border.all()),
      child: FlutterMap(
        options: MapOptions(
          initialCenter: latLng,
          initialZoom: 17.5,
          interactionOptions:
              const InteractionOptions(enableMultiFingerGestureRace: true),
          maxZoom: 20,
        ),
        children: [
          TileLayer(
              urlTemplate:
                  // "https://s.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png",
                  "https://api.maptiler.com/maps/350b059e-93c6-428e-8a5a-da7f1cda974f/{z}/{x}/{y}.png?key=SD6Ev9Xf11MLip5FQDt5"),
          MarkerLayer(
            markers: [
              Marker(
                  point: latLng,
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
                      child: const FittedBox(child: Icon(Icons.pin_drop)),
                    ),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
