import 'package:flutter/material.dart';

import 'theme/app_theme.dart';
import 'widgets/home_screen.dart';

void main() => runApp(const TechToolkitApp());

class TechToolkitApp extends StatelessWidget {
  const TechToolkitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tech Toolkit',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const HomeScreen(),
    );
  }
}
