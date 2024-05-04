import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe_rental/constants/app_constants.dart';
import 'package:universe_rental/web_data_entry/currency/new/c_add.dart';

class CurrencyAddPage extends StatefulWidget {
  const CurrencyAddPage({super.key});

  @override
  State<CurrencyAddPage> createState() => _CurrencyAddPageState();
}

class _CurrencyAddPageState extends State<CurrencyAddPage> {
  final controller = Get.put(CurrencyAddController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<CurrencyAddController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Currency Add Page"),
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
                  controller: controller.txtAbbr,
                  decoration: const InputDecoration(
                    labelText: "Abbr",
                  ),
                ),
                TextField(
                  controller: controller.txtSign,
                  decoration: const InputDecoration(
                    labelText: "Sign",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
