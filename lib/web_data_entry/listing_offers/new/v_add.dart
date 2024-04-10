import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe_rental/constants/app_constants.dart';
import 'package:universe_rental/services/others/extensions.dart';
import 'package:universe_rental/web_data_entry/currency/new/c_add.dart';
import 'package:universe_rental/web_data_entry/listing_offers/new/c_add.dart';

class ListingOfferAddPage extends StatefulWidget {
  const ListingOfferAddPage({super.key});

  @override
  State<ListingOfferAddPage> createState() => _ListingOfferAddPageState();
}

class _ListingOfferAddPageState extends State<ListingOfferAddPage> {
  final controller = Get.put(ListingOfferAddController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<ListingOfferAddController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Listing Offer Add Page"
          ),
          actions: [
            IconButton(
              onPressed: () {
                controller.onClickSave();
              },
              icon: const Icon(Icons.save),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(AppConstants.basePadding),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: controller.txtName,
                  decoration: const InputDecoration(
                    labelText: "Name",
                  ),
                ),
                TextField(
                  controller: controller.txtSvg,
                  decoration: const InputDecoration(
                    labelText: "Svg String",
                  ),
                ),
                10.heightBox(),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all()
                  ),
                  child: ValueListenableBuilder(
                    valueListenable: controller.svgData,
                    builder: (context, svgData, child) {
                      if(svgData==null){
                        return const Icon(Icons.question_mark_rounded);
                      }
                      else{
                        return SvgPicture.string(
                          svgData,
                          width: 50,
                          height: 50,
                          placeholderBuilder: (context) {
                            return const Icon(Icons.question_mark_rounded);
                          },
                        );
                      }
                    },
                  ),
                )
            
              ],
            ),
          ),
        ),
      ),
    );
  }
}
