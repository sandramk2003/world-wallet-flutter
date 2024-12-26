import 'package:flutter/material.dart';



class NotificationPage extends StatelessWidget {
  // Sample notifications data
  final List<NotificationModel> notifications = [
    NotificationModel(
      title: 'New Message',
      description: 'You have a new message from John.',
      time: '2 minutes ago',
    ),
    NotificationModel(
      title: 'System Update',
      description: 'Your app has been updated successfully.',
      time: '30 minutes ago',
    ),
    NotificationModel(
      title: 'Reminder',
      description: 'Don\'t forget to attend the meeting at 3 PM.',
      time: '1 hour ago',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Card(
            margin: EdgeInsets.all(10),
            elevation: 5,
            child: ListTile(
              contentPadding: EdgeInsets.all(16),
              title: Text(
                notification.title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(notification.description),
              trailing: Text(notification.time),
            ),
          );
        },
      ),
    );
  }
}

class NotificationModel {
  final String title;
  final String description;
  final String time;

  NotificationModel({required this.title, required this.description, required this.time});
}
