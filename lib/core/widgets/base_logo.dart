import 'package:flutter/material.dart';

import '../assets/assets.dart';

class BaseLogo extends StatelessWidget {
  const BaseLogo({super.key, this.height});

  final double? height;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        ImagesResource.pngAppLogo,
        height: height ?? 90,
        fit: BoxFit.cover,
      ),
    );
  }
}
