import 'package:flutter/material.dart';

// A basic ChatMessage model to hold chat information
class ChatMessage {
  final String text;
  final bool isUserMessage;

  ChatMessage({required this.text, required this.isUserMessage});
}

class ChatBotScreen extends StatefulWidget {
  @override
  _ChatBotScreenState createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [];

  // Simulate a bot response based on the user input
  String _getBotReply(String userMessage) {
    // Simple predefined responses
    if (userMessage.contains('hello') || userMessage.contains('hi')) {
      return "Hello! How can I help you today?";
    } else if (userMessage.contains('bye')) {
      return "Goodbye! Have a nice day!";
    } else if (userMessage.contains('how are you')) {
      return "I'm just a bot, but I'm doing great! How about you?";
    } else {
      return "Sorry, I didn't understand that. Can you ask something else?";
    }
  }

  void _sendMessage() {
    String userMessage = _controller.text.trim();
    if (userMessage.isEmpty) return;

    setState(() {
      // Add user message to the chat list
      _messages.add(ChatMessage(text: userMessage, isUserMessage: true));

      // Get bot's reply
      String botReply = _getBotReply(userMessage);
      _messages.add(ChatMessage(text: botReply, isUserMessage: false));
    });

    // Clear the input field
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chatbot"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              // reverse: true, // To show the latest message at the bottom
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  title: Align(
                    alignment: message.isUserMessage
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: message.isUserMessage ? Colors.blue : Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        message.text,
                        style: TextStyle(
                          color: message.isUserMessage ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.blueAccent),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
