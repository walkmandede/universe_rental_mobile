import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:pinput/pinput.dart';
import 'package:universe_rental/web_data_entry/all_listings/m_listing_model.dart';

class ListingDetailPage extends StatelessWidget {
  final ListingModel listingData;
  const ListingDetailPage({super.key, required this.listingData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("title"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            placeData(),
            addressData(),
            hostData(),
            listType(),
            listTabs(),
            offerData(),
            attributeData(),
            listingImages(),
            listingPlacesImages(),
            nightData()
          ],
        ),
      ),
    );
  }

  placeData() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textTitle("Place Info"),
          rowText("Title -    ", listingData.title),
          rowText("Subtitle -       ", listingData.subTitle),
          rowText("About -     ", listingData.about)
        ],
      ),
    );
  }

  addressData() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textTitle("Address Info"),
          rowText("FullAddress -    ", listingData.fullAddress),
          rowText("Address Remark -       ", listingData.addressRemark),
          Container(
            width: Get.width * 0.5,
            height: Get.width * 0.4 * 0.8,
            decoration: BoxDecoration(border: Border.all()),
            child: FlutterMap(
              options: MapOptions(
                // onTap: (tapPosition, point) {
                //   controller.addressLocation.value = point;
                //   controller.addressLocation.notifyListeners();
                // },
                initialCenter: LatLng(listingData.addressLocation.latitude,
                    listingData.addressLocation.longitude),
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
                        point: LatLng(listingData.addressLocation.latitude,
                            listingData.addressLocation.longitude),
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
          )
        ],
      ),
    );
  }

  hostData() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textTitle("Host Info"),
          rowText("Host Name -    ", listingData.hostName),
        ],
      ),
    );
  }

  listType() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textTitle("Listing Type"),
          rowText("Listing Type -    ", listingData.listingType.name),
        ],
      ),
    );
  }

  listTabs() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textTitle("Listing Tabs"),
          Column(
            children: [
              ...listingData.listingTags
                  .map((listingTab) => Text("- ${listingTab.name}"))
            ],
          )
        ],
      ),
    );
  }

  offerData() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textTitle("Offer Data"),
          Column(
            children: [
              ...listingData.offerList.map((offer) => Text("- ${offer.name}"))
            ],
          )
        ],
      ),
    );
  }

  attributeData() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textTitle("Attribute Data"),
          Column(
            children: [
              ...listingData.listingAttributesQty.entries.map((attribute) =>
                  Text("- ${attribute.key.name} : ${attribute.value}"))
            ],
          )
        ],
      ),
    );
  }

  listingImages() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textTitle("Listing Images Data"),
          SizedBox(
            height: Get.height * .3,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: listingData.listingImages.length,
                itemBuilder: (contex, index) {
                  return Image.network(
                    listingData.listingImages[index],
                    width: Get.width * 0.3,
                    height: Get.height * 0.2,
                  );
                }),
          )
        ],
      ),
    );
  }

  listingPlacesImages() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textTitle("Listing Images Data"),
          Column(
            children: [
              ...listingData.listingPlacesImages.entries
                  .map((placeimg) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(placeimg.key.name),
                          SizedBox(
                            height: Get.height * .3,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: placeimg.value.length,
                                itemBuilder: (contex, index) {
                                  return Image.network(
                                    placeimg.value[index],
                                    width: Get.width * 0.3,
                                    height: Get.height * 0.2,
                                  );
                                }),
                          )
                        ],
                      ))
            ],
          )
        ],
      ),
    );
  }

  nightData() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textTitle("Night Info"),
          ...listingData.dailyNightData.entries.map((nightData) {
            return Padding(
              padding: const EdgeInsets.all(18.0),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    rowText("Date -    ", nightData.key),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...nightData.value.map((currencyData) => Text(
                            "Currency Type - ${currencyData.perNightFee} ${currencyData.currencyModel.sign}"))
                      ],
                    )
                  ],
                ),
              ),
            );
          })
        ],
      ),
    );
  }

  Widget rowText(String text1, String text2) {
    return Row(
      children: [Text(text1), Text(text2)],
    );
  }

  Widget textTitle(String txt) {
    return Text(
      txt,
      style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
    );
  }
}
