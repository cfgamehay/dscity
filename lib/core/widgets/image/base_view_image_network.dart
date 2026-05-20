import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/theme.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class BaseViewImageNetwork extends ConsumerStatefulWidget {
  const BaseViewImageNetwork({
    super.key,
    required this.imageUrls,
    this.currentIndex = 0,
  });

  final List<String> imageUrls;
  final int currentIndex;

  @override
  ConsumerState<BaseViewImageNetwork> createState() =>
      _BaseViewImageNetworkState();
}

class _BaseViewImageNetworkState extends ConsumerState<BaseViewImageNetwork> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: widget.imageUrls.length <= 1
            ? null
            : Text(
                '${_currentIndex + 1}/${widget.imageUrls.length}',
                style: AppTextStyles.customTextStyle(
                  fontSize: 16,
                  fontWeightName: FontWeightName.medium,
                  color: AppColors.white,
                ),
              ),
        centerTitle: true,
      ),
      body: Hero(
        tag: widget.imageUrls[_currentIndex] + widget.currentIndex.toString(),
        transitionOnUserGestures: true,
        child: PhotoViewGallery.builder(
          itemCount: widget.imageUrls.length,
          builder: (context, index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: CachedNetworkImageProvider(
                widget.imageUrls[index],
              ),
              minScale: PhotoViewComputedScale.contained * 0.8,
              maxScale: PhotoViewComputedScale.covered * 2,
              errorBuilder: (context, error, stackTrace) {
                return const Center(child: Icon(Icons.error));
              },
            );
          },
          pageController: PageController(initialPage: _currentIndex),
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          scrollPhysics: const BouncingScrollPhysics(),
        ),
      ),
    );
  }
}
