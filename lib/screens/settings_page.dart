import 'package:flutter/material.dart';
import '../app/routes.dart'; // Make sure the import path is correct
import '../utils/notification_helper.dart'; // Import the notification helper

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> settingItems = [
      {'title': 'アカウント設定', 'description': 'アカウントの詳細を変更します。'},
      {'title': '通知設定', 'description': '通知の設定を管理します。'},
      {'title': 'プライバシー', 'description': 'プライバシー設定を調整します。'},
      {'title': 'テーマ', 'description': 'アプリのテーマを変更します。'},
      {'title': 'アプリ情報', 'description': 'バージョン情報とライセンス。'},
      {'title': 'スケジュール通知', 'description': '通知スケジュールを管理します。'},
    ];

    void _navigateToSchedulePage(BuildContext context) {
      Navigator.pushNamed(context, AppRoutes.schedule);
    }

    void _navigateToSettingDetail(BuildContext context, String title, String description) {
      Navigator.pushNamed(context, AppRoutes.settingDetail, arguments: {
        'title': title,
        'description': description,
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('設定'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // List takes most of the space
          Expanded(
            child: ListView.separated(
              itemCount: settingItems.length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) {
                final item = settingItems[index];
                return index == settingItems.length - 1
                    ? ListTile(
                        title: Text(item['title']!),
                        trailing: Icon(Icons.chevron_right),
                        onTap: () => _navigateToSchedulePage(context),
                      )
                    : ListTile(
                  title: Text(item['title']!),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () => _navigateToSettingDetail(
                    context, 
                    item['title']!, 
                    item['description']!,
                  ),
                );
              },
            ),
          ),
          
          // Notification test button at the bottom
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () async {
                await NotificationHelper.scheduleNotification(
                  id: 2,
                  title: 'Meeting Reminder',
                  body: 'Don\'t forget your 2:00 PM meeting.',
                  scheduledDate: DateTime.now().add(Duration(seconds: 10)), // changed from minutes: 10 to seconds: 10
                  payload: 'meeting_reminder',
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50), // Full width button
                backgroundColor: Colors.deepOrange, // Match your app's accent color
              ),
              child: const Text(
                '通知テスト',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
