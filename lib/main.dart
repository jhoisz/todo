import 'package:flutter/material.dart';
import 'package:todo/themes/theme.dart';

import 'screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo',
      theme: mytheme,
      home: const Home(),
    );
  }
}
