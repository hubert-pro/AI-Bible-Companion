import 'package:flutter/material.dart';

class VerseDisplayPage extends StatelessWidget {
  final String book;
  final int chapter;

  const VerseDisplayPage({Key? key, required this.book, required this.chapter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$book $chapter'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          Text(
            '1. In the beginning, God created the heavens and the earth.',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 16.0),
          Text(
            '2. The earth was without form and void, and darkness was over the face of the deep. And the Spirit of God was hovering over the face of the waters.',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
