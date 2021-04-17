import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:resonote/injection.dart';
import 'package:resonote/presentation/core/app_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureInjection(Environment.dev);
  runApp(AppWidget());
}
