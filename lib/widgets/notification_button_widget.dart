import 'package:flutter/material.dart';
import '../utils/notification_helper.dart';

class NotificationTestButton extends StatelessWidget {
  const NotificationTestButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await NotificationHelper.scheduleNotification(
          id: 2,
          title: 'Meeting Reminder',
          body: 'Don\'t forget your 2:00 PM meeting.',
          scheduledDate: DateTime.now().add(Duration(minutes: 10)),
          payload: 'meeting_reminder',
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Test notification sent!')),
        );
      },
      child: const Text('Test Notification'),
    );
  }
}