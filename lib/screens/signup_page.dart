import 'dart:async';

import 'package:easyFinance/core/providers/login_controller_provider.dart';
import 'package:easyFinance/core/providers/supabase_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 200,
                ),
                Text(
                  'Sign Up',
                  style: GoogleFonts.getFont(
                    'Montserrat',
                    textStyle: const TextStyle(
                        fontSize: 48, fontWeight: FontWeight.w800),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 40,
                ),
                const _SignUpForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SignUpForm extends ConsumerStatefulWidget {
  const _SignUpForm();

  @override
  ConsumerState<_SignUpForm> createState() => __SignUpFormState();
}

class __SignUpFormState extends ConsumerState<_SignUpForm> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode usernameFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  
  bool _redirecting = false;
  late final StreamSubscription<AuthState> _authStateSubscription;

  @override
  void initState() {
    final supabase = ref.read(supabaseClientProvider.notifier).state!;
    _authStateSubscription = supabase.auth.onAuthStateChange.listen((data) {
      if (_redirecting) return;
      final session = data.session;
      if (session != null) {
        _redirecting = true;
        Navigator.of(context).pop();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    usernameFocusNode.dispose();
    passwordFocusNode.dispose();
    _authStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Text(
              'Username',
              style: GoogleFonts.getFont(
                'Montserrat',
                textStyle:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
            ),
            TextField(
              controller: usernameController,
              focusNode: usernameFocusNode,
              onSubmitted: (username) {
                if (username != '') {
                  FocusScope.of(context).requestFocus(passwordFocusNode);
                } else {
                  FocusScope.of(context).requestFocus(usernameFocusNode);
                }
              },
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Password',
              style: GoogleFonts.getFont(
                'Montserrat',
                textStyle:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
            ),
            TextField(
              focusNode: passwordFocusNode,
              controller: passwordController,
              obscureText: true,
              onSubmitted: (password) {
                if (password != '') {
                  ref
                      .read(loginControllerProvider.notifier)
                      .signUp(usernameController.text, passwordController.text);
                } else {
                  FocusScope.of(context).requestFocus(passwordFocusNode);
                }
              },
            ),
          ],
        ));
  }
}
