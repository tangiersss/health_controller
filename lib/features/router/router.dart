import 'package:flutter/material.dart';
import 'package:helth_controller/features/pages/analyses_screen/analyses_screen.dart';
import 'package:helth_controller/features/pages/main_screen/main_screen.dart';
import 'package:helth_controller/features/pages/profile_screen/profile_screen.dart';

final Map<String, WidgetBuilder> routes = {
  '/': (context) => const MainScreen(),
  '/analyse': (context) => const AnalysesScreen(),
  '/profile': (context) => const ProfileScreen(),
};
