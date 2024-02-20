import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  ChatUser user = ChatUser(
    id: '1',
    firstName: 'User1',
    lastName: 'Lastname',
  );

  ChatUser user2 = ChatUser(
    id: '2',
    firstName: 'User2',
    lastName: 'Lastname',
  );

  late List<ChatMessage> messages = <ChatMessage>[
    ChatMessage(
      text: 'Test user 1',
      mentions: <Mention>[Mention(title: 'User2')],
      user: user,
      createdAt: DateTime.now(),
    ),
    ChatMessage(
      text: 'Test user 2',
      user: user2,
      createdAt: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('ChatBot Page'),
      ),
      body: DashChat(
        currentUser: user,
        onSend: (ChatMessage m) {
          setState(() {
            messages.insert(0, m);
          });
        },
        messages: messages,
        quickReplyOptions: QuickReplyOptions(onTapQuickReply: (QuickReply r) {
          final ChatMessage m = ChatMessage(
            user: user,
            text: r.value ?? r.title,
            createdAt: DateTime.now(),
          );
          setState(() {
            messages.insert(0, m);
          });
        }),
        messageOptions: const MessageOptions(
          showCurrentUserAvatar: true,
          showOtherUsersName: true,
        ),
        inputOptions: InputOptions(
          sendOnEnter: true,
          inputDecoration: InputDecoration(
            isDense: true,
            filled: true,
            icon: const Icon(Icons.send),
            hintText: 'Type a message...',
            contentPadding: const EdgeInsets.only(
              left: 18,
              top: 10,
              bottom: 10,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: const BorderSide(
                width: 1,
                style: BorderStyle.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
