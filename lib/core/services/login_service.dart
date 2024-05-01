import 'package:easyFinance/core/providers/supabase_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginService {
  final Ref _ref;
  Future<bool> login(String email, String password) async {
    final supabaseClient = _ref.read(supabaseClientProvider.notifier).state!;
    late final AuthResponse response;
    try {
      response = await supabaseClient.auth
          .signInWithPassword(password: password, email: email);
    } on AuthException {
      return false;
    }
    return response.user != null;
  }

  Future<bool> signUp(String email, String password) async {
    final supabaseClient = _ref.read(supabaseClientProvider.notifier).state!;
    late final AuthResponse response;
    try {
      response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        emailRedirectTo:
            kIsWeb ? null : 'io.supabase.flutterquickstart://login-callback/',
      );
    } on AuthException {
      return false;
    }

    return response.user != null;
  }

  LoginService(this._ref);
}

final loginServiceProvider = Provider((ref) => LoginService(ref));
