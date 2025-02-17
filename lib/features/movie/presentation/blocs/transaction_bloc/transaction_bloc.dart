import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:screenify/core/datasource/data_state.dart';
import 'package:screenify/features/movie/domain/entities/transaction.dart';
import 'package:screenify/features/movie/domain/repository/transaction_repository.dart';
import 'package:screenify/features/movie/domain/usecases/create_transaction_usecase.dart';

part 'transaction_event.dart';

part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepository _transactionRepository =
      GetIt.I<TransactionRepository>();

  TransactionBloc() : super(const TransactionInitial()) {
    on<CreateTransactionEvent>(_onCreateTransaction);
  }

  FutureOr<void> _onCreateTransaction(
    CreateTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit(const TransactionLoading());
    final useCase =
        CreateTransactionUseCase(transactionRepository: _transactionRepository);
    final response = await useCase(
      param: CreateTransactionUseCaseParam(transaction: event.transaction),
    );
    if (response is DataSuccess) {
      emit(TransactionLoaded(transaction: response.data!));
    } else {
      emit(
        TransactionFailed(message: response.message ?? "Unknown bloc error"),
      );
    }
  }
}
