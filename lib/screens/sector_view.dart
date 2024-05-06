import 'package:easyFinance/core/models/transaction.dart';
import 'package:easyFinance/core/providers/user_controller_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../widgets/user_header.dart';

class SectorPage extends ConsumerStatefulWidget {
  const SectorPage({super.key});

  @override
  ConsumerState<SectorPage> createState() => _SectorPageState();
}

class _SectorPageState extends ConsumerState<SectorPage> {
  List<Widget> source = [const SizedBox.shrink()];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AsyncValue transactions = ref.watch(recentTransactionsFutureProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                        'sectors.',
                        style: GoogleFonts.getFont(
                          'Montserrat',
                          textStyle: const TextStyle(
                              fontSize: 56, fontWeight: FontWeight.w600),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: SizedBox(
                          height: 300,
                          width: 300,
                          child: transactions.when(
                            data: (transactions) {
                              final List<Transaction> transactionsOutcome = [];
                              setState(() {
                                transactionsOutcome.clear();
                                for(Transaction t in transactions){
                                  if(t.isOutcome){
                                    transactionsOutcome.add(t);
                                  }
                                }
                                source.add(SectorPieChart(source: transactionsOutcome));
                              });
                            return source.last;
                          },
                          loading: () => const Center(
                            child: CircularProgressIndicator()),
                            error: (error, stack) => Text('Error: $error'),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      transactions.when(
                        data: (transactions) {
                          final List<Transaction> transactionsOutcome = [];

                          for(Transaction t in transactions){
                          if(t.isOutcome){
                            transactionsOutcome.add(t);
                          }
                        }
                          return TransactionsPerSection(source: transactionsOutcome);
                        },
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
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
}

class TransactionsPerSection extends StatelessWidget {
  const TransactionsPerSection({super.key, required this.source});

  final List<Transaction> source;

  @override
  Widget build(BuildContext context) {
    List<Widget> columnItems = [];
    Map<String, dynamic> sectors = {};
    for (Transaction transaction in source) {
      if (transaction.isIncome) {
        continue;
      }
      if (sectors.containsKey(transaction.sector)) {
        sectors[transaction.sector]['amount'] += transaction.amount;
        sectors[transaction.sector]['transactions'].add(transaction);
        sectors[transaction.sector]['percentage'] = (sectors[transaction.sector]
                    ['amount'] /
                source
                    .map((e) => e.amount)
                    .reduce((value, element) => value + element) *
                100)
            .toStringAsFixed(2);
      } else {
        sectors[transaction.sector] = {
          'amount': transaction.amount,
          'transactions': [transaction],
          'percentage': (transaction.amount /
                  source
                      .map((e) => e.amount)
                      .reduce((value, element) => value + element) *
                  100)
              .toStringAsFixed(2),
        };
      }
    }
    for (String sector in sectors.keys) {
      columnItems.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              sector,
              style: GoogleFonts.getFont(
                'Montserrat',
                textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface),
              ),
            ),
            Text(
              '${sectors[sector]['percentage']}%',
              style: GoogleFonts.getFont(
                'Montserrat',
                textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface),
              ),
            ),
          ],
        ),
      );
      for (int i = 0; i < sectors[sector]['transactions'].length; i++) {
        Transaction transaction = sectors[sector]['transactions'][i];
        columnItems.add(
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              transaction.title,
              style: GoogleFonts.getFont(
                'Montserrat',
                textStyle: TextStyle(
                    fontSize: 13,
                    color: Theme.of(context).colorScheme.onSurface),
              ),
              textAlign: TextAlign.start,
            ),
          ),
        );
      }
      columnItems.add(const SizedBox(height: 20));
    }
    if (columnItems.isNotEmpty) {
      columnItems.removeLast();
    }
    return Container(
      padding: const EdgeInsets.all(28),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: columnItems,
      ),
    );
  }
}

class SectorPieChart extends StatefulWidget {
  const SectorPieChart({super.key, required this.source});

  final List<Transaction> source;

  @override
  State<SectorPieChart> createState() => _SectorPieChartState();
}

class _SectorPieChartState extends State<SectorPieChart> {
  int? touchedIndex;

  late Map<String, dynamic> data;

  @override
  void initState() {
    data = fetchChartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PieChart(
      // swapAnimationDuration: const Duration(seconds: 1),
      // swapAnimationCurve: Curves.easeInOut,
      PieChartData(
        pieTouchData: PieTouchData(
          touchCallback: (flTouchEvent, pieTouchResponse) {
            setState(() {
              if (flTouchEvent is FlLongPressEnd ||
                  flTouchEvent is FlPanEndEvent) {
                touchedIndex = -1;
              } else if (flTouchEvent is FlLongPressStart) {
                touchedIndex =
                    pieTouchResponse?.touchedSection?.touchedSectionIndex;
              }
            });
          },
          longPressDuration: const Duration(milliseconds: 10),
        ),
        centerSpaceRadius: 30,
        sections: generateChartData(),
      ),
    );
  }

  Map<String, dynamic> fetchChartData() {
    Map<String, dynamic> sectors = {};
    for (Transaction transaction in widget.source) {
      if (transaction.isIncome) {
        continue;
      }
      if (sectors.containsKey(transaction.sector)) {
        sectors[transaction.sector]['amount'] += transaction.amount;
        sectors[transaction.sector]['transactions'].add(transaction);
        sectors[transaction.sector]['percentage'] = (sectors[transaction.sector]
                    ['amount'] /
                widget.source
                    .map((e) => e.amount)
                    .reduce((value, element) => value + element) *
                100)
            .toStringAsFixed(2);
      } else {
        sectors[transaction.sector] = {
          'amount': transaction.amount,
          'transactions': [transaction],
          'percentage': (transaction.amount /
                  widget.source
                      .map((e) => e.amount)
                      .reduce((value, element) => value + element) *
                  100)
              .toStringAsFixed(2),
        };
      }
    }
    return sectors;
  }

  List<PieChartSectionData> generateChartData() {
    List<Color> colors = [
      const Color(0xFF0000FF), // Blue
      const Color(0xFF00008B), // Dark blue
      const Color(0xFF556B2F), // Dark olive green
      const Color(0xFF2F4F4F), // Dark slate gray (also Dark slate grey)
      const Color(0xFF808080), // Grey
      const Color(0xFF778899), // Light slate grey
      const Color(0xFF00FF00), // Lime
      const Color(0xFF191970), // Midnight blue
      const Color(0xFF40E0D0), // Turquoise
    ];
    List<PieChartSectionData> sectors = [];
    int index = 0;
    for (String sector in data.keys) {
      sectors.add(
        PieChartSectionData(
          color: colors[index],
          value: data[sector]['amount'],
          title:
              index != touchedIndex ? sector : '${data[sector]['percentage']}%',
          radius: index == touchedIndex ? 120 : 100,
          titleStyle: GoogleFonts.getFont(
            'Montserrat',
            textStyle: const TextStyle(color: Color(0xffffffff), fontSize: 16),
          ),
        ),
      );
      index++;
    }
    return sectors;
  }
}
