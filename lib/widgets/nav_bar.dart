import 'package:easyFinance/core/providers/current_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NavBar extends ConsumerWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 66,
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      margin: const EdgeInsets.fromLTRB(8, 0, 8, 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withOpacity(0.8),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.surface.withOpacity(0.3),
            offset: const Offset(0, 20),
            blurRadius: 20,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              ref.read(currentPageProvider.notifier).state = 0;
            },
            icon: Icon(
              Icons.home_rounded,
              size: 24,
              color: Theme.of(context).colorScheme.primary,
            ),
            color: Theme.of(context).colorScheme.primary,
          ),
          IconButton(
            onPressed: () {
              ref.read(currentPageProvider.notifier).state = 1;
            },
            icon: Icon(
              Icons.pie_chart_rounded,
              size: 24,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          IconButton(
            onPressed: () {
              // ref.read(currentPageProvider.notifier).state = 2;
            },
            icon: Icon(
              Icons.compare_arrows_rounded,
              size: 24,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          IconButton(
            onPressed: () {
              // ref.read(currentPageProvider.notifier).state = 3;
            },
            icon: Icon(
              Icons.person_rounded,
              size: 24,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
