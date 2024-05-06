import 'package:easyFinance/core/models/transaction.dart';
import 'package:easyFinance/core/repositories/transactions_repository.dart';
import 'package:easyFinance/core/states/transaction_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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

  Future<void> addTransaction(double value, bool income, String category, String title) async {
    state = const TransactionStateLoading();
    try {
      await ref.read(transactionsRepositoryProvider).addTransaction(value, income, category, title);
      state = const TransactionStateSuccess();
    } catch (e) {
      state = TransactionStateError(e.toString());
    }

  }
}

final transactionControllerProvider = StateNotifierProvider<TransactionController, TransactionState>((ref) {
  return TransactionController(ref);
});