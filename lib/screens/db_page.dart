import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class DBPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DB確認'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: DatabaseHelper.instance.queryAllReminders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          var data = snapshot.data;
          if (data == null || data.isEmpty) {
            return Center(child: Text('No reminders found.'));
          }
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Title')),
                DataColumn(label: Text('Description')),
                DataColumn(label: Text('Reminder Date')),
                DataColumn(label: Text('Is Active')),
                DataColumn(label: Text('Created At')),
                DataColumn(label: Text('Updated At')),
              ],
              rows: data.map((reminder) {
                return DataRow(cells: [
                  DataCell(Text('${reminder['id']}')),
                  DataCell(Text(reminder['title'] ?? '')),
                  DataCell(Text(reminder['description'] ?? '')),
                  DataCell(Text(reminder['reminder_date'] ?? '')),
                  DataCell(Text('${reminder['is_active']}')),
                  DataCell(Text(reminder['created_at'] ?? '')),
                  DataCell(Text(reminder['updated_at'] ?? '')),
                ]);
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
