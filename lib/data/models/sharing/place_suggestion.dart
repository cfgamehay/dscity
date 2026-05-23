class PlaceSuggestion {
  final String id;
  final String title;
  final String subtitle;
  final List<String> keywords;
  final bool isCurrentLocation;
  final bool isPopular;
  final bool isRecent;

  const PlaceSuggestion({
    required this.id,
    required this.title,
    required this.subtitle,
    this.keywords = const [],
    this.isCurrentLocation = false,
    this.isPopular = false,
    this.isRecent = false,
  });

  bool matchesKeyword(String keyword) {
    final normalized = keyword.trim().toLowerCase();
    if (normalized.isEmpty) return true;

    return title.toLowerCase().contains(normalized) ||
        subtitle.toLowerCase().contains(normalized) ||
        keywords.any((item) => item.toLowerCase().contains(normalized));
  }
}
