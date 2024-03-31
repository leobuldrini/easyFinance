import 'package:easyFinance/core/models/transaction.dart';
import 'package:easyFinance/core/services/transactions_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TransactionsRepository {
  final TransactionsService _transactionsService;

  TransactionsRepository(this._transactionsService);

  Future<List<Transaction>> getTransactions() async {
    return await _transactionsService.getTransactions();
  }
}

final transactionsRepositoryProvider = Provider<TransactionsRepository>((ref) {
  return TransactionsRepository(ref.read(transactionsServiceProvider));
});
