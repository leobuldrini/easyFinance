import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final StateProvider<SupabaseClient?> supabaseClientProvider = StateProvider<SupabaseClient?>((ref) { return null;});
