part of 'transaction_bloc.dart';

sealed class TransactionState extends Equatable {
  const TransactionState();
}

final class TransactionInitial extends TransactionState {
  const TransactionInitial();

  @override
  List<Object> get props => [];
}

final class TransactionLoading extends TransactionState {
  const TransactionLoading();

  @override
  List<Object?> get props => [];
}

final class TransactionFailed extends TransactionState {
  final String message;

  const TransactionFailed({required this.message});

  @override
  List<Object?> get props => [message];
}

final class TransactionLoaded extends TransactionState {
  final Transaction transaction;

  const TransactionLoaded({required this.transaction});

  @override
  List<Object?> get props => [transaction];
}
