import 'package:flutter/material.dart';
import 'package:habita/core/theme/app_theme.dart';
import 'package:habita/presentation/screens/about/about_page.dart';
import 'package:habita/presentation/screens/account_management/account_management_page.dart';
import 'package:habita/presentation/screens/achievements/achievements_page.dart';
import 'package:habita/presentation/screens/add_record/add_record_page.dart';
import 'package:habita/presentation/screens/admin_analytics/admin_analytics_page.dart';
import 'package:habita/presentation/screens/admin_dashboard/admin_dashboard_page.dart';
import 'package:habita/presentation/screens/admin_habits/admin_habits_page.dart';
import 'package:habita/presentation/screens/admin_record_verification/admin_record_verification_page.dart';
import 'package:habita/presentation/screens/admin_reports/admin_reports_page.dart';
import 'package:habita/presentation/screens/admin_users/admin_users_page.dart';
import 'package:habita/presentation/screens/authentication/account_setup_page.dart';
import 'package:habita/presentation/screens/authentication/otp_verification_page.dart';
import 'package:habita/presentation/screens/authentication/phone_login_page.dart';
import 'package:habita/presentation/screens/blocked_users/blocked_users_page.dart';
import 'package:habita/presentation/screens/challenge_detail/challenge_detail_page.dart';
import 'package:habita/presentation/screens/challenge_leaderboard/challenge_leaderboard_page.dart';
import 'package:habita/presentation/screens/challenges/challenges_page.dart';
import 'package:habita/presentation/screens/change_phone_number/change_phone_number_page.dart';
import 'package:habita/presentation/screens/chat/chat_page.dart';
import 'package:habita/presentation/screens/comments/comments_page.dart';
import 'package:habita/presentation/screens/edit_profile/edit_profile_page.dart';
import 'package:habita/presentation/screens/explore/explore_page.dart';
import 'package:habita/presentation/screens/followers_following/followers_following_page.dart';
import 'package:habita/presentation/screens/following_feed/following_feed_page.dart';
import 'package:habita/presentation/screens/habit_detail/habit_detail_page.dart';
import 'package:habita/presentation/screens/habit_search_results/habit_search_results_page.dart';
import 'package:habita/presentation/screens/habit_tracker/habit_tracker_page.dart';
import 'package:habita/presentation/screens/habit_tree/habit_tree_page.dart';
import 'package:habita/presentation/screens/help_support/help_support_page.dart';
import 'package:habita/presentation/screens/home/home_screen.dart';
import 'package:habita/presentation/screens/language_selection/language_selection_page.dart';
import 'package:habita/presentation/screens/media_viewer/media_viewer_page.dart';
import 'package:habita/presentation/screens/messages/messages_page.dart';
import 'package:habita/presentation/screens/my_records/my_records_page.dart';
import 'package:habita/presentation/screens/notification/notifications_page.dart';
import 'package:habita/presentation/screens/privacy_policy/privacy_policy_page.dart';
import 'package:habita/presentation/screens/private_habit_creator/private_habit_creator_page.dart';
import 'package:habita/presentation/screens/profile/profile_page.dart';
import 'package:habita/presentation/screens/record_detail/record_detail_page.dart';
import 'package:habita/presentation/screens/referral/referral_page.dart';
import 'package:habita/presentation/screens/report/report_page.dart';
import 'package:habita/presentation/screens/saved_records/saved_records_page.dart';
import 'package:habita/presentation/screens/search/search_page.dart';
import 'package:habita/presentation/screens/settings/settings_page.dart';
import 'package:habita/presentation/screens/splash/splash_screen.dart';
import 'package:habita/presentation/screens/statistics/statistics_page.dart';
import 'package:habita/presentation/screens/status/status_page.dart';
import 'package:habita/presentation/screens/terms_conditions/terms_conditions_page.dart';
import 'package:habita/presentation/screens/theme_selection/theme_selection_page.dart';
import 'package:habita/presentation/screens/transaction_history/transaction_history_page.dart';
import 'package:habita/presentation/screens/user_profile/user_profile_page.dart';
import 'package:habita/presentation/screens/user_search_results/user_search_results_page.dart';
import 'package:habita/presentation/screens/wallet/wallet_page.dart';

void main() {
  runApp(const HabitaApp());
}

class HabitaApp extends StatelessWidget {
  const HabitaApp({super.key});

  // Optional: provide a custom seed color here if you want to override default
  final Color? initialSeedColor = Colors.purple; // e.g. Color(0xFF8AB6F9);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habita',
      debugShowCheckedModeBanner: false,
      // CALL the functions so they return ThemeData objects:
      theme: AppTheme.lightTheme(seedColor: initialSeedColor),
      darkTheme: AppTheme.darkTheme(seedColor: initialSeedColor),
      themeMode: ThemeMode.system, // or ThemeMode.light / ThemeMode.dark
      home: const SplashScreen(),
      routes: {
        '/home': (context) => const WalletPage(), // replace with your HomePage
      },
    );
  }
}
