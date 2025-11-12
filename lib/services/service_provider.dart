import 'package:flutter/material.dart';
import 'package:ai_bible_companion/services/bookmark_service.dart';

class ServiceProvider extends InheritedWidget {
  final BookmarkService bookmarkService;

  const ServiceProvider({
    Key? key,
    required this.bookmarkService,
    required Widget child,
  }) : super(key: key, child: child);

  static ServiceProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ServiceProvider>();
  }

  @override
  bool updateShouldNotify(ServiceProvider oldWidget) {
    return bookmarkService != oldWidget.bookmarkService;
  }
}
