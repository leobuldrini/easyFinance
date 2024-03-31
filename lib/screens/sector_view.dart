import 'package:easyFinance/core/models/transaction.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/user_header.dart';

class SectorPage extends StatefulWidget {
  const SectorPage({super.key});

  @override
  State<SectorPage> createState() => _SectorPageState();
}

class _SectorPageState extends State<SectorPage> {
  List<Transaction>? source;

  @override
  void initState() {
    source = [
      Transaction(
        id: '2',
        title: 'Teste 1',
        amount: 140,
        date: DateTime.now(),
        sector: 'Technology',
      ),
      Transaction(
        id: '1',
        title: 'Teste 2',
        amount: 75,
        date: DateTime.now(),
        sector: 'Finance',
      ),
      Transaction(
        id: '4',
        title: 'Teste 3',
        amount: 123,
        date: DateTime.now(),
        sector: 'Retail',
      ),
      Transaction(
        id: '5',
        title: 'Teste 4',
        amount: 130,
        date: DateTime.now(),
        sector: 'Finance',
      ),
      Transaction(
        id: '3',
        title: 'Teste 5',
        amount: 87,
        date: DateTime.now(),
        sector: 'Retail',
      ),
      Transaction(
        id: '2',
        title: 'Teste 6',
        amount: 74,
        date: DateTime.now(),
        sector: 'Finance',
      ),
      Transaction(
        id: '1',
        title: 'Teste 7',
        amount: 122,
        date: DateTime.now(),
        sector: 'Utilities',
      ),
      Transaction(
        id: '4',
        title: 'Teste 8',
        amount: 93,
        date: DateTime.now(),
        sector: 'Healthcare',
      ),
      Transaction(
        id: '5',
        title: 'Teste 9',
        amount: 55,
        date: DateTime.now(),
        sector: 'Technology',
      ),
      Transaction(
        id: '3',
        title: 'Teste 10',
        amount: 69,
        date: DateTime.now(),
        sector: 'Utilities',
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'sectors.',
                        style: GoogleFonts.getFont(
                          'Montserrat',
                          textStyle: const TextStyle(fontSize: 56, fontWeight: FontWeight.w600),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: SizedBox(
                          height: 300,
                          width: 300,
                          child: SectorPieChart(source: source!),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TransactionsPerSection(source: source!),
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
      if (sectors.containsKey(transaction.sector)) {
        sectors[transaction.sector]['amount'] += transaction.amount;
        sectors[transaction.sector]['transactions'].add(transaction);
        sectors[transaction.sector]['percentage'] =
            (sectors[transaction.sector]['amount'] / source.map((e) => e.amount).reduce((value, element) => value + element) * 100).toStringAsFixed(2);
      } else {
        sectors[transaction.sector] = {
          'amount': transaction.amount,
          'transactions': [transaction],
          'percentage': (transaction.amount / source.map((e) => e.amount).reduce((value, element) => value + element) * 100).toStringAsFixed(2),
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
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            Text(
              '${sectors[sector]['percentage']}%',
              style: GoogleFonts.getFont(
                'Montserrat',
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
                textStyle: const TextStyle(fontSize: 13),
              ),
              textAlign: TextAlign.start,
            ),
          ),
        );
      }
      columnItems.add(const SizedBox(height: 20));
    }
    columnItems.removeLast();
    return Container(
      padding: const EdgeInsets.all(28),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.surface.withOpacity(0.3),
            offset: const Offset(0, 20),
            blurRadius: 20,
          ),
        ],
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

  @override
  Widget build(BuildContext context) {
    return PieChart(
      // swapAnimationDuration: const Duration(seconds: 1),
      swapAnimationCurve: Curves.easeInOut,
      PieChartData(
        pieTouchData: PieTouchData(
          touchCallback: (flTouchEvent, pieTouchResponse) {
            setState(() {
              if (flTouchEvent is FlLongPressEnd || flTouchEvent is FlPanEndEvent) {
                touchedIndex = -1;
              } else if (flTouchEvent is FlLongPressStart) {
                // if (touchedIndex == pieTouchResponse?.touchedSection?.touchedSectionIndex) {
                //   touchedIndex = -1;
                //   print('uai meu fi');
                // } else {
                touchedIndex = pieTouchResponse?.touchedSection?.touchedSectionIndex;
                // }
              }
            });
          },
          longPressDuration: const Duration(milliseconds: 10),
        ),
        centerSpaceRadius: 30,
        sections: [
          ...generateChartData(),
        ],
      ),
    );
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
    Map<String, dynamic> sectors = {};
    for (Transaction transaction in widget.source) {
      if (sectors.containsKey(transaction.sector)) {
        sectors[transaction.sector]['amount'] += transaction.amount;
        sectors[transaction.sector]['transactions'].add(transaction);
        sectors[transaction.sector]['percentage'] =
            (sectors[transaction.sector]['amount'] / widget.source.map((e) => e.amount).reduce((value, element) => value + element) * 100).toStringAsFixed(2);
      } else {
        sectors[transaction.sector] = {
          'amount': transaction.amount,
          'transactions': [transaction],
          'percentage': (transaction.amount / widget.source.map((e) => e.amount).reduce((value, element) => value + element) * 100).toStringAsFixed(2),
        };
      }
    }
    List<PieChartSectionData> data = [];
    int index = 0;
    for (String sector in sectors.keys) {
      data.add(
        PieChartSectionData(
          color: colors[index],
          value: sectors[sector]['amount'],
          title: index != touchedIndex ? sector : '${sectors[sector]['percentage']}%',
          radius: index == touchedIndex ? 120 : 100,
          titleStyle: GoogleFonts.getFont(
            'Montserrat',
            textStyle: const TextStyle(color: Color(0xffffffff), fontSize: 16),
          ),
        ),
      );
      index++;
    }
    return data;
  }
}
