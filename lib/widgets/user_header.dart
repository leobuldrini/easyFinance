import 'package:easyFinance/core/providers/login_controller_provider.dart';
import 'package:easyFinance/core/providers/supabase_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

class UserHeader extends ConsumerStatefulWidget {
  const UserHeader({super.key});

  @override
  ConsumerState<UserHeader> createState() => _UserHeaderState();
}

class _UserHeaderState extends ConsumerState<UserHeader> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
            height: 44,
          child: Lottie.network(
              'https://lottie.host/47684b35-7638-4148-8782-80a7bc9e7fab/xNg4fR6Prv.json'),
        ),
        Row(
          children: [
            Icon(
              Icons.search_rounded,
              size: 24,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            const SizedBox(width: 20),
            Icon(
              Icons.notifications_none_rounded,
              size: 24,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            const SizedBox(width: 20),
            GestureDetector(
              onTap: () {
                ref.read(loginControllerProvider.notifier).signOut();
              },
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Theme.of(context).colorScheme.onPrimary,
                    child: Icon(
                      Icons.person_rounded,
                      size: 24,
                      color: Theme.of(context).colorScheme.background,
                    ),
                  ),
                  Icon(
                    Icons.logout_outlined,
                    size: 30,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
