import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:universe_rental/modules/home/explore/c_explore_controller.dart';

class ExploreListing extends StatelessWidget {
  const ExploreListing({super.key});

  @override
  Widget build(BuildContext context) {
    ExploreController controller = Get.find();
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      maxChildSize: 0.85,
      minChildSize: 0.1,
      snap: true,
      // snapSizes: [
      //   0.25,
      //   0.5,
      //   0.75
      // ],
      controller: controller.draggableScrollableController,
      builder: (context, scrollController) {
        return Container(
          color: Colors.white,
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                ...List.generate(100, (index) {
                  return TextButton(onPressed: () {
                  }, child: Text(index.toString()));
                })
              ],
            ),
          ),
        );
      },
    );
  }
}
