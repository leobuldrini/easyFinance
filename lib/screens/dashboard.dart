import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:judge/widgets/user_header.dart';
import 'package:lottie/lottie.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const UserHeader(),
              const SizedBox(height: 20),
              Text(
                'dashboard.',
                style: GoogleFonts.getFont(
                  'Montserrat',
                  textStyle: const TextStyle(
                      fontSize: 56, fontWeight: FontWeight.w600),
                ),
                textAlign: TextAlign.center,
              ),
              Expanded(
                child: Center(
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: 200,
                          height: 200,
                          child: Lottie.network(
                            'https://lottie.host/13d2c1cd-8baf-4d3b-9e08-2ddc7ef40f35/q1EdwSkob1.json',
                          )),
                      const SizedBox(height: 20),
                      Text(
                        'Sem trasações recentes ;)',
                        style: GoogleFonts.getFont(
                          'Montserrat',
                          textStyle: TextStyle(
                              fontSize: 18, color: Colors.grey[300], fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
