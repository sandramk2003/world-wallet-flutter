import 'package:dio/dio.dart';

  final Dio _dio = Dio();

  // Define the method to track the order
  Future<Map<String, dynamic>> trackOrder(String orderId) async {
    try {
      // Replace the URL with your actual API endpoint
      String url = 'https://your-api-url.com/track-order/$orderId';

      // Make the GET request
      Response response = await _dio.get(url);

      // If successful, return the response data
      if (response.statusCode == 200) {
        return response.data; // Assuming the response is JSON
      } else {
        throw Exception('Failed to track order');
      }
    } on DioError catch (e) {
      // Handle DioError
      if (e.response != null) {
        // Server responded with an error
        print('Error: ${e.response?.data}');
      } else {
        // No response from server
        print('Error: ${e.message}');
      }
      rethrow; // Propagate the error to be handled by the calling method
    }
  }

