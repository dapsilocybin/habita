
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart'
    show Session, Supabase;

import 'email_entry_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final client = Supabase.instance.client;

    return StreamBuilder<Session?>(
      stream: client.auth.onAuthStateChange.map(
        (authState) => authState.session,
      ),
      initialData: client.auth.currentSession,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting &&
            !snapshot.hasData) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final session = snapshot.data;

        if (session != null) {
          return const HomeDestinationPage();
        }

        return const EmailEntryPage();
      },
    );
  }
}

// Temporary destination until you connect your actual Home screen.
class HomeDestinationPage extends StatelessWidget {
  const HomeDestinationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habita'),
        actions: [
          IconButton(
            tooltip: 'خروج از حساب',
            icon: const Icon(Icons.logout_rounded),
            onPressed: () async {
              await Supabase.instance.client.auth.signOut();
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('ورود موفقیت‌آمیز بود؛ به هابیتا خوش آمدید.'),
      ),
    );
  }
}
