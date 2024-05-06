import 'package:easyFinance/core/models/transaction.dart';
import 'package:easyFinance/core/services/transactions_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TransactionsRepository {
  final TransactionsService _transactionsService;

  TransactionsRepository(this._transactionsService);

  Future<List<Transaction>> getTransactions() async {
    return await _transactionsService.getTransactions();
  }

  Future<bool> addTransaction(double value, bool income, String category, String title) async {
    return await _transactionsService.addTransaction(value, income, category, title);
  }
}

final transactionsRepositoryProvider = Provider<TransactionsRepository>((ref) {
  return TransactionsRepository(ref.read(transactionsServiceProvider));
});
