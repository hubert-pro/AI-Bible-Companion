import 'package:flutter/material.dart';
import 'package:ai_bible_companion/services/bookmark_service.dart';
import 'package:ai_bible_companion/services/connectivity_service.dart';
import 'package:ai_bible_companion/services/theme_service.dart';
import 'package:ai_bible_companion/services/service_provider.dart';
import 'package:ai_bible_companion/search_screen.dart';
import 'package:ai_bible_companion/image_screen.dart';
import 'package:ai_bible_companion/chat_screen.dart';
import 'package:ai_bible_companion/bookmarks_screen.dart';
import 'package:ai_bible_companion/connectivity_status_page.dart';
import 'package:ai_bible_companion/settings_page.dart';

void main() {
  final bookmarkService = BookmarkService();
  final connectivityService = ConnectivityService();
  final themeService = ThemeService();
  runApp(
    ServiceProvider(
      bookmarkService: bookmarkService,
      connectivityService: connectivityService,
      themeService: themeService,
      child: AIBibleCompanion(themeService: themeService),
    ),
  );
}

class AIBibleCompanion extends StatefulWidget {
  final ThemeService themeService;
  const AIBibleCompanion({Key? key, required this.themeService}) : super(key: key);

  @override
  State<AIBibleCompanion> createState() => _AIBibleCompanionState();
}

class _AIBibleCompanionState extends State<AIBibleCompanion> {
  @override
  void initState() {
    super.initState();
    widget.themeService.addListener(_onThemeChanged);
  }

  @override
  void dispose() {
    widget.themeService.removeListener(_onThemeChanged);
    super.dispose();
  }

  void _onThemeChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Bible Companion',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: widget.themeService.themeMode,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Bible Companion'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.chat), text: 'Chat'),
            Tab(icon: Icon(Icons.search), text: 'Search'),
            Tab(icon: Icon(Icons.image), text: 'Image'),
            Tab(icon: Icon(Icons.bookmark), text: 'Bookmarks'),
            Tab(icon: Icon(Icons.wifi), text: 'Connectivity'),
            Tab(icon: Icon(Icons.settings), text: 'Settings'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          ChatScreen(),
          SearchScreen(),
          ImageScreen(),
          BookmarksScreen(),
          ConnectivityStatusPage(),
          SettingsPage(),
        ],
      ),
    );
  }
}
