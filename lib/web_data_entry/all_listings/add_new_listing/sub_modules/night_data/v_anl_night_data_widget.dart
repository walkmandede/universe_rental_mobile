import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:universe_rental/constants/app_constants.dart';
import 'package:universe_rental/constants/app_functions.dart';
import 'package:universe_rental/services/others/extensions.dart';
import 'package:universe_rental/services/overlays_services/dialog/dialog_service.dart';
import 'package:universe_rental/web_data_entry/_common/controllers/c_data_controller.dart';
import 'package:universe_rental/web_data_entry/_common/models/m_night_fee_model.dart';
import 'package:universe_rental/web_data_entry/all_listings/add_new_listing/c_add_new_listing.dart';

import '../../../../currency/m_currency_model.dart';

class AnlNightDataWidget extends StatefulWidget {
  const AnlNightDataWidget({super.key});

  @override
  State<AnlNightDataWidget> createState() => _AnlNightDataWidgetState();
}

class _AnlNightDataWidgetState extends State<AnlNightDataWidget> {
  // List<NightFeeModel> nightFeeData = [];

  ValueNotifier<DateTimeRange?> dateRange = ValueNotifier(null);
  Map<CurrencyModel, double> prices = {};
  AddNewListingController controller = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void onClickAdd() async {
    if (dateRange.value == null) {
      DialogService()
          .showSnack(title: "Error", message: "Please add date range");
    } else {
      final dates = AppFunctions().getBetweenDates(dtr: dateRange.value!);

      for (var value1 in dates) {
        final dateKey = value1.toString().substring(0, 10);

        if (prices.isEmpty) {
          controller.dailyNightFeesMap.value
              .removeWhere((key, value) => key == dateKey);
        } else {
          controller.dailyNightFeesMap.value[dateKey] = prices.entries.map((e) {
            final price = e.value;
            final currency = e.key;
            return NightFeeModel(perNightFee: price, currencyModel: currency);
          }).toList();
        }
      }

      controller.dailyNightFeesMap.notifyListeners();
    }

    prices.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Night Data (* Double Tap To Remove)",
          style: TextStyle(fontSize: 15),
        ),
        10.heightBox(),
        Container(
          padding: EdgeInsets.all(AppConstants.basePadding),
          decoration: BoxDecoration(border: Border.all()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    "Date Range",
                  ),
                  10.widthBox(),
                  ValueListenableBuilder(
                    valueListenable: dateRange,
                    builder: (context, data, child) {
                      return ElevatedButton(
                        onPressed: () async {
                          final result = await showDateRangePicker(
                              context: context,
                              firstDate: DateTime(1),
                              lastDate: DateTime(10000),
                              initialDateRange: data ??
                                  DateTimeRange(
                                      start: DateTime.now(),
                                      end: DateTime.now()));
                          dateRange.value = result;
                          dateRange.notifyListeners();
                        },
                        child: Text(
                          data == null
                              ? "Choose"
                              : "${data.start.toString().substring(0, 10)}  <->  ${data.end.toString().substring(0, 10)}",
                        ),
                      );
                    },
                  )
                ],
              ),
              10.heightBox(),
              GetBuilder<DataEntryDataController>(
                builder: (dataEntryDataController) {
                  return Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: dataEntryDataController.allCurrency.value
                        .map((eachCurrency) {
                      return SizedBox(
                        width: 100,
                        child: TextField(
                          controller: TextEditingController(text: "0"),
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: eachCurrency.abbr),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onChanged: (value) {
                            double? price = double.tryParse(value);
                            if (price != null) {
                              prices[eachCurrency] = price;
                            }
                          },
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
              10.heightBox(),
              ElevatedButton(
                  onPressed: () {
                    onClickAdd();
                  },
                  child: const Text("Add"))
            ],
          ),
        ),
        10.heightBox(),
        ValueListenableBuilder(
          valueListenable: controller.dailyNightFeesMap,
          builder: (context, dailyNightFeesMap, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: dailyNightFeesMap.entries.map((each) {
                final dateKey = each.key;
                final list = each.value;
                return ListTile(
                  title: Text(dateKey),
                  subtitle: Wrap(
                    runSpacing: 10,
                    spacing: 10,
                    children: list.map((eachCurrency) {
                      return Chip(
                        label: Text(
                            "${eachCurrency.perNightFee} ${eachCurrency.currencyModel.sign}"),
                      );
                    }).toList(),
                  ),
                );
              }).toList(),
            );
          },
        )
      ],
    );
  }
}
