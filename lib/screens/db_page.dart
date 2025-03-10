import 'package:flutter/material.dart';

class DBPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DB確認'),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              // 閉じるアイコンを押すとホームに戻る
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          'ここにDBの内容を表示する',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
