
import 'package:dscity_mobile_app/features/home/provider/home_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/home/home_banner_model.dart';

final homeProvider = NotifierProvider<HomeNotifier, HomeState>(
  HomeNotifier.new
);

class HomeNotifier extends Notifier<HomeState>
{
  @override
  HomeState build() {
    return const HomeState();
  }

  void changeBanner(int index)
  {
    if(state.currentBannerIndex == index) return;
    state = state.copyWith(currentBannerIndex: index);
  }

  void updateProfileName(String value) {
    final nextName = value.trim();
    if (nextName.isEmpty || nextName == state.userFullName) return;
    state = state.copyWith(userFullName: nextName);
  }

  Future<void> firstLoad() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await Future.delayed(const Duration(seconds: 1));
      state = state.copyWith(
        isLoading: false,
        userFullName: 'Nguyễn Văn Minh',
        walletBalance: 520000,
        banners: [
        HomeBannerModel(
        imageUrl: 'https://images.unsplash.com/photo-1503376780353-7e6692767b70',
      title: 'Ưu đãi đậu xe',
      body: 'Giảm 20% tại các bãi đỗ tác trong tháng 5.',
      ),
    HomeBannerModel(
    imageUrl: 'https://images.unsplash.com/photo-1449965408869-eaa3f722e40d',
    title: 'Thuê ô tô thông minh',
    body: 'Đặt xe nhanh chóng, linh hoạt cho mọi hành trình.',
    ),
    HomeBannerModel(
    imageUrl: 'https://images.unsplash.com/photo-1558981806-ec527fa84c39',
    title: 'Thuê xe máy tiện lợi',
    body: 'Di chuyển dễ dàng trong thành phố với chi phí tiết kiệm.',
    ),
    ]
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> refreshHome() async {
    state = state.copyWith(isRefreshing: true, error: null);

    try {
      await Future.delayed(const Duration(seconds: 1));
      state = state.copyWith(
        isRefreshing: false,
        walletBalance: 520123,
        banners: [
          HomeBannerModel(
            imageUrl: 'https://images.unsplash.com/photo-1503376780353-7e6692767b70',
            title: 'Ưu đãi đậu xe',
            body: 'Giảm 20.5% tại các bãi đỗ tác trong tháng 5.',
          ),
          HomeBannerModel(
            imageUrl: 'https://images.unsplash.com/photo-1449965408869-eaa3f722e40d',
            title: 'Thuê ô tô thông minh',
            body: 'Đặt xe nhanh chóng, linh hoạt cho mọi hành trình.',
          ),
          HomeBannerModel(
            imageUrl: 'https://images.unsplash.com/photo-1558981806-ec527fa84c39',
            title: 'Thuê xe máy tiện lợi',
            body: 'Di chuyển dễ dàng trong thành phố với chi phí tiết kiệm.',
          ),
        ]
      );
    } catch (e) {
      state = state.copyWith(
        isRefreshing: false,
        error: e.toString(),
      );
    }
  }

}
