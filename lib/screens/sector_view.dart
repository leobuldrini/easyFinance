import 'dart:math';

import 'package:easyFinance/core/models/transaction.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../widgets/user_header.dart';

class SectorPage extends ConsumerWidget {
  const SectorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                      const SizedBox(
                        height: 300,
                        width: 300,
                        child: SectorPieChart(),
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

class SectorPieChart extends StatefulWidget {
  const SectorPieChart({super.key});

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
    List<Transaction> source = [
      Transaction(
        id: '2',
        title: 'Teste',
        amount: 140,
        date: DateTime.now(),
        sector: 'Technology',
      ),
      Transaction(
        id: '1',
        title: 'Teste',
        amount: 75,
        date: DateTime.now(),
        sector: 'Finance',
      ),
      Transaction(
        id: '4',
        title: 'Teste',
        amount: 123,
        date: DateTime.now(),
        sector: 'Retail',
      ),
      Transaction(
        id: '5',
        title: 'Teste',
        amount: 130,
        date: DateTime.now(),
        sector: 'Finance',
      ),
      Transaction(
        id: '3',
        title: 'Teste',
        amount: 87,
        date: DateTime.now(),
        sector: 'Retail',
      ),
      Transaction(
        id: '2',
        title: 'Teste',
        amount: 74,
        date: DateTime.now(),
        sector: 'Finance',
      ),
      Transaction(
        id: '1',
        title: 'Teste',
        amount: 122,
        date: DateTime.now(),
        sector: 'Utilities',
      ),
      Transaction(
        id: '4',
        title: 'Teste',
        amount: 93,
        date: DateTime.now(),
        sector: 'Healthcare',
      ),
      Transaction(
        id: '5',
        title: 'Teste',
        amount: 55,
        date: DateTime.now(),
        sector: 'Technology',
      ),
      Transaction(
        id: '3',
        title: 'Teste',
        amount: 69,
        date: DateTime.now(),
        sector: 'Utilities',
      ),
    ];
    Map<String, dynamic> sectors = {};
    for (Transaction transaction in source) {
      if (sectors.containsKey(transaction.sector)) {
        sectors[transaction.sector]['amount'] += transaction.amount;
        sectors[transaction.sector]['transactions'].add(transaction);
      } else {
        sectors[transaction.sector] = {
          'amount': transaction.amount,
          'transactions': [transaction]
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
          title: index != touchedIndex
              ? sector
              : '${(sectors[sector]['amount'] / source.map((e) => e.amount).reduce((value, element) => value + element) * 100).toStringAsFixed(2)}%',
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
