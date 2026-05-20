import 'package:dscity_mobile_app/features/home_navigation/provider/home_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeNavigationProvider = NotifierProvider<HomeNavigationNotifier, HomeNavigationState>(
  HomeNavigationNotifier.new
);

class HomeNavigationNotifier extends Notifier<HomeNavigationState>{
  @override
  HomeNavigationState build() {
    return const HomeNavigationState();
  }

  void switchTab(int index) {
    if(index == state.selectedIndex) return;
    state = state.copyWith(selectedIndex: index);
  }
}