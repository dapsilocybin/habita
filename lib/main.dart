import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/services/supabase_service.dart';
import 'core/theme/app_theme.dart';
import 'data/providers/auth_provider.dart';
import 'data/repositories/auth_repository.dart';
import 'logic/blocs/auth/auth_bloc.dart';
import 'presentation/screens/authentication/phone_login_page.dart';
import 'presentation/screens/authentication/auth_gate.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SupabaseService.initialize();

  runApp(
    BlocProvider(
      create: (_) =>
          AuthBloc(AuthRepository(AuthProvider(SupabaseService.client))),
      child: const HabitaApp(),
    ),
  );
}

class HabitaApp extends StatelessWidget {
  const HabitaApp({super.key});

  static const Color initialSeedColor = Color(0xFF71A7EE);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habita',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(seedColor: initialSeedColor),
      darkTheme: AppTheme.darkTheme(seedColor: initialSeedColor),
      themeMode: ThemeMode.light,
      home: const AuthGate(),
    );
  }
}
