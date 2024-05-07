import 'package:easyFinance/core/models/transaction.dart';
import 'package:easyFinance/core/providers/supabase_provider.dart';
import 'package:easyFinance/core/repositories/transactions_repository.dart';
import 'package:easyFinance/core/states/transaction_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sqflite/sqflite.dart' as sql;

class TransactionController extends StateNotifier<TransactionState> {
  TransactionController(this.ref) : super(const TransactionStateInitial());

  final Ref ref;

  Future<List<Transaction>> getTransactions() async {
    state = const TransactionStateLoading();
    List<Transaction> result;
    try {
      result = await ref.read(transactionsRepositoryProvider).getTransactions();
      state = const TransactionStateSuccess();
    } catch (e) {
      state = TransactionStateError(e.toString());
      result = [];
    }
    return result;
  }

  Future<void> addTransaction(
      double value, bool income, String category, String title) async {
    state = const TransactionStateLoading();
    try {
      await ref
          .read(transactionsRepositoryProvider)
          .addTransaction(value, income, category, title);
      state = const TransactionStateSuccess();
    } catch (e) {
      state = TransactionStateError(e.toString());
    }
  }

  Future<void> insertUserSector(Map<String, dynamic> sector) async {
    // Get a reference to the database.
    final db = await ref.read(sqliteClientProvider.notifier).state!;

    // In this case, replace any previous data.
    await db.insert(
      'user_sectors',
      sector,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  Future<List<String>> retrieveUserSectors(bool income) async {
    state = const TransactionStateLoading();
    final db = await ref.read(sqliteClientProvider.notifier).state!;
    // Query the table for all the dogs.
    final List<Map<String, Object?>> sectorMaps =
        await db.query('user_sectors');

    // Convert the list of each dog's fields into a list of `Dog` objects.
    final finalList = <String>[];
    for (final sector in sectorMaps) {
      if (sector['income'] == income) {
        finalList.add(sector['name'] as String);
      }
    }
    state = const TransactionStateSuccess();
    return finalList;
  }
}

final transactionControllerProvider =
    StateNotifierProvider<TransactionController, TransactionState>((ref) {
  return TransactionController(ref);
});

