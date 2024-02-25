import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _inputController = TextEditingController();
  final List<String> _options = ['Option 1', 'Option 2'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildMessagesList(),
          _buildOptions(),
          _buildInputField(),
        ],
      ),
    );
  }

  Widget _buildMessagesList() {
    return Expanded(
      child: ListView.builder(
        reverse: true, // Display from bottom to top
        itemCount: _messages.length,
        itemBuilder: (context, index) {
          final reversedIndex = _messages.length - 1 - index;
          return _messages[reversedIndex];
        },
      ),
    );
  }

  Widget _buildOptions() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Options',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          for (String option in _options)
            ElevatedButton(
              onPressed: () {
                _handleOptionTap(option);
              },
              child: Text(option),
            ),
        ],
      ),
    );
  }

  Widget _buildInputField() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _inputController,
              decoration: const InputDecoration(
                hintText: 'Type a message...',
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          ElevatedButton(
            onPressed: () {
              _handleUserInput(_inputController.text);
            },
            child: const Text('Send'),
          ),
        ],
      ),
    );
  }

  void _handleOptionTap(String option) {
    setState(() {
      _messages.add(
        ChatMessage(
          text: 'You selected: $option',
          isUser: true,
        ),
      );

      // Simulate assistant's reply
      _messages.add(
        ChatMessage(
          text: 'Assistant\'s reply to: $option',
          isUser: false,
        ),
      );

      _updateOptions();
    });
  }

  void _handleUserInput(String userInput) {
    if (userInput.isNotEmpty) {
      setState(() {
        _messages.add(
          ChatMessage(
            text: userInput,
            isUser: true,
          ),
        );

        // Simulate assistant's reply
        _messages.add(
          ChatMessage(
            text: 'Assistant\'s reply to: $userInput',
            isUser: false,
          ),
        );

        // Clear input field
        _inputController.clear();

        _updateOptions();
      });
    }
  }

  void _updateOptions() {
    setState(() {
      final int currentMax =
          int.parse(_options.last.split(" ").last); // Extract the last number
      _options.clear();
      for (int i = currentMax + 1; i <= currentMax + 2; i++) {
        _options.add('Option $i');
      }
    });
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;

  const ChatMessage({
    super.key,
    required this.text,
    required this.isUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isUser ? _buildEmptySpace() : _buildAssistantAvatar(),
          const SizedBox(width: 8.0),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: isUser ? Colors.blueGrey[100] : Colors.grey[300],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                text,
                style: const TextStyle(fontSize: 16.0),
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          isUser ? _buildUserAvatar() : _buildEmptySpace(),
        ],
      ),
    );
  }

  Widget _buildUserAvatar() {
    return const CircleAvatar(
      backgroundColor: Colors.blue,
      child: Icon(Icons.person), // Change color as needed
    );
  }

  Widget _buildAssistantAvatar() {
    return const CircleAvatar(
      backgroundColor: Colors.green,
      child: Icon(Icons.account_circle), // Change color as needed
    );
  }

  Widget _buildEmptySpace() {
    return const SizedBox(width: 40.0); // Adjust width as needed
  }
}
