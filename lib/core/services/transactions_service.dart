import 'package:easyFinance/core/models/transaction.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/supabase_provider.dart';

class TransactionsService {
  final Ref _ref;
  Future<List<Transaction>> getTransactions() async {
    final supabaseClient = _ref.read(supabaseClientProvider);
    final response = await supabaseClient!.from('transactions').select();
    return response.map((e) => Transaction.fromJson(e)).toList();
  }

  TransactionsService(this._ref);
}

final transactionsServiceProvider = Provider<TransactionsService>((ref) => TransactionsService(ref));