import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../theme/theme.dart';
import 'package:shimmer/shimmer.dart';

class BaseCachedNetworkImage extends StatelessWidget {
  const BaseCachedNetworkImage({
    super.key,
    required this.imageUrl,
    this.imageWidth,
    this.imageHeight,
    this.isCircle = false,
    this.borderRadius,
    this.fit = BoxFit.cover,
  });

  final String imageUrl;
  final double? imageWidth;
  final double? imageHeight;
  final bool isCircle;
  final BorderRadiusGeometry? borderRadius;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty || !imageUrl.contains('http')) {
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
    return CachedNetworkImage(
      // key: ValueKey(imageUrl),
      imageUrl: imageUrl,
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: AppColors.grey200,
        highlightColor: Colors.white,
        child: Container(
          width: imageWidth,
          height: imageHeight,
          decoration: BoxDecoration(
            shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
            borderRadius: isCircle ? null : borderRadius,
            color: AppColors.grey200,
          ),
        ),
      ),
      // Center(
      //   child: SizedBox(
      //     height: 20.h,
      //     width: 20.w,
      //     child: CircularProgressIndicator(
      //       strokeWidth: 2.r,
      //     ),
      //   ),
      // ),
      errorWidget: (context, url, error) => Container(
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
      ),
      imageBuilder: (imageHeight == null || imageWidth == null)
          ? null
          : (context, imageProvider) => Container(
              width: imageWidth,
              height: imageHeight,
              decoration: BoxDecoration(
                shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
                borderRadius: isCircle ? null : borderRadius,
                image: DecorationImage(image: imageProvider, fit: fit),
              ),
            ),
    );
  }
}
