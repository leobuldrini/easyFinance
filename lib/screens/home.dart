import 'package:easyFinance/core/providers/current_page_provider.dart';
import 'package:easyFinance/core/providers/login_controller_provider.dart';
import 'package:easyFinance/core/states/login_states.dart';
import 'package:easyFinance/screens/dashboard.dart';
import 'package:easyFinance/screens/login_page.dart';
import 'package:easyFinance/screens/sector_view.dart';
import 'package:easyFinance/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screens = [
      const DashboardPage(),
      const SectorPage(),
    ];
    int currentPage = ref.watch(currentPageProvider);
    final loginState = ref.watch(loginControllerProvider);
    return Scaffold(
      body: loginState is LoginStateSuccess ? IndexedStack(
        index: currentPage,
        children: screens,
      ) : const LoginScreen(),
      bottomNavigationBar: loginState is LoginStateSuccess ? const NavBar() : null,
    );
  }
}
