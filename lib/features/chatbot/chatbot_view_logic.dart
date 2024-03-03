import 'package:flutter_gemini/flutter_gemini.dart';

class ChatbotViewLogic {
  String userInput = '';
  final gemini = Gemini.instance;
  List<String> previousUserInput = [];

  // assistant's reply to user input with mapped options
  Future<List<String>> assistantReply(String userInput) async {
    userInput = userInput.toLowerCase();
    previousUserInput.add(userInput);

    List<String> assistantReplyList = [];

    String? value = getValueBySubstring(assistantReplyMap, userInput);

    if (assistantReplyMap.containsKey(userInput)) {
      assistantReplyList.add(assistantReplyMap[userInput]!);
    } else if (userInput.contains('9876')) {
      assistantReplyList.add(assistantReplyMap['ticket number']!);
      assistantReplyList.add(assistantReplyMap['voucher-text']!);
      assistantReplyList.add(assistantReplyMap['voucher-no-return']!);
    } else if (!assistantReplyMap.containsKey(userInput)) {
      if (value != null) {
        assistantReplyList.add(value);
      } else {
        // input string to array
        List<String> inputArray = userInput.split(' ');
        String newValue = '';
        for (String input in inputArray) {
          value = getValueBySubstring(assistantReplyMap, input);
          if (value != null) {
            newValue = value;
            previousUserInput.add(input);
          }
        }
        if (newValue.isNotEmpty) {
          assistantReplyList.add(newValue);
        } else {
          assistantReplyList.add(
              '${await geminiAssistantReply(userInput)} \nResponse from Bot.');
        }
      }
    } else if (!assistantReplyMap.containsKey(userInput) &&
        userInput != 'back to overview') {
      // assistantReplyList.add(assistantReplyMap['nothing-found']!);
      assistantReplyList.add(await geminiAssistantReply(userInput));
    }
    return assistantReplyList;
  }

  // find relevant options for user input
  List<String> updateOptions(String userInput) {
    userInput = userInput.toLowerCase();
    print(previousUserInput);

    if (containsSubstring(previousUserInput, '9876') &&
        (containsSubstring(previousUserInput, 'delay') ||
            previousUserInput.contains('my train is delayed'))) {
      previousUserInput.clear();
      return userOptionsMap['delay-voucher-text']!;
    } else if (containsSubstring(previousUserInput, '9876') &&
        (containsSubstring(previousUserInput, 'cancel') ||
            previousUserInput.contains('my train is cancelled'))) {
      previousUserInput.clear();
      return userOptionsMap['cancel-voucher-text']!;
    } else if (userOptionsMap.containsKey(userInput)) {
      return userOptionsMap[userInput]!;
    } else {
      return [];
    }
  }

  String? getValueBySubstring(Map<String, String> map, String sub) {
    for (var key in map.keys) {
      if (key.contains(sub)) {
        return map[key];
      }
    }
    return null;
  }

  bool containsSubstring(List<String> arr, String sub) {
    return arr.any((element) => element.contains(sub));
  }

  // Gemini chat bot assistant's reply
  Future<String> geminiAssistantReply(String userInput) async {
    String? result;

    await gemini
        .text(userInput,
            generationConfig: GenerationConfig(
              temperature: 0.5,
              topP: 1.0,
              topK: 40,
            ))
        .then((value) {
      result = value?.content?.parts?.last.text;
    }).catchError((e) {
      print(e);
    });
    return result ?? assistantReplyMap['nothing-found'] ?? '';
  }

  // mapping user input to assistant's reply
  Map<String, String> assistantReplyMap = {
    'hi': 'Hello! How can I assist you today?',
    'hello': 'Hello there! How can I assist you today?',
    'how are you?': 'I am fine, thank you!',
    'what is your name?': 'I am Pal! The chat bot',
    'what is your purpose?': 'I am here to assist you with your queries!',
    'what can you do?': 'I can help you with your queries!',
    'what is your age?': 'I am a chat bot, I do not have an age!',
    'my train is delayed':
        'I’m sorry to hear this. To help you further, please provide your ticket or reservation code.',
    'ticket number':
        'The ticket or reservation details have been found based on the provided code.',
    "voucher-text":
        "I can offer you a voucher that's valid for 6 months, and you can use it to get a train ticket with a 6-month validity.",
    "voucher-no-return":
        'Please be aware that once you accept  the voucher, the option to request a refund will no longer be available.',
    'accept voucher':
        'Great! The voucher has been stored in your Tickets (vouchers) section.',
    'my train is cancelled':
        "I’m sorry to hear this. To help you further, please provide your ticket or reservation code.",
    'alternative transportation to destination': 'Coming soon...',
    "feedback":
        "Thank you for chatting with our chatbot, Pal! We hope we were able to assist you effectively. Your feedback is important to us. If you have a moment, please share your rating on your experience. We appreciate your input as we strive to improve and provide better service. Have a great day! \nPal & Team",
    'nothing-found': 'I am sorry, I could not find any relevant information.',
    'refund':
        'The refund request has been processed. You will receive a notification once it is completed. How satisfied are you with the service?',
  };

  // mapping user input to relevant options
  Map<String, List<String>> userOptionsMap = {
    'delay-voucher-text': [
      'Accept voucher',
      'Refund',
    ],
    'cancel-voucher-text': [
      'Accept voucher',
      'Alternative transportation to destination',
      'Refund',
    ],
    'exit-option': ['Feedback', 'Back to overview'],
    'feedback': ['Back to overview'],
    'alternative transportation to destination': ['Back to overview'],
  };
}
