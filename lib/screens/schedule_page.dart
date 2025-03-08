import 'package:flutter/material.dart';

class SchedulePage extends StatelessWidget {
  final List<Map<String, String>> scheduleItems = List.generate(
    20,
    (index) => {
      'title': '予定 ${index + 1}',
      'date': '2023/6/${(index % 30) + 1}',
      'description': 'これは予定 ${index + 1} の説明です。このテキストが長い場合は省略されます。詳細情報も含まれていますが、画面に収まりきらない場合は…',
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('スケジュール'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: scheduleItems.length,
          itemBuilder: (context, index) {
            final item = scheduleItems[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Card(
                elevation: 2.0,
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text('${index + 1}'),
                  ),
                  title: Text(
                    item['title']!,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '日付: ${item['date']}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        item['description']!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
                  isThreeLine: true,
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${item['title']} が選択されました'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
