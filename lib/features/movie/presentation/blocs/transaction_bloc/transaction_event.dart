part of 'transaction_bloc.dart';

sealed class TransactionEvent extends Equatable {
  const TransactionEvent();
}

class CreateTransactionEvent extends TransactionEvent {
  final Transaction transaction;
  const CreateTransactionEvent({required this.transaction});

  @override
  List<Object?> get props => [];
}
