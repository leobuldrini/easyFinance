import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class UserHeader extends StatefulWidget {
  const UserHeader({super.key});

  @override
  State<UserHeader> createState() => _UserHeaderState();
}

class _UserHeaderState extends State<UserHeader> {
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
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 20),
            Icon(
              Icons.notifications_none_rounded,
              size: 24,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 20),
            GestureDetector(
              onTap: () {
                //print('User profile');
              },
              onLongPress: () {
                //print(User profile 2');
              },
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Theme.of(context).colorScheme.onPrimary,
                    child: Icon(
                      Icons.person_rounded,
                      size: 24,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    size: 24,
                    color: Theme.of(context).colorScheme.primary,
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
