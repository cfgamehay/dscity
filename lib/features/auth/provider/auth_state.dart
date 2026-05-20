class AuthState{
  final int selectedIndex;
  final bool isLoading;
  final String? error;

  const AuthState({
    this.selectedIndex = 0,
    this.isLoading = false,
    this.error,
  });

  AuthState copyWith({
    int? selectedIndex,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}