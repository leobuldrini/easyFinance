import 'package:easyFinance/core/models/transaction.dart';
import 'package:easyFinance/core/providers/user_controller_provider.dart';
import 'package:easyFinance/widgets/recent_transaction.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easyFinance/widgets/user_header.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue recentTransactions = ref.watch(recentTransactionsFutureProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const UserHeader(),
              const SizedBox(height: 20),
              Expanded(
                // This makes the remaining content scrollable
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'dashboard.',
                        style: GoogleFonts.getFont(
                          'Montserrat',
                          textStyle: const TextStyle(fontSize: 56, fontWeight: FontWeight.w600),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'R\$${ref.read(userProvider).balance.toString()}',
                        style: GoogleFonts.getFont(
                          'Montserrat',
                          textStyle: const TextStyle(fontSize: 34, fontWeight: FontWeight.w600),
                        ),
                        textAlign: TextAlign.start,
                      ),
                      const Text('Total Balance', style: TextStyle(fontSize: 16, color: Colors.grey)),
                      const SizedBox(height: 20),
                      recentTransactions.when(
                        data: (data) {
                          List<Transaction> transactions = data;
                          return data.isEmpty
                              ? noTransactions()
                              : ListView.separated(
                                  itemCount: data.length,
                                  physics: const NeverScrollableScrollPhysics(), // Disables scrolling for the ListView
                                  shrinkWrap: true, // Allows the ListView to occupy space only for its children
                                  separatorBuilder: (context, index) => const SizedBox(
                                    height: 8,
                                  ),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      child: RecentTransactionTile(
                                        transaction: transactions[index],
                                      ),
                                    );
                                  },
                                );
                        },
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        error: (error, stack) => Text('Error: $error'),
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

  Widget noTransactions() {
    return Expanded(
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
                textStyle: TextStyle(fontSize: 18, color: Colors.grey[300], fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
