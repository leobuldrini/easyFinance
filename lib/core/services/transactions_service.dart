import 'package:easyFinance/core/models/transaction.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TransactionsService {
  Future<List<Transaction>> getTransactions() async {
    // Fetch transactions from the API
    return [Transaction(
      id: '1',
      title: 'Teste',
      amount: 100.00,
      date: DateTime.now(),
      sector: 'Teste',
      transactionType: TransactionType.income,
    ),
      Transaction(
        id: '2',
        title: 'Teste',
        amount: 100.00,
        date: DateTime.now(),
        sector: 'Teste',
        transactionType: TransactionType.outcome,
      ),
      Transaction(
        id: '3',
        title: 'Teste',
        amount: 100.00,
        date: DateTime.now(),
        sector: 'Teste',
        transactionType: TransactionType.outcome,
      ),
      Transaction(
        id: '4',
        title: 'Teste',
        amount: 100.00,
        date: DateTime.now(),
        sector: 'Teste',
        transactionType: TransactionType.outcome,
      ),
      Transaction(
        id: '5',
        title: 'Teste',
        amount: 100.00,
        date: DateTime.now(),
        sector: 'Teste',
        transactionType: TransactionType.outcome,
      ),
      Transaction(
        id: '1',
        title: 'Teste',
        amount: 100.00,
        date: DateTime.now(),
        sector: 'Teste',
        transactionType: TransactionType.outcome,
      ),
      Transaction(
        id: '2',
        title: 'Teste',
        amount: 100.00,
        date: DateTime.now(),
        sector: 'Teste',
        transactionType: TransactionType.income,
      ),
      Transaction(
        id: '3',
        title: 'Teste',
        amount: 100.00,
        date: DateTime.now(),
        sector: 'Teste',
        transactionType: TransactionType.outcome,
      ),
      Transaction(
        id: '4',
        title: 'Teste',
        amount: 100.00,
        date: DateTime.now(),
        sector: 'Teste',
        transactionType: TransactionType.income,
      ),
      Transaction(
        id: '5',
        title: 'Teste',
        amount: 100.00,
        date: DateTime.now(),
        sector: 'Teste',
        transactionType: TransactionType.income,
      )];
  }
}

final transactionsServiceProvider = Provider<TransactionsService>((ref) => TransactionsService());