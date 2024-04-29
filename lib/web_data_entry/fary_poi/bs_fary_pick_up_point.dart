import 'package:get/get.dart';
import 'package:universe_rental/constants/app_colors.dart';
import 'package:universe_rental/constants/app_constants.dart';
import 'package:universe_rental/services/others/extensions.dart';
import 'package:universe_rental/web_data_entry/fary_poi/c_fary_poi.dart';
import 'package:flutter/material.dart';

class FaryPickUpPointBottomSheet extends StatelessWidget {
  final String label;
  final TextEditingController txtCtrlEn;
  final TextEditingController txtCtrlMm;
  final Function() onClickSubmit;
  const FaryPickUpPointBottomSheet({
    super.key,
    required this.label,
    required this.txtCtrlEn,
    required this.txtCtrlMm,
    required this.onClickSubmit,
});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FaryPoiController>(
      builder: (controller) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.white
          ),
          padding: EdgeInsets.all(
            AppConstants.basePadding,
          ),
          child: Column(
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: AppConstants.fontSizeL,
                  fontWeight: FontWeight.w700
                ),
              ),
              10.heightBox(),
              TextField(
                controller: txtCtrlEn,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Name in English"),
                ),
              ),
              10.heightBox(),
              TextField(
                controller: txtCtrlMm,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("မြန်မာ နာမည် / Name in Myanmar"),
                ),
              ),
              10.heightBox(),
              SizedBox(
                width: double.infinity,
                height: AppConstants.baseButtonHeightM,
                child: ElevatedButton(
                  onPressed: () {
                    onClickSubmit();
                  },
                  child: const Text("Submit"),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
