import 'package:dio/dio.dart';

  final Dio dio = Dio();

  // FCM Server Key
  final String serverKey = 'YOUR_FCM_SERVER_KEY';

  Future<void> sendNotification(String token, String title, String body) async {
    try {
      final response = await dio.post(
        'https://fcm.googleapis.com/fcm/send',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'key=$serverKey',
          },
        ),
        data: {
          "to": token,  // Target device token
          "notification": {
            "title": title,
            "body": body,
          },
          "priority": "high", // Can be 'high' or 'normal'
        },
      );

      if (response.statusCode == 200) {
        print('Notification sent successfully');
      } else {
        print('Error sending notification: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

