import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:namer_app/main.dart';
import 'package:namer_app/routes/app_routes.dart';

class AppPages {
  late final router = GoRouter(initialLocation: AppRoutes.home, routes: [
    GoRoute(
        path: AppRoutes.home,
        name: AppRoutes.home,
        builder: (context, state) => MyHomePage(),
        routes: [
          GoRoute(
              path: AppRoutes.second,
              name: AppRoutes.second,
              builder: (context, state) => SecondPage())
        ])
  ]);
}
