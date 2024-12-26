import 'dart:convert';
import 'package:dio/dio.dart';

Future<void> loginFunction(String email, String password) async {
  final Dio dio = Dio();  // Dio instance

  final String url = 'http://<your-django-server-ip>/api/login/'; // Django API URL

  try {
    // Send the login request with email and password as JSON
    final response = await dio.post(
      url,
      data: {
        'email': email,
        'password': password,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json', // Ensure proper content type
        },
      ),
    );

    // Handle the response
    if (response.statusCode == 200) {
      // If login is successful, extract the JWT token
      final Map<String, dynamic> data = response.data;
      String accessToken = data['access_token'];

      // You can store the token securely here (e.g., using flutter_secure_storage)
      print('Access Token: $accessToken');
      
      // Optionally, you can store the access token or navigate to the next screen
      // Example: 
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
    } else {
      // If login failed, display the error message
      print('Error: ${response.data['error']}');
    }
  } catch (e) {
    // Handle any error that occurs during the request
    print('Error occurred: $e');
  }
}
