extension StringX on String {
  String get greeting {
    final hour = DateTime.now().hour;
    final time = switch (hour) {
      < 12 => 'Good morning',
      < 17 => 'Good afternoon',
      _ => 'Good evening',
    };

    return isEmpty ? time : '$time, $this';
  }

  String get initials {
    final trimmed = trim();
    if (trimmed.isEmpty) return "";

    final words = RegExp(r'\p{L}+', unicode: true).allMatches(trimmed).map((m) => m.group(0)!).toList();

    if (words.isEmpty) return "";

    if (words.length == 1) return words.first.substring(0, 2).toUpperCase();

    return "${words.first[0]}${words.last[0]}".toUpperCase();
  }
}
