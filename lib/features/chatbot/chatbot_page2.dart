import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gt_hackathon/features/chatbot/chatbot_view_logic.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    initMessages();
    super.initState();
  }

  void initMessages() {
    _messages.add(
      const ChatMessage(
        text:
            'Hello! How can I help you today? \n I’m Pal, your Chat Assistant.',
        isUser: false,
      ),
    );
    _messages.add(
      const ChatMessage(
        text: 'Here is a selection of topics I can help you with:',
        isUser: false,
      ),
    );
  }

  ChatbotViewLogic chatbotViewLogic = ChatbotViewLogic();

  final List<ChatMessage> _messages = [];
  final TextEditingController _inputController = TextEditingController();
  List<String> options = ['My train is delayed', 'My train is cancelled'];

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
      padding: const EdgeInsets.only(top: 8.0, left: 15.0, right: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Options',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          for (String option in options)
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

  void _handleOptionTap(String option) async {
    await Future.delayed(const Duration(seconds: 1), () {});

    setState(() {
      _messages.add(
        ChatMessage(
          text: 'You selected: $option',
          isUser: true,
        ),
      );

      List<String> assistantReply = chatbotViewLogic.assistantReply(option);

      // Simulate assistant's reply
      for (String ar in assistantReply) {
        _messages.add(
          ChatMessage(
            text: ar,
            isUser: false,
          ),
        );
      }

      _updateOptions(option);

      if (option == 'Back to overview') {
        _messages.clear();
        initMessages();
        setState(() {
          options = ['My train is delayed', 'My train is cancelled'];
        });
        _buildOptions();
      }
    });
  }

  void _handleUserInput(String userInput) async {
    await Future.delayed(const Duration(seconds: 1), () {});

    if (userInput.isNotEmpty) {
      setState(() {
        _messages.add(
          ChatMessage(
            text: userInput,
            isUser: true,
          ),
        );

        List<String> assistantReply =
            chatbotViewLogic.assistantReply(userInput);

        // Simulate assistant's reply
        for (String ar in assistantReply) {
          _messages.add(
            ChatMessage(
              text: ar,
              isUser: false,
            ),
          );
        }

        // Clear input field
        _inputController.clear();

        _updateOptions(userInput);
      });
    }
  }

  void _updateOptions(String option) async {
    setState(() {
      if (option.contains('9876')) {
        options = chatbotViewLogic.updateOptions('voucher-text');
      } else if (option.toLowerCase() == 'accept voucher' ||
          option.toLowerCase() == 'refund') {
        options = chatbotViewLogic.updateOptions('exit-option');
      } else {
        options = chatbotViewLogic.updateOptions(option);
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
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 22.0),
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
