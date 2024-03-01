import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
      body: Container(
        // image in the background of the chat and add opacity to the chat
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/chat_background.jpeg'),
            opacity: 0.5,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            _buildMessagesList(),
            _buildOptions(),
            _buildInputField(),
          ],
        ),
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
      margin: const EdgeInsets.all(12.0),
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.8),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5.0,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _inputController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Type a message...',
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          ElevatedButton(
            onPressed: () {
              _handleUserInput(_inputController.text);
            },
            child: const Icon(Icons.send),
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
                color: isUser
                    ? const Color.fromRGBO(0, 77, 115, 1)
                    : const Color.fromRGBO(255, 255, 255, 0.8),
                borderRadius: BorderRadius.circular(76.5),
              ),
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 16.0,
                    color: isUser
                        ? const Color.fromRGBO(255, 255, 255, 1)
                        : const Color.fromRGBO(0, 77, 115, 1)),
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
      backgroundColor: Color.fromRGBO(0, 77, 115, 1),
      radius: 25.0,
      child: Icon(
        Icons.person,
        color: Colors.grey,
      ),
    );
  }

  Widget _buildAssistantAvatar() {
    return CircleAvatar(
      radius: 25.0,
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      child: SvgPicture.asset(
        'assets/svg/icon_assistance.svg',
        width: 40.0,
      ),
    );
  }

  Widget _buildEmptySpace() {
    return const SizedBox(width: 40.0); // Adjust width as needed
  }
}
