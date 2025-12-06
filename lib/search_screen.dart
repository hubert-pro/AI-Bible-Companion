import 'package:flutter/material.dart';
import 'package:ai_bible_companion/direct_search_screen.dart';
import 'package:ai_bible_companion/browse_view.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabBar(
        controller: _tabController,
        tabs: const [
          Tab(text: 'Direct Search'),
          Tab(text: 'Browse'),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          DirectSearchScreen(),
          BrowseView(),
        ],
      ),
    );
  }
}
