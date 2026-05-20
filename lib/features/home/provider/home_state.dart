import 'package:dscity_mobile_app/features/home/model/home_banner_model.dart';

class HomeState {
  final bool isRefreshing;
  final bool isLoading;
  final int currentBannerIndex;
  final double walletBalance;
  final String userFullName;
  final String? error;
  final List<HomeBannerModel> banners;


  const HomeState({
    this.isRefreshing = false,
    this.isLoading = false,
    this.currentBannerIndex = 0,
    this.walletBalance = 0,
    this.userFullName = 'Bạn',
    this.error,
    this.banners = const [],
  });

  HomeState copyWith({
    bool? isRefreshing,
    bool? isLoading,
    int? currentBannerIndex,
    double? walletBalance,
    String? userFullName,
    List<HomeBannerModel>? banners,
    String? error,
  }) {
    return HomeState(
      isRefreshing: isRefreshing ?? this.isRefreshing,
      currentBannerIndex: currentBannerIndex ?? this.currentBannerIndex,
      walletBalance: walletBalance ?? this.walletBalance,
      userFullName: userFullName ?? this.userFullName,
      banners: banners ?? this.banners,
      error: error,
    );
  }
}
