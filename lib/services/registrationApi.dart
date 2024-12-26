import 'dart:convert';
import 'package:dio/dio.dart';

Future<void> registerFun(String email,data) async {
  final Dio dio = Dio();  // Dio instance

  final String url = 'http://<your-django-server-ip>/api/register/'; // Django API URL for registration

  try {
    // Send the registration request with user details as JSON
    final response = await dio.post(
      url,
      data: data,
      options: Options(
        headers: {
          'Content-Type': 'application/json', // Ensure the server expects JSON
        },
      )
    );

    // Handle the response
    if (response.statusCode == 201) {
      // If registration is successful (status code 201), print the success message
      print('Registration successful');
      
      // You can navigate to the login screen or other actions
      // Example: 
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
    } else {
      // If registration failed, display the error message
      print('Error: ${response.data['error']}');
    }
  } catch (e) {
    // Handle any error that occurs during the request
    print('Error occurred: $e');
  }
}
