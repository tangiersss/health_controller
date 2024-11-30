import 'package:flutter/material.dart';
import 'package:helth_controller/features/router/router.dart';

void main() => runApp(const MaterialApp(
      home: HealthControllerApp(),
    ));

class HealthControllerApp extends StatelessWidget {
  const HealthControllerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: routes,
    );
  }
}
