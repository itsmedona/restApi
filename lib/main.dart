import 'package:flutter/material.dart';

import 'view/HomePage/HomePage.dart';

void main() {
  runApp(const ApiApp());
}
class ApiApp extends StatelessWidget {
  const ApiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:HomePage()
    );
  }
}