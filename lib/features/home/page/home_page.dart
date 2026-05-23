import 'package:cached_network_image/cached_network_image.dart';
import 'package:characters/characters.dart';
import 'package:dscity_mobile_app/core/assets/assets.dart';
import 'package:dscity_mobile_app/core/theme/app_text_styles.dart';
import 'package:dscity_mobile_app/core/widgets/base_card.dart';
import 'package:dscity_mobile_app/core/widgets/button/primary_button.dart';
import 'package:dscity_mobile_app/features/home/provider/home_provider.dart';
import 'package:dscity_mobile_app/features/home/widgets/home_banner_slider.dart';
import 'package:dscity_mobile_app/features/notification/page/notification_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/enum.dart';
import '../../../core/extensions/currency_format.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/button/icon_button.dart';
import '../../parking/page/parking_page.dart';
import '../../sharing/page/sharing_page.dart';
import '../../vehicle/page/vehicle_listing_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(homeProvider.notifier).firstLoad();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeProvider);
    bool didPrecacheBanners = false;

    if (!didPrecacheBanners && state.banners.isNotEmpty) {
      didPrecacheBanners = true;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        for (final banner in state.banners) {
          precacheImage(
            CachedNetworkImageProvider(banner.imageUrl),
            context,
          );
        }
      });
    }

    if (state.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(homeProvider.notifier).refreshHome(),
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 36,
                child: Image.asset(ImagesResource.pngLogiTextOnly),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const NotificationPage(showAppBar: true,),
                    ),
                  );
                },
                icon: const Icon(Icons.notifications_none_outlined),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _HomeAvatar(name: state.userFullName),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Xin chào, ${state.userFullName}',
                      style: AppTextStyles.titleMedium,
                    ),
                    Text(
                      'Cùng khám phá thành phố thông minh',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.grey500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          BaseCard(
            backgroundColor: AppColors.background,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ví của tôi',
                        style: AppTextStyles.titleMedium.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        state.walletBalance.toCurrency(isSymbol: true),
                        style: AppTextStyles.headlineMedium.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                PrimaryButton(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  onPressed: () {},
                  child: Text(
                    'Nạp tiền',
                    style: AppTextStyles.titleMedium.copyWith(
                      color: AppColors.onPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: AppIconButton(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const ParkingPage(),
                      ),
                    );
                  },
                  size: 64,
                  iconSize: 28,
                  isCircle: false,
                  elevated: true,
                  label: 'Bãi đậu xe',
                  labelMaxLines: 2,
                  iconWidget: Image.asset(ImagesResource.pngIcParking),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: AppIconButton(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const VehiclePage(
                          type: MapFilterType.car,
                        ),
                      ),
                    );
                  },
                  size: 64,
                  iconSize: 28,
                  isCircle: false,
                  elevated: true,
                  label: 'Thuê ô tô',
                  labelMaxLines: 2,
                  iconWidget: Image.asset(ImagesResource.pngIcCar),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: AppIconButton(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const VehiclePage(
                          type: MapFilterType.motorbike,
                        ),
                      ),
                    );
                  },
                  size: 64,
                  iconSize: 28,
                  isCircle: false,
                  elevated: true,
                  label: 'Thuê xe máy',
                  labelMaxLines: 2,
                  iconWidget: Image.asset(ImagesResource.pngIcMotorbike),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: AppIconButton(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const SharingPage(),
                      ),
                    );
                  },
                  size: 64,
                  iconSize: 28,
                  isCircle: false,
                  elevated: true,
                  label: 'Chia sẻ phương tiện',
                  labelMaxLines: 2,
                  iconWidget: Image.asset(ImagesResource.pngIcShare),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Gợi ý cho bạn',
                style: AppTextStyles.titleSmall,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Xem tất cả',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.grey500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          HomeBannerSlider(
            banners: state.banners,
            currentIndex: state.currentBannerIndex,
            onPageChanged: (int index) {
              ref.read(homeProvider.notifier).changeBanner(index);
            },
          ),
        ],
      ),
    );
  }
}

class _HomeAvatar extends StatelessWidget {
  final String name;

  const _HomeAvatar({required this.name});

  @override
  Widget build(BuildContext context) {
    final displayName = name.trim().isEmpty ? 'Người dùng' : name.trim();

    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0B8F62), Color(0xFF124B9A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.12),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        _initials(displayName),
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w800,
          color: AppColors.onPrimary,
        ),
      ),
    );
  }

  String _initials(String value) {
    final parts = value
        .split(RegExp(r'\s+'))
        .where((item) => item.isNotEmpty)
        .toList();

    if (parts.isEmpty) return 'U';
    if (parts.length == 1) return parts.first.characters.first.toUpperCase();
    return '${parts.first.characters.first}${parts.last.characters.first}'
        .toUpperCase();
  }
}
