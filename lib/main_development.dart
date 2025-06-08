import 'package:flutter/material.dart';
import 'package:interactive_calendar/config/dependencies.dart';
import 'package:interactive_calendar/main.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

void main() {
  Logger.root.level = Level.ALL;
  runApp(MultiProvider(providers: providersLocal, child: const MyApp()));
}