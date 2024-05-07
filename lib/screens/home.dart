import 'package:easyFinance/core/providers/current_page_provider.dart';
import 'package:easyFinance/core/providers/login_controller_provider.dart';
import 'package:easyFinance/core/providers/supabase_provider.dart';
import 'package:easyFinance/core/states/login_states.dart';
import 'package:easyFinance/screens/dashboard.dart';
import 'package:easyFinance/screens/login_page.dart';
import 'package:easyFinance/screens/monthly_report_view.dart';
import 'package:easyFinance/screens/sector_view.dart';
import 'package:easyFinance/screens/user_menu.dart';
import 'package:easyFinance/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

bool logged = false;

class Home extends ConsumerWidget {
  const Home({super.key});

  void onInit(WidgetRef ref) {
    if (logged) {
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final database = openDatabase(
        // Set the path to the database. Note: Using the `join` function from the
        // `path` package is best practice to ensure the path is correctly
        // constructed for each platform.
        join(await getDatabasesPath(), 'user_sectors.db'),
        onCreate: (db, version) {
          // Run the CREATE TABLE statement on the database.
          return db.execute(
            'CREATE TABLE user_sectors(name TEXT PRIMARY KEY, income BOOLEAN)',
          );
        },
        // Set the version. This executes the onCreate function and provides a
        // path to perform database upgrades and downgrades.
        version: 1,
      );
      ref.read(sqliteClientProvider.notifier).state = database;
      ref.read(supabaseClientProvider.notifier).state =
          Supabase.instance.client;
      ref.read(loginControllerProvider.notifier).retrieveSession();
      logged = true;
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    onInit(ref);
    final screens = [
      const DashboardPage(),
      const SectorPage(),
      const MonthlyReportScreen(),
      const UserMenu(),
    ];
    int currentPage = ref.watch(currentPageProvider);
    final loginState = ref.watch(loginControllerProvider);
    return Scaffold(
      body: loginState is LoginStateSuccess
          ? IndexedStack(
              index: currentPage,
              children: screens,
            )
          : const LoginScreen(),
      bottomNavigationBar:
          loginState is LoginStateSuccess ? const NavBar() : null,
    );
  }
}
