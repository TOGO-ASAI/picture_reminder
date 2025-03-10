import 'package:flutter/material.dart';
import '../app/routes.dart'; // Make sure the import path is correct


class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> settingItems = [
      {'title': 'アカウント設定', 'description': 'アカウントの詳細を変更します。'},
      {'title': '通知設定', 'description': '通知の設定を管理します。'},
      {'title': 'プライバシー', 'description': 'プライバシー設定を調整します。'},
      {'title': 'テーマ', 'description': 'アプリのテーマを変更します。'},
      {'title': 'アプリ情報', 'description': 'バージョン情報とライセンス。'},
    ];

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
      body: ListView.separated(
        itemCount: settingItems.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          final item = settingItems[index];
          return ListTile(
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
    );
  }
}
