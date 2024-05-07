import 'package:easyFinance/widgets/user_header.dart';
import 'package:flutter/material.dart';

class UserMenu extends StatefulWidget {
  const UserMenu({Key? key}) : super(key: key);

  @override
  UserMenuState createState() => UserMenuState();
}

class UserMenuState extends State<UserMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(12, 8, 12, 0),
          child: Column(
            children: [
              UserHeader(),
              SizedBox(height: 20),

            ],
          ),
        )
      ),
    );
  }
}
