import 'package:easyFinance/core/models/transaction.dart';
import 'package:easyFinance/core/providers/transaction_controller_provider.dart';
import 'package:easyFinance/core/providers/user_controller_provider.dart';
import 'package:easyFinance/misc/utilities.dart';
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
                            currencyFormatter.format(userBalance),
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
                      Align(
                        alignment: Alignment.center,
                        child: TextButton(
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
                                  List<String> categories = [
                                    'Food',
                                    'Transport',
                                    'Health',
                                    'Education',
                                    'Entertainment',
                                    'Salary',
                                    'Investment',
                                    'Other',
                                  ];
                                  List<String> titles = [
                                    'Lunch',
                                    'Dinner',
                                    'Breakfast',
                                    'Bus',
                                    'Train',
                                    'Plane',
                                    'Medicine',
                                    'Doctor',
                                    'Hospital',
                                    'School',
                                    'University',
                                    'Books',
                                    'Movies',
                                    'Games',
                                    'Salary',
                                    'Dividends',
                                    'Stocks',
                                    'Other',
                                  ];
                                  bool autocompleteReady = false;
                                  recentTransactions.when(
                                    data: (data) {
                                      List<Transaction> transactions = data;
                                      for (int i = 0; i < transactions.length; i++) {
                                        if (categories.contains(transactions[i].sector) == false) {
                                          categories.add(transactions[i].sector);
                                        }
                                        if (titles.contains(transactions[i].title) == false) {
                                          titles.add(transactions[i].title);
                                        }
                                      }
                                      autocompleteReady = true;
                                    },
                                    error: (error, stack) => const Text('Failed to load Total Balance'),
                                    loading: () => const CircularProgressIndicator(),
                                  );

                                  TextEditingController valueController = TextEditingController();
                                  TextEditingController categoryController = TextEditingController();
                                  TextEditingController titleController = TextEditingController();
                                  valueController.text = '';
                                  categoryController.text = '';
                                  titleController.text = '';

                                  return AlertDialog(
                                    title: const Text('Add Transaction'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        FutureBuilder(
                                          future: Future.doWhile(() => autocompleteReady == false),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState == ConnectionState.done) {
                                              return Column(
                                                children: [
                                                  TextField(
                                                    controller: valueController,
                                                    decoration: const InputDecoration(
                                                      labelText: 'Value',
                                                    ),
                                                  ),
                                                  TextField(
                                                    controller: categoryController,
                                                    decoration: const InputDecoration(
                                                      labelText: 'Category',
                                                    ),
                                                    onTap: () {
                                                      showSearch(
                                                        context: context,
                                                        delegate: _DataSearch(categories),
                                                      ).then((value) {
                                                        if (value != null) {
                                                          categoryController.text = value;
                                                        }
                                                      });
                                                    },
                                                  ),
                                                  TextField(
                                                    controller: titleController,
                                                    decoration: const InputDecoration(
                                                      labelText: 'Title',
                                                    ),
                                                    onTap: () {
                                                      showSearch(
                                                        context: context,
                                                        delegate: _DataSearch(titles),
                                                      ).then((value) {
                                                        if (value != null) {
                                                          titleController.text = value;
                                                        }
                                                      });
                                                    },
                                                  ),
                                                ],
                                              );
                                            } else {
                                              return const CircularProgressIndicator();
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          String valueString = valueController.text.isNotEmpty ? valueController.text : '0';
                                          double value = double.parse(valueString);
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
                                        child: const Text('Add'),
                                      ),
                                    ],
                                  );
                                }
                            );
                          },
                          child: const Text(
                            'Add Transaction',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
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

class _DataSearch extends SearchDelegate<String> {
  final List<String> data;
  _DataSearch(this.data);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(data[index]),
          onTap: () {
            close(context, data[index]);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? data
        : data.where((element) => element.toLowerCase().startsWith(query.toLowerCase())).toList();
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestionList[index]),
          onTap: () {
            close(context, suggestionList[index]);
          },
        );
      },
    );
  }

}