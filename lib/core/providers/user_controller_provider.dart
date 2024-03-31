import 'package:easyFinance/core/models/transaction.dart';
import 'package:easyFinance/core/models/user.dart';
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
  await Future.delayed(const Duration(seconds: 1));
  return [
    Transaction(
      id: '1',
      title: 'Teste',
      amount: 100.00,
      date: DateTime.now(),
      sector: 'Teste',
    ),
    Transaction(
      id: '2',
      title: 'Teste',
      amount: 100.00,
      date: DateTime.now(),
      sector: 'Teste',
    ),
    Transaction(
      id: '3',
      title: 'Teste',
      amount: 100.00,
      date: DateTime.now(),
      sector: 'Teste',
    ),
    Transaction(
      id: '4',
      title: 'Teste',
      amount: 100.00,
      date: DateTime.now(),
      sector: 'Teste',
    ),
    Transaction(
      id: '5',
      title: 'Teste',
      amount: 100.00,
      date: DateTime.now(),
      sector: 'Teste',
    ),
    Transaction(
      id: '1',
      title: 'Teste',
      amount: 100.00,
      date: DateTime.now(),
      sector: 'Teste',
    ),
    Transaction(
      id: '2',
      title: 'Teste',
      amount: 100.00,
      date: DateTime.now(),
      sector: 'Teste',
    ),
    Transaction(
      id: '3',
      title: 'Teste',
      amount: 100.00,
      date: DateTime.now(),
      sector: 'Teste',
    ),
    Transaction(
      id: '4',
      title: 'Teste',
      amount: 100.00,
      date: DateTime.now(),
      sector: 'Teste',
    ),
    Transaction(
      id: '5',
      title: 'Teste',
      amount: 100.00,
      date: DateTime.now(),
      sector: 'Teste',
    ),
  ];
});