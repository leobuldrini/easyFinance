import 'package:easyFinance/core/providers/login_controller_provider.dart';
import 'package:easyFinance/core/states/login_states.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                SizedBox(
                  height: 200,
                  child: Lottie.network(
                      'https://lottie.host/47684b35-7638-4148-8782-80a7bc9e7fab/xNg4fR6Prv.json'),
                ),
                Text(
                  'EasyFinance',
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
                const LoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode usernameFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginControllerProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                    .login(usernameController.text, passwordController.text);
              } else {
                FocusScope.of(context).requestFocus(passwordFocusNode);
              }
            },
          ),
          const SizedBox(
            height: 15,
          ),
          TextButton(
            onPressed: () {
              if (usernameController.text != '' &&
                  passwordController.text != '') {
                print('b');
                ref
                    .read(loginControllerProvider.notifier)
                    .login(usernameController.text, passwordController.text);
              } else {
                print('a');
              }
            },
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
              ),
              fixedSize: const Size(200, 60),
            ),
            child: loginState is LoginStateLoading
                ? CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.onPrimary,
                  )
                : Text(
                    'Login',
                    style: GoogleFonts.getFont(
                      'Montserrat',
                      textStyle: TextStyle(
                          fontSize: 24, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ),
          ),
          const SizedBox(
            height: 15,
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/signUp');
            },
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
              ),
              fixedSize: const Size(250, 60),
            ),
            child: loginState is LoginStateLoading
                ? CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.onSecondary,
                  )
                : Text(
                    'Don\'t have an account? Sign Up',
                    style: GoogleFonts.getFont(
                      'Montserrat',
                      textStyle: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.onSecondary),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
