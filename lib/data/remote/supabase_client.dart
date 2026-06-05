import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/constants/env.dart';

Future<void> initSupabase() async {
  if (!Env.isConfigured) return;
  await Supabase.initialize(
    url: Env.supabaseUrl,
    publishableKey: Env.supabaseAnonKey,
  );
}

final supabaseClientProvider = Provider<SupabaseClient>(
  (_) => Supabase.instance.client,
);
