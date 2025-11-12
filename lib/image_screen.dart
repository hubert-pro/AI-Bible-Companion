import 'package:flutter/material.dart';
import 'dart:async';

class ImageScreen extends StatefulWidget {
  const ImageScreen({Key? key}) : super(key: key);

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  final TextEditingController _sceneController = TextEditingController();
  bool _isLoading = false;
  Widget? _generatedImage;
  String? _scriptureReference;
  String? _explanation;

  void _generateImage() {
    if (_sceneController.text.isEmpty) return;

    setState(() {
      _isLoading = true;
      _generatedImage = null;
      _scriptureReference = null;
      _explanation = null;
    });

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _generatedImage = const Icon(
          Icons.check_circle,
          size: 100,
          color: Colors.green,
        );
        _scriptureReference = 'Exodus 14:21-22';
        _explanation =
            'Then Moses stretched out his hand over the sea, and the Lord drove the sea back by a strong east wind all night and made the sea dry land, and the waters were divided. And the people of Israel went into the midst of the sea on dry ground, the waters being a wall to them on their right hand and on their left.';
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _sceneController,
                decoration: InputDecoration(
                  labelText: 'Describe a biblical scene',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                minLines: 3,
                maxLines: 5,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _generateImage,
                icon: const Icon(Icons.brush),
                label: Text(_isLoading ? 'Generating...' : 'Generate Image'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
              Container(
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Center(
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : _generatedImage ??
                          const Icon(
                            Icons.image,
                            size: 100,
                            color: Colors.grey,
                          ),
                ),
              ),
              const SizedBox(height: 24.0),
              if (_scriptureReference != null && _explanation != null)
                Card(
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
                          _scriptureReference!,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          _explanation!,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                // TODO: Implement text-to-speech
                              },
                              icon: const Icon(Icons.volume_up),
                              tooltip: 'Listen',
                            ),
                            IconButton(
                              onPressed: () {
                                // TODO: Implement sharing
                              },
                              icon: const Icon(Icons.share),
                              tooltip: 'Share',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
