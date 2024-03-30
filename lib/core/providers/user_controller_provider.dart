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

final recentTransactionsFutureProvider = FutureProvider.autoDispose<List<Map<String,dynamic>>>((ref) async {
  await Future.delayed(const Duration(seconds: 1));
  return [
    {
      'id': 1,
      'title': 'Netflix',
      'value': 22.50,
      'date': '2021-09-01',
    },
    {
      'id': 2,
      'title': 'Spotify',
      'value': 16.90,
      'date': '2021-09-02',
    },
    {
      'id': 3,
      'title': 'Amazon',
      'value': 100.00,
      'date': '2021-09-03',
    },
    {
      'id': 4,
      'title': 'Apple',
      'value': 50.00,
      'date': '2021-09-04',
    },
    {
      'id': 5,
      'title': 'Google',
      'value': 30.00,
      'date': '2021-09-05',
    },
    {
      'id': 1,
      'title': 'Netflix',
      'value': 22.50,
      'date': '2021-09-01',
    },
    {
      'id': 2,
      'title': 'Spotify',
      'value': 16.90,
      'date': '2021-09-02',
    },
    {
      'id': 3,
      'title': 'Amazon',
      'value': 100.00,
      'date': '2021-09-03',
    },
    {
      'id': 4,
      'title': 'Apple',
      'value': 50.00,
      'date': '2021-09-04',
    },
    {
      'id': 5,
      'title': 'Google',
      'value': 30.00,
      'date': '2021-09-05',
    },
  ];
});