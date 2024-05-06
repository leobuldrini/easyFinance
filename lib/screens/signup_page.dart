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
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
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
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
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
              'Email',
              style: GoogleFonts.getFont(
                'Montserrat',
                textStyle:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
            ),
            TextField(
              controller: emailController,
              focusNode: emailFocusNode,
              onSubmitted: (username) {
                if (username != '') {
                  FocusScope.of(context).requestFocus(passwordFocusNode);
                } else {
                  FocusScope.of(context).requestFocus(emailFocusNode);
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
                      .signUp(emailController.text, passwordController.text);
                } else {
                  FocusScope.of(context).requestFocus(passwordFocusNode);
                }
              },
            ),
            const SizedBox(height: 15),
            TextButton(
              onPressed: () {
                if (emailController.text != '' &&
                    passwordController.text != '') {
                  ref
                      .read(loginControllerProvider.notifier)
                      .signUp(emailController.text, passwordController.text);
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).colorScheme.primary),
                padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              child: Text(
                'Sign Up',
                style: GoogleFonts.getFont(
                  'Montserrat',
                  textStyle: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account?',
                  style: GoogleFonts.getFont(
                    'Montserrat',
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (Navigator.of(context).canPop()) {
                      Navigator.of(context).pop();
                    } else if (Navigator.of(context).canPop()) {
                      Navigator.of(context).pushReplacementNamed('/');
                    }
                  },
                  child: Text(
                    'Login',
                    style: GoogleFonts.getFont(
                      'Montserrat',
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
