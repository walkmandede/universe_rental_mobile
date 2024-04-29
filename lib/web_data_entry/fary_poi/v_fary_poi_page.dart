import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        ),
      ),
    );
  }
}