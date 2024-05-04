import 'package:easyFinance/core/models/transaction.dart';
import 'package:easyFinance/core/models/user.dart';
import 'package:easyFinance/core/repositories/transactions_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userProvider = StateProvider<User>((ref) {
  return User(
    token: '1',
    name: 'John Doe',
    email: 'teste@teste.com',
    balance: 100.00,
  );
});

final recentTransactionsFutureProvider = FutureProvider.autoDispose<List<Transaction>>((ref) async {
  return ref.read(transactionsRepositoryProvider).getTransactions();
});