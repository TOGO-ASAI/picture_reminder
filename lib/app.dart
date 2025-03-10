import 'package:flutter/material.dart';
import 'app/routes.dart';
import 'package:provider/provider.dart';
import 'app/widgets/schedule_modal.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => MyAppState(),
        child: MaterialApp(
          title: 'Sphere App',
          initialRoute: AppRoutes.gallery,
          onGenerateRoute: AppRoutes.generateRoute,
          theme: ThemeData(
            fontFamily: 'NotoSansJP',
            useMaterial3: true,
          ),
          home: const BottomNavigation(),
        ));
  }
}

class MyAppState extends ChangeNotifier {
  var selectedIndex = 1;

  void changePage(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Scaffold(
      body: SafeArea(
        child: Navigator(
          key: _navigatorKey,
          initialRoute: AppRoutes.gallery,
          onGenerateRoute: AppRoutes.generateRoute,
        ),
      ),
      floatingActionButton: appState.selectedIndex == 0
    ? FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => const ScheduleModal(),
          );
        },
        child: const Icon(Icons.add),
      )
    : null,
      bottomNavigationBar: SafeArea(
        child: BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    appState.changePage(0);
                    _navigatorKey.currentState
                        ?.pushReplacementNamed(AppRoutes.schedule);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 24,
                        color: appState.selectedIndex == 0
                            ? Colors.deepOrange
                            : null,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '予定',
                        style: TextStyle(
                          fontSize: 12,
                          color: appState.selectedIndex == 0
                              ? Colors.deepOrange
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    appState.changePage(1);
                    _navigatorKey.currentState
                        ?.pushReplacementNamed(AppRoutes.gallery);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.photo_album,
                        size: 24,
                        color: appState.selectedIndex == 1
                            ? Colors.deepOrange
                            : null,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'アルバム',
                        style: TextStyle(
                          fontSize: 12,
                          color: appState.selectedIndex == 1
                              ? Colors.deepOrange
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    appState.changePage(2);
                    _navigatorKey.currentState
                        ?.pushReplacementNamed(AppRoutes.settings);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.settings,
                        size: 24,
                        color: appState.selectedIndex == 2
                            ? Colors.deepOrange
                            : null,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '設定',
                        style: TextStyle(
                          fontSize: 12,
                          color: appState.selectedIndex == 2
                              ? Colors.deepOrange
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    appState.changePage(3);
                    _navigatorKey.currentState
                        ?.pushReplacementNamed(AppRoutes.db);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.table_chart,
                        size: 24,
                        color: appState.selectedIndex == 3
                            ? Colors.deepOrange
                            : null,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'DB',
                        style: TextStyle(
                          fontSize: 12,
                          color: appState.selectedIndex == 3
                              ? Colors.deepOrange
                              : null,
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

