import 'package:easyFinance/screens/home.dart';
import 'package:easyFinance/screens/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'misc/theme.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await Supabase.initialize(
      url: const String.fromEnvironment('SUPABASE_URL'),
      anonKey: const String.fromEnvironment('SUPABASE_KEY'));
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    initializeDateFormatting('pt_BR', null);
    return MaterialApp(
      title: 'EasyFinance - Finanças Pessoais',
      theme: lightTheme,
      darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (_) => const Home(),
        '/signUp': (_) => const SignUpPage(),
      },
    );
  }
}

/*
/* CSS HEX */
--lapis-lazuli: #22577aff;
--verdigris: #38a3a5ff;
--emerald: #57cc99ff;
--light-green: #80ed99ff;
--tea-green: #c7f9ccff;

/* CSS HEX *//
--caf-noir: #4c2e05ff;
--reseda-green: #7a8450ff;
--delft-blue: #434371ff;
--papaya-whip: #f9ecccff;
--nyanza: #edf7d2ff;
 */

