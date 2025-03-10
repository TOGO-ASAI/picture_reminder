import 'package:flutter/material.dart';
import '../screens/schedule_page.dart';
import '../screens/gallery_page.dart';
import '../screens/settings_page.dart';
import '../screens/setting_detail_page.dart';
import '../screens/db_page.dart';

class AppRoutes {
  static const String schedule = '/schedule';
  static const String gallery = '/';
  static const String settings = '/settings';
  static const String settingDetail = '/settingDetail';
  static const String db = '/db';

  static Route<dynamic>? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => GalleryPage());
      case schedule:
        return MaterialPageRoute(builder: (_) => SchedulePage());
      case settings:
        return MaterialPageRoute(builder: (_) => SettingsPage());
      case settingDetail:
        final args = routeSettings.arguments as Map<String, String>;
        return MaterialPageRoute(
          builder: (_) => SettingDetailPage(
            title: args['title']!,
            description: args['description']!,
          ),
        );
      case db:
        return MaterialPageRoute(builder: (_) => DBPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
                child: Text('No route defined for ${routeSettings.name}')),
          ),
        );
    }
  }
}
