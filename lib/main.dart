import 'package:flutter/material.dart';
import 'app.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'utils/notification_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones(); // ←忘れずに！
  await NotificationHelper.initialize(); // ←忘れずに！
  runApp(MyApp());
}
