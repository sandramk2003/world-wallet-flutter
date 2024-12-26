import 'package:dio/dio.dart';

// Dio instance
final Dio _dio = Dio();

// API base URL for the chatbot
final String _baseUrl = "https://api.example.com"; // Replace with your actual API URL

// Function to send a message to the chatbot API and receive the response
Future<String> sendMessageToChatBot(String userMessage) async {
  try {
    // Prepare the request data
    final data = {
      'message': userMessage,  // Sending the user message to the bot
    };

    // Sending the POST request to the API
    final response = await _dio.post('$_baseUrl/chatbot', data: data);

    if (response.statusCode == 200) {
      // If successful, return the bot's response
      return response.data['response'] ?? 'No response from bot';
    } else {
      return 'Failed to get response from bot';
    }
  } catch (e) {
    print('Error sending message to bot: $e');
    return 'Error communicating with chatbot';
  }
}
