import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  var selectedIndex = 0;

  void changePage(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}

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

class GalleryPage extends StatelessWidget {
  final List<String> galleryItems = List.generate(
    30,
    (index) => 'ギャラリーアイテム ${index + 1}',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('アルバム'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.0,
          ),
          itemCount: galleryItems.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        galleryItems[index],
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 8),
                    Expanded(
                      child: Text(
                        'これはギャラリーアイテム ${index + 1} の説明文です。ここに詳細情報が入ります。',
                        style: TextStyle(fontSize: 14),
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class SlideRightToLeftRoute extends PageRouteBuilder {
  final Widget page;
  
  SlideRightToLeftRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
}

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
      Navigator.of(context).push(
        SlideRightToLeftRoute(
          page: SettingDetailPage(
            title: title,
            description: description,
          ),
        ),
      );
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

class SettingDetailPage extends StatelessWidget {
  final String title;
  final String description;

  const SettingDetailPage({
    required this.title,
    required this.description,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            Divider(),
            SizedBox(height: 16),
            Text(
              'このセクションの詳細設定はここに表示されます。現在開発中です。',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    
    Widget page;
    switch (appState.selectedIndex) {
      case 0:
        page = SchedulePage();
        break;
      case 1:
        page = GalleryPage();
        break;
      case 2:
        page = SettingsPage();
        break;
      default:
        throw UnimplementedError('No widget for ${appState.selectedIndex}');
    }

    return Scaffold(
      body: SafeArea(
        child: page,
      ),
      bottomNavigationBar: SafeArea(
        child: BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => appState.changePage(0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.calendar_today, 
                        size: 24,
                        color: appState.selectedIndex == 0 ? Colors.deepOrange : null,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '予定', 
                        style: TextStyle(
                          fontSize: 12,
                          color: appState.selectedIndex == 0 ? Colors.deepOrange : null,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => appState.changePage(1),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.photo_album, 
                        size: 24,
                        color: appState.selectedIndex == 1 ? Colors.deepOrange : null,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'アルバム',
                        style: TextStyle(
                          fontSize: 12,
                          color: appState.selectedIndex == 1 ? Colors.deepOrange : null,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => appState.changePage(2),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.settings, 
                        size: 24,
                        color: appState.selectedIndex == 2 ? Colors.deepOrange : null,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '設定', 
                        style: TextStyle(
                          fontSize: 12,
                          color: appState.selectedIndex == 2 ? Colors.deepOrange : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}