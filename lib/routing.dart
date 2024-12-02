import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habita/presentation/screens/add_habit_screen.dart';
import 'package:habita/presentation/screens/add_record_screen.dart';
import 'package:habita/presentation/screens/auth/change_password_screen.dart';
import 'package:habita/presentation/screens/auth/forget_password_screen.dart';
import 'package:habita/presentation/screens/auth/login_screen.dart';
import 'package:habita/presentation/screens/auth/reset_code_screen.dart';
import 'package:habita/presentation/screens/auth/sign_up_screen.dart';
import 'package:habita/presentation/screens/chat_screen.dart';
import 'package:habita/presentation/screens/edit_profile_screen.dart';
import 'package:habita/presentation/screens/explore_screen.dart';
import 'package:habita/presentation/screens/gallery_screen.dart';
import 'package:habita/presentation/screens/habit_management_screen.dart';
import 'package:habita/presentation/screens/home_screen.dart';
import 'package:habita/presentation/screens/profile_screen.dart';
import 'package:habita/presentation/screens/record_details_screen.dart';
import 'package:habita/presentation/screens/search_result_screen.dart';
import 'package:habita/presentation/screens/search_screen.dart';
import 'package:habita/presentation/screens/single_habit_screen.dart';
import 'package:habita/presentation/screens/splash_screen.dart';
import 'package:habita/presentation/screens/user_basic_info_setup_screen.dart';
import 'package:habita/presentation/screens/wallet_introduction_screen.dart';
import 'package:habita/presentation/screens/wallet_screen.dart';

import 'presentation/screens/seed_words_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/splash-screen',
  routes: [
    GoRoute(
      path: '/splash-screen',
      name: 'splash-screen',
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: '/change-password',
      name: 'change-password',
      builder: (context, state) => ChangePasswordScreen(),
    ),
    GoRoute(
      path: '/forget-password',
      name: 'forget-password',
      builder: (context, state) => ForgetPasswordScreen(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/reset-code',
      name: 'reset-code',
      builder: (context, state) => ResetCodeScreen(),
    ),
    GoRoute(
      path: '/sign-up',
      name: 'sign-up',
      builder: (context, state) => SignUpScreen(),
    ),
    GoRoute(
      path: '/add-habit',
      name: 'add-habit',
      builder: (context, state) => AddHabitScreen(),
    ),
    GoRoute(
      path: '/add-record',
      name: 'add-record',
      builder: (context, state) => AddRecordScreen(),
    ),
    GoRoute(
      path: '/chat',
      name: 'chat',
      builder: (context, state) => ChatScreen(),
    ),
    GoRoute(
      path: '/edit-profile',
      name: 'edit-profile',
      builder: (context, state) => EditProfileScreen(),
    ),
    GoRoute(
      path: '/explore',
      name: 'explore',
      builder: (context, state) => ExploreScreen(),
    ),
    GoRoute(
      path: '/gallery',
      name: 'gallery',
      builder: (context, state) => GalleryScreen(),
    ),
    GoRoute(
      path: '/habit-management',
      name: 'habit-management',
      builder: (context, state) => HabitManagementScreen(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/profile',
      name: 'profile',
      builder: (context, state) => ProfileScreen(),
    ),
    GoRoute(
      path: '/record-details',
      name: 'record-details',
      builder: (context, state) => RecordDetailsScreen(),
    ),
    GoRoute(
      path: '/search-result',
      name: 'search-result',
      builder: (context, state) => SearchResultScreen(
        searchQuery: "Hello",
      ),
    ),
    GoRoute(
      path: '/search',
      name: 'search',
      builder: (context, state) => SearchScreen(),
    ),
    GoRoute(
      path: '/seed-words',
      name: 'seed-words',
      builder: (context, state) => SeedWordsScreen(),
    ),
    GoRoute(
      path: '/single-habit',
      name: 'single-habit',
      builder: (context, state) => SingleHabitScreen(
        isMember: false,
      ),
    ),
    GoRoute(
      path: '/user-basic-info-setup',
      name: 'user-basic-info-setup',
      builder: (context, state) => UserBasicInfoSetupScreen(),
    ),
    GoRoute(
      path: '/wallet-introduction',
      name: 'wallet-introduction',
      builder: (context, state) => WalletIntroductionScreen(),
    ),
    GoRoute(
      path: '/wallet',
      name: 'wallet',
      builder: (context, state) => WalletScreen(),
    ),
  ],
);
