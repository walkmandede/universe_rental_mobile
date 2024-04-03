import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircleProfileWidget extends StatelessWidget {
  final String? img;
  const CircleProfileWidget({super.key, this.img});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: img == null
          ? Image.asset('assets/dummy_images/profile.png').image
          : Image.network('').image,
    );
  }
}
