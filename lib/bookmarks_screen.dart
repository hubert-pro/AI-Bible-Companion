import 'package:flutter/material.dart';
import 'package:ai_bible_companion/services/service_provider.dart';
import 'package:ai_bible_companion/services/bookmark_service.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({Key? key}) : super(key: key);

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  late BookmarkService _bookmarkService;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bookmarkService = ServiceProvider.of(context)!.bookmarkService;
    _bookmarkService.addListener(_onBookmarksChanged);
  }

  @override
  void dispose() {
    _bookmarkService.removeListener(_onBookmarksChanged);
    super.dispose();
  }

  void _onBookmarksChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final bookmarkedVerses = _bookmarkService.bookmarkedVerses;

    return Scaffold(
      body: bookmarkedVerses.isEmpty
          ? const Center(
              child: Text(
                'You have no bookmarked verses.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: bookmarkedVerses.length,
              itemBuilder: (context, index) {
                final verse = bookmarkedVerses[index];
                return Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          verse['reference']!,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          verse['text']!,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 8.0),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              _bookmarkService.removeBookmark(verse);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
