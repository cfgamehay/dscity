import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:dscity_mobile_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../model/home_banner_model.dart';

class HomeBannerSlider extends StatelessWidget {
  final List<HomeBannerModel> banners;
  final int currentIndex;
  final ValueChanged<int> onPageChanged;

  const HomeBannerSlider({
    super.key,
    required this.banners,
    required this.currentIndex,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: banners.length,
          itemBuilder: (context, index, realIndex) {
            final item = banners[index];

            return Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      imageUrl: item.imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      fadeInDuration: Duration.zero,
                      fadeOutDuration: Duration.zero,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.broken_image),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(180, 0, 0, 0),
                            Color.fromARGB(0, 0, 0, 0),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 16,
                      right: 16,
                      bottom: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.body ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: 220,
            viewportFraction: 1,
            autoPlay: true,
            autoPlayAnimationDuration: Duration(milliseconds: 600),
            enlargeCenterPage: false,
            onPageChanged: (index, reason) {
              onPageChanged(index);
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            banners.length,
                (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: currentIndex == index ? 10 : 8,
              height: currentIndex == index ? 10 : 8,
              decoration: BoxDecoration(
                color: currentIndex == index
                    ? AppColors.primary
                    : AppColors.outline.withValues(alpha: 0.3),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}