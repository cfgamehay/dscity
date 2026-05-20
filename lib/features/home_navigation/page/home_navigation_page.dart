import 'package:dscity_mobile_app/core/theme/app_colors.dart';
import 'package:dscity_mobile_app/features/home/page/home_page.dart';
import 'package:dscity_mobile_app/features/home_navigation/provider/home_provider.dart';
import 'package:dscity_mobile_app/features/map/page/map_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class HomeNavigationPage extends ConsumerStatefulWidget {
  const HomeNavigationPage({super.key});

  @override
  ConsumerState<HomeNavigationPage> createState() => _HomeNavigationPageState();

}

class _HomeNavigationPageState extends ConsumerState<HomeNavigationPage> {


  void _switchTab(int index) {
    ref.read(homeNavigationProvider.notifier).switchTab(index);
  }

  static const List<Widget> _tabs = <Widget>[
    HomePage(),
    MapPage(),
    Text('Đặt chỗ'),
    Text('Thông báo'),
    Text('Tài khoản'),
  ];

  final List<BottomNavigationBarItem> _bottomNavigationItems = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      label: 'Trang chủ',
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home),
    ),
    BottomNavigationBarItem(
      label: 'Bản đồ',
      icon: Icon(Icons.map_outlined),
      activeIcon:Icon(Icons.map),
    ),
    BottomNavigationBarItem(
      label: 'Đặt chỗ',
      icon:Icon(Icons.note_alt_outlined),
      activeIcon: Icon(Icons.note_alt),
    ),
    BottomNavigationBarItem(
      label: 'Thông báo',
      icon: Icon(Icons.notifications_none_outlined),
      activeIcon: Icon(Icons.notifications),
    ),
    BottomNavigationBarItem(
      label: 'Tài khoản',
      icon: Icon(Icons.person_outline),
      activeIcon: Icon(Icons.person),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final homeNavigationState = ref.watch(homeNavigationProvider);

    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: homeNavigationState.selectedIndex,
          children: _tabs,
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        selectedItemColor: AppColors.secondary,
        unselectedItemColor: AppColors.grey300,
        showUnselectedLabels: true,
        items: _bottomNavigationItems,
        currentIndex: homeNavigationState.selectedIndex,
        elevation: 0,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        onTap: _switchTab,
      ),
    );
  }
}
