import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habita/presentation/screens/home_screen.dart';
import 'package:habita/presentation/screens/splash_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/splash_screen',
  routes: [
    GoRoute(
      path: '/splash_screen',
      name: 'splash_screen',
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => Container(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/profile/:id',
      name: 'profile',
      builder: (context, state) {
        // final id = state.params['id']; // Access dynamic segment
        return Container();
      },
    ),
  ],
);