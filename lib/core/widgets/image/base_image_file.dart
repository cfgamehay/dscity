import 'dart:io';

import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class BaseImageFile extends StatelessWidget {
  const BaseImageFile({
    super.key,
    required this.imagePath,
    this.imageWidth,
    this.imageHeight,
    this.isCircle = false,
    this.borderRadius,
    this.fit = BoxFit.cover,
  });

  final String imagePath;
  final double? imageWidth;
  final double? imageHeight;
  final bool isCircle;
  final BorderRadiusGeometry? borderRadius;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    if (imagePath.isEmpty) {
      return Container(
        width: imageWidth,
        height: imageHeight,
        decoration: BoxDecoration(
          shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: isCircle ? null : borderRadius,
          color: AppColors.grey200,
        ),
        child: Icon(
          Icons.image,
          color: AppColors.white,
          size: imageHeight == null ? null : imageHeight! / 2,
        ),
      );
    }
    return Container(
      width: imageWidth,
      height: imageHeight,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: isCircle ? null : borderRadius,
        color: AppColors.grey200,
      ),
      child: Image(
        image: FileImage(File(imagePath)),
        fit: fit,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                        (loadingProgress.expectedTotalBytes ?? 1)
                  : null,
            ),
          );
          // return Shimmer.fromColors(
          //   baseColor: AppColors.grey200,
          //   highlightColor: Colors.white,
          //   child: Container(
          //     width: imageWidth?.w,
          //     height: imageHeight?.h,
          //     decoration: BoxDecoration(
          //       shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
          //       borderRadius: isCircle ? null : borderRadius,
          //       color: AppColors.grey200,
          //     ),
          //   ),
          // );
        },
        errorBuilder: (context, error, stackTrace) {
          return Icon(
            Icons.image,
            color: AppColors.white,
            size: imageHeight == null ? null : imageHeight! / 2,
          );
        },
        // frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        //   return SizedBox(height: imageHeight?.h, width: imageWidth?.w);
        //   // return Container(
        //   //   width: imageWidth?.w,
        //   //   height: imageHeight?.h,
        //   //   decoration: BoxDecoration(
        //   //     shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        //   //     borderRadius: isCircle ? null : borderRadius,
        //   //     // image: DecorationImage(image: imageProvider, fit: fit),
        //   //   ),
        //   //   child: child,
        //   // );
        // },
      ),
    );
  }
}
