class HomeNavigationState {
  final int selectedIndex;

  const HomeNavigationState({this.selectedIndex = 0});

  HomeNavigationState copyWith({
    int? selectedIndex
}) {
    return HomeNavigationState(
      selectedIndex: selectedIndex ?? this.selectedIndex
    );
  }
}