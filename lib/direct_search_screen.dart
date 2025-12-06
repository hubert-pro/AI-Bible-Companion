import 'package:flutter/material.dart';
import 'package:ai_bible_companion/services/service_provider.dart';
import 'package:ai_bible_companion/services/bookmark_service.dart';

class DirectSearchScreen extends StatefulWidget {
  const DirectSearchScreen({Key? key}) : super(key: key);

  @override
  State<DirectSearchScreen> createState() => _DirectSearchScreenState();
}

class _DirectSearchScreenState extends State<DirectSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  late BookmarkService _bookmarkService;

  final List<Map<String, String>> _allVerses = [
    {
      'reference': 'John 3:16',
      'text':
          'For God so loved the world, that he gave his only Son, that whoever believes in him should not perish but have eternal life.'
    },
    {
      'reference': 'Proverbs 3:5-6',
      'text':
          'Trust in the Lord with all your heart, and do not lean on your own understanding. In all your ways acknowledge him, and he will make straight your paths.'
    },
    {
      'reference': 'Romans 8:28',
      'text':
          'And we know that for those who love God all things work together for good, for those who are called according to his purpose.'
    },
     {
      'reference': 'Philippians 4:13',
      'text': 'I can do all things through him who strengthens me.'
    },
    {
      'reference': 'Isaiah 41:10',
      'text':
          'Fear not, for I am with you; be not dismayed, for I am your God; I will strengthen you, I will help you, I will uphold you with my righteous right hand.'
    },
    {
      'reference': 'Joshua 1:9',
      'text':
          'Have I not commanded you? Be strong and courageous. Do not be frightened, and do not be dismayed, for the Lord your God is with you wherever you go.'
    },
  ];

  List<Map<String, String>> _displayedResults = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bookmarkService = ServiceProvider.of(context)!.bookmarkService;
    _bookmarkService.addListener(_updateBookmarkedVerses);
    _updateBookmarkedVerses();
  }


  @override
  void initState() {
    super.initState();
    _displayedResults = List.from(_allVerses);
    _searchController.addListener(_performSearch);
  }

  @override
  void dispose() {
    _searchController.removeListener(_performSearch);
    _searchController.dispose();
    _bookmarkService.removeListener(_updateBookmarkedVerses);
    super.dispose();
  }

  void _updateBookmarkedVerses() {
    setState(() {});
  }

  void _performSearch() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _displayedResults = List.from(_allVerses);
      } else {
        _displayedResults = _allVerses.where((verse) {
          final reference = verse['reference']!.toLowerCase();
          final text = verse['text']!.toLowerCase();
          return reference.contains(query) || text.contains(query);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search for a verse or topic',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _performSearch,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: _displayedResults.isEmpty
                  ? const Center(
                      child: Text(
                        'No results found.',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _displayedResults.length,
                      itemBuilder: (context, index) {
                        final verse = _displayedResults[index];
                        final isBookmarked = _bookmarkService.isBookmarked(verse);
                        return Card(
                          child: ListTile(
                            title: Text(verse['reference']!),
                            subtitle: Text(verse['text']!),
                            trailing: IconButton(
                              icon: Icon(
                                isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                                color: isBookmarked ? Theme.of(context).primaryColor : null,
                              ),
                              onPressed: () {
                                _bookmarkService.toggleBookmark(verse);
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
