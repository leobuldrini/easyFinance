import 'package:easyFinance/core/providers/current_page_provider.dart';
import 'package:easyFinance/screens/dashboard.dart';
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

    return Scaffold(
      body: IndexedStack(
        index: currentPage,
        children: screens,
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
