import 'package:flutter/material.dart';
import 'package:helth_controller/features/pages/main_screen/main_screen.dart';
import 'package:helth_controller/features/pages/profile_screen/profile_screen.dart';

final Map<String, WidgetBuilder> routes = {
  '/': (context) => const MainScreen(),
  '/profile': (context) => const ProfileScreen(),
};
