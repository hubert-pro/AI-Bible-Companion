import 'package:flutter/material.dart';

class BookmarkService extends ChangeNotifier {
  final List<Map<String, String>> _bookmarkedVerses = [];

  List<Map<String, String>> get bookmarkedVerses => _bookmarkedVerses;

  bool isBookmarked(Map<String, String> verse) {
    return _bookmarkedVerses.any((b) => b['reference'] == verse['reference']);
  }

  void addBookmark(Map<String, String> verse) {
    if (!isBookmarked(verse)) {
      _bookmarkedVerses.add(verse);
      notifyListeners();
    }
  }

  void removeBookmark(Map<String, String> verse) {
    _bookmarkedVerses.removeWhere((b) => b['reference'] == verse['reference']);
    notifyListeners();
  }

  void toggleBookmark(Map<String, String> verse) {
    if (isBookmarked(verse)) {
      removeBookmark(verse);
    } else {
      addBookmark(verse);
    }
  }
}
