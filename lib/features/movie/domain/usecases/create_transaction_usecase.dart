import 'package:screenify/core/datasource/data_state.dart';
import 'package:screenify/core/usecase/usecase.dart';
import 'package:screenify/features/movie/domain/entities/transaction.dart';
import 'package:screenify/features/movie/domain/repository/transaction_repository.dart';

class CreateTransactionUseCase
    implements
        UseCase<Future<DataState<Transaction>>, CreateTransactionUseCaseParam> {
  final TransactionRepository transactionRepository;

  const CreateTransactionUseCase({required this.transactionRepository});

  @override
  Future<DataState<Transaction>> call({
    required CreateTransactionUseCaseParam param,
  }) async {
    return await transactionRepository.createTransaction(param.transaction);
  }
}

interface class CreateTransactionUseCaseParam {
  final Transaction transaction;

  CreateTransactionUseCaseParam({required this.transaction});
}
