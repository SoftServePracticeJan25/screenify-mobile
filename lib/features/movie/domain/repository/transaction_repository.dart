import 'package:screenify/core/datasource/data_state.dart';
import 'package:screenify/features/movie/domain/entities/transaction.dart';

abstract class TransactionRepository {
  Future<DataState<Transaction>> createTransaction(Transaction transaction);
}
