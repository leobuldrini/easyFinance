import 'package:easyFinance/core/models/transaction.dart';
import 'package:easyFinance/core/providers/transaction_controller_provider.dart';
import 'package:easyFinance/widgets/user_header.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
                    const SizedBox(height: 20),
                    const MonthlyReportBody(),
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

class MonthlyReportBody extends ConsumerStatefulWidget {
  const MonthlyReportBody({super.key});

  @override
  ConsumerState<MonthlyReportBody> createState() => _MonthlyReportBodyState();
}

class _MonthlyReportBodyState extends ConsumerState<MonthlyReportBody> {
  late List<Transaction> transactions;

  @override
  void initState() {
    transactions = [];
    onScreenStart();
    super.initState();
  }

  void onScreenStart() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      transactions = await ref.read(transactionControllerProvider.notifier).getTransactions();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MonthBalance(transactions: transactions),
        const SizedBox(height: 20),
        MonthlyIncome(transactions: transactions),
        const SizedBox(height: 20),
        MonthlyOutcome(transactions: transactions),
        // const RecentTransactions(),
      ],
    );
  }
}

class MonthBalance extends StatelessWidget {
  const MonthBalance({required this.transactions, super.key});

  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    double balance = 0.0;
    for (var transaction in transactions) {
      balance += transaction.isIncome ? transaction.amount : -transaction.amount;
    }
    return Container(
      height: 75,
      padding: const EdgeInsets.fromLTRB(25, 20, 25, 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Balance',
            style: GoogleFonts.getFont(
              'Montserrat',
              textStyle: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'R\$${balance.toStringAsFixed(2)}',
            style: GoogleFonts.getFont(
              'Montserrat',
              textStyle: TextStyle(
                color: balance >= 0 ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.error,
                fontSize: 32,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MonthlyIncome extends StatelessWidget {
  const MonthlyIncome({super.key, required this.transactions});
  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    double balance = 0.0;
    List<Transaction> incomes = transactions.where((element) => element.isIncome).toList();
    for (var transaction in incomes) {
      balance += transaction.amount;
    }
    return Container(
      padding: const EdgeInsets.fromLTRB(25, 20, 25, 20),
      height: 190,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Incomes',
              style: GoogleFonts.getFont(
                'Montserrat',
                textStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'R\$${balance.toStringAsFixed(2)}',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: List.generate(incomes.length, (i) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text(
                      incomes[i].title,
                      style: GoogleFonts.getFont(
                        'Montserrat',
                        textStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Text(
                      'R\$${incomes[i].amount}',
                      style: GoogleFonts.getFont('Montserrat',
                          textStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                  ]),
                );
              }),
            ),
          ),
        )
      ]),
    );
  }
}

class MonthlyOutcome extends StatelessWidget {
  const MonthlyOutcome({super.key, required this.transactions});
  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    double balance = 0.0;
    List<Transaction> outcomes = transactions.where((element) => element.isOutcome).toList();
    for (var transaction in outcomes) {
      balance += transaction.amount;
    }
    return Container(
      padding: const EdgeInsets.fromLTRB(25, 20, 25, 20),
      constraints: const BoxConstraints(minHeight: 75, maxHeight: 190),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            'Outcomes',
            style: GoogleFonts.getFont(
              'Montserrat',
              textStyle: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'R\$${balance.toStringAsFixed(2)}',
            style: TextStyle(
              color: Theme.of(context).colorScheme.error,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          )
        ]),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: List.generate(outcomes.length, (i) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text(
                      outcomes[i].title,
                      style: GoogleFonts.getFont('Montserrat',
                          textStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                    Text(
                      'R\$${outcomes[i].amount}',
                      style: GoogleFonts.getFont('Montserrat',
                          textStyle: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                  ]),
                );
              }),
            ),
          ),
        ),
      ]),
    );
  }
}
