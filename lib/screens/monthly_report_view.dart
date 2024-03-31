import 'package:easyFinance/widgets/user_header.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MonthlyReportScreen extends StatelessWidget {
  const MonthlyReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
        child: Column(
          children: [
            const UserHeader(),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'monthly report.',
                      softWrap: true,
                      style: GoogleFonts.getFont(
                        'Montserrat',
                        textStyle: TextStyle(
                          fontSize: 56,
                          fontWeight: FontWeight.w600,
                          height: 0.8,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 10),
                    const Row(),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
