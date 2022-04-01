import 'package:flutter/material.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

import 'aot.dart';

void main() async {
  await AndroidAlarmManager.initialize();
  runApp(const MyApp());
}
