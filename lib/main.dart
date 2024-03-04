import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:judge/screens/dashboard.dart';

import 'misc/theme.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EasyFinance - Finanças Pessoais',
      theme: lightTheme,
      darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
      home: const DashboardPage(),
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

