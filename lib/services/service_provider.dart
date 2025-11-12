import 'package:flutter/material.dart';
import 'package:ai_bible_companion/services/bookmark_service.dart';
import 'package:ai_bible_companion/services/connectivity_service.dart';

class ServiceProvider extends InheritedWidget {
  final BookmarkService bookmarkService;
  final ConnectivityService connectivityService;

  const ServiceProvider({
    Key? key,
    required this.bookmarkService,
    required this.connectivityService,
    required Widget child,
  }) : super(key: key, child: child);

  static ServiceProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ServiceProvider>();
  }

  @override
  bool updateShouldNotify(ServiceProvider oldWidget) {
    return bookmarkService != oldWidget.bookmarkService ||
        connectivityService != oldWidget.connectivityService;
  }
}
