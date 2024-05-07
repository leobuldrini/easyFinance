import 'package:easyFinance/core/models/transaction.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/supabase_provider.dart';

class TransactionsService {
  final Ref _ref;
  Future<List<Transaction>> getTransactions() async {
    final supabaseClient = _ref.read(supabaseClientProvider);
    final response = await supabaseClient!.from('transactions').select();
    final transactions = response.map((e) => Transaction.fromJson(e)).toList();

    // order from newest to oldest
    transactions.sort((a, b) => b.date.compareTo(a.date));
    return transactions;
  }

  TransactionsService(this._ref);

  Future<bool> addTransaction(double value, bool income, String category, String title) async {
    late final response;
    try {
      final supabaseClient = _ref.read(supabaseClientProvider);
      final account = await supabaseClient?.from('accounts').select();
      final accountId = account?[0]['id'];
      response = await supabaseClient!.from('transactions').insert(
          {
            'value': value,
            'created_at': DateTime.now().toIso8601String(),
            'income': income,
            'account_id': (accountId ?? 3),
            'category': category,
            'title': title,
          }
      );
    } catch (e) {
      print('error: $e');
      return false;
    }
    print('response: $response');
    return response.error == null;
  }
}

final transactionsServiceProvider = Provider<TransactionsService>((ref) => TransactionsService(ref));