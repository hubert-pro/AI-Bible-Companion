import 'package:flutter/material.dart';
import 'package:ai_bible_companion/verse_display_page.dart';

class ChapterSelectionPage extends StatelessWidget {
  final String book;

  const ChapterSelectionPage({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mock data for the number of chapters in each book
    final int chapterCount = book == 'Genesis' ? 50 : 20;

    return Scaffold(
      appBar: AppBar(
        title: Text(book),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemCount: chapterCount,
        itemBuilder: (context, index) {
          final chapter = index + 1;
          return ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VerseDisplayPage(
                    book: book,
                    chapter: chapter,
                  ),
                ),
              );
            },
            child: Text('$chapter'),
          );
        },
      ),
    );
  }
}
