import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

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
  ];

  List<Map<String, String>> _displayedResults = [];

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
    super.dispose();
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
                        return Card(
                          child: ListTile(
                            title: Text(verse['reference']!),
                            subtitle: Text(verse['text']!),
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
