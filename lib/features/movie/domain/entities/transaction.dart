import 'package:equatable/equatable.dart';

class Transaction extends Equatable {
  final int id;
  final int sum;
  final DateTime creationTime;
  final String appUserId;

  const Transaction({
    required this.id,
    required this.sum,
    required this.creationTime,
    required this.appUserId,
  });

  @override
  List<Object?> get props => [id, sum, creationTime, appUserId];
}
