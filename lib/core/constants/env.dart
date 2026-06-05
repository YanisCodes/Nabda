/// Remplacer les valeurs ci-dessous avec les credentials de votre projet Supabase.
/// Dashboard → Settings → API
abstract final class Env {
  static const supabaseUrl = 'https://YOUR_PROJECT_ID.supabase.co';
  static const supabaseAnonKey = 'YOUR_ANON_KEY';

  /// true si Supabase est configuré (évite les erreurs au démarrage)
  static bool get isConfigured =>
      !supabaseUrl.contains('YOUR_PROJECT') &&
      !supabaseAnonKey.contains('YOUR_ANON');
}
