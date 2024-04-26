
import 'package:flutter/material.dart';
import 'package:universe_rental/constants/app_constants.dart';

class ListingDetailAppBar extends StatelessWidget {
  const ListingDetailAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.basePadding,
        vertical: 0,
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          BackButton()
        ],
      ),
    );
  }
}
