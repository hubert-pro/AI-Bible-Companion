import 'package:flutter/material.dart';
import 'package:ai_bible_companion/search_screen.dart';
import 'package.ai_bible_companion/image_screen.dart';
import 'package:ai_bible_companion/chat_screen.dart';
import 'package:ai_bible_companion/bookmarks_screen.dart';

void main() {
  runApp(const AIBibleCompanion());
}

class AIBibleCompanion extends StatelessWidget {
  const AIBibleCompanion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Bible Companion',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
    _tabController = TabController(length: 4, vsync: this);
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
        ],
      ),
    );
  }
}
