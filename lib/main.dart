import 'package:flutter/material.dart';
import 'package:flutter_bloc_master_course/src/retrofit/main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const RetroFit(),
    );
  }
}
