import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  SupabaseService._();

  static SupabaseClient get client {
    return Supabase.instance.client;
  }

  static Future<void> initialize() async {
    const supabaseUrl = "https://qzqxjjjqtmefcqwavkcg.supabase.co";
    const supabasePublishableKey =
        "sb_publishable_5PmvZIJEZT_G8-mK8OZxdA_hgn885XQ";

    if (supabaseUrl.isEmpty || supabasePublishableKey.isEmpty) {
      throw StateError(
        'Supabase configuration is missing. '
        'Run the app with --dart-define-from-file=env.json.',
      );
    }

    await Supabase.initialize(
      url: supabaseUrl,
      publishableKey: supabasePublishableKey,
    );
  }
}
