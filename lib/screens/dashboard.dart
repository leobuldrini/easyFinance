import 'package:easyFinance/core/models/transaction.dart';
import 'package:easyFinance/core/providers/transaction_controller_provider.dart';
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
    double userBalance = ref.read(userProvider).balance;
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
                      recentTransactions.when(
                        data: (data) {
                          List<Transaction> transactions = data;
                          for (int i = 0; i < transactions.length; i++) {
                            userBalance += (transactions[i].amount * (transactions[i].isIncome ? 1 : -1));
                          }
                          return Text(
                            'R\$ ${userBalance.toStringAsFixed(2)}',
                            style: GoogleFonts.getFont(
                              'Montserrat',
                              textStyle: const TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
                            ),
                          );
                        },
                        error: (error, stack) => const Text('Failed to load Total Balance'),
                        loading: () => const CircularProgressIndicator(),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.primary),
                              padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    TextEditingController valueController = TextEditingController();
                                    TextEditingController categoryController = TextEditingController();
                                    TextEditingController titleController = TextEditingController();
                                    valueController.text = '0';
                                    categoryController.text = '';
                                    titleController.text = '';

                                    return AlertDialog(
                                      title: const Text('Adicionar transação'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextField(
                                            controller: valueController,
                                            decoration: const InputDecoration(
                                              labelText: 'Valor',
                                            ),
                                          ),
                                          TextField(
                                            controller: categoryController,
                                            decoration: const InputDecoration(
                                              labelText: 'Categoria',
                                            ),
                                          ),
                                          TextField(
                                            controller: titleController,
                                            decoration: const InputDecoration(
                                              labelText: 'Título',
                                            ),
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Cancelar'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            double value = double.parse(valueController.text);
                                            bool income = value > 0;
                                            if (!income) {
                                              value = value.abs();
                                            }
                                            ref.read(transactionControllerProvider.notifier).addTransaction(value, income, categoryController.text, titleController.text)
                                            .then((value) {
                                              ref.refresh(recentTransactionsFutureProvider);
                                            });
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Adicionar'),
                                        ),
                                      ],
                                    );
                                  }
                              );
                            },
                            child: const Text(
                                'Adicionar transação',
                                style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
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
