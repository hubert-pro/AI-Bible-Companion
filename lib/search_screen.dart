import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, String>> _searchResults = [
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
                  onPressed: () {
                    // TODO: Implement search functionality
                  },
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  final verse = _searchResults[index];
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
