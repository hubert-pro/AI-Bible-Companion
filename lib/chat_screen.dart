import 'package:flutter/material.dart';
import 'dart:async';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _chatController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, String>> _chatHistory = [
    {'sender': 'AI', 'message': 'Hello! How can I help you today?'},
  ];

  void _sendMessage() {
    final messageText = _chatController.text;
    if (messageText.isEmpty) return;

    setState(() {
      _chatHistory.add({'sender': 'user', 'message': messageText});
    });

    _chatController.clear();
    _scrollToBottom();

    // Simulate AI response
    Timer(const Duration(seconds: 1), () {
      setState(() {
        _chatHistory.add({
          'sender': 'AI',
          'message': 'Thank you for your message. This is a simulated response.'
        });
      });
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildVerseOfTheDay(),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16.0),
              itemCount: _chatHistory.length,
              itemBuilder: (context, index) {
                final message = _chatHistory[index];
                final isUserMessage = message['sender'] == 'user';
                return Align(
                  alignment: isUserMessage
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: isUserMessage
                          ? Theme.of(context).primaryColor
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Text(
                      message['message']!,
                      style: TextStyle(
                        color: isUserMessage ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          _buildChatInput(),
        ],
      ),
    );
  }

  Widget _buildVerseOfTheDay() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.blue[50],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Verse of the Day',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8.0),
          Text(
            'John 3:16',
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8.0),
          Text(
            '"For God so loved the world, that he gave his only Son, that whoever believes in him should not perish but have eternal life."',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildChatInput() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _chatController,
              decoration: InputDecoration(
                hintText: 'Type your message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          const SizedBox(width: 16.0),
          IconButton(
            onPressed: _sendMessage,
            icon: const Icon(Icons.send),
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
