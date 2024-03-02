class ChatbotViewLogic {
  final String userInput = '';

  // assistant's reply to user input with mapped options
  List<String> assistantReply(String userInput) {
    userInput = userInput.toLowerCase();

    List<String> assistantReplyList = [];

    if (assistantReplyMap.containsKey(userInput)) {
      assistantReplyList.add(assistantReplyMap[userInput]!);
    } else if (userInput.contains('9876')) {
      assistantReplyList.add(assistantReplyMap['ticket number']!);
      assistantReplyList.add(assistantReplyMap['voucher-text']!);
      assistantReplyList.add(assistantReplyMap['voucher-no-return']!);
    } else if (!assistantReplyMap.containsKey(userInput)) {
      assistantReplyList.add(assistantReplyMap['nothing-found']!);
    }

    return assistantReplyList;
  }

  // find relevant options for user input
  List<String> updateOptions(String userInput) {
    userInput = userInput.toLowerCase();
    if (userOptionsMap.containsKey(userInput)) {
      return userOptionsMap[userInput]!;
    } else {
      return [];
    }
  }

  // mapping user input to assistant's reply
  Map<String, String> assistantReplyMap = {
    'hi': 'Hello!',
    'hello': 'Hello!',
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
    'voucher-text': [
      'Accept voucher',
      'Alternative transportation to destination',
      'Refund',
    ],
    'exit-option': ['Feedback', 'Back to overview'],
    'feedback': ['Back to overview'],
    'alternative transportation to destination': ['Back to overview'],
  };
}
