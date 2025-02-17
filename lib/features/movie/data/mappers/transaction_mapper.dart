import 'package:screenify/features/movie/data/models/transaction_model.dart';
import 'package:screenify/features/movie/domain/entities/transaction.dart';

class TransactionMapper {
  const TransactionMapper._();

  static Transaction toEntity(TransactionModel model) {
    return Transaction(
      id: model.id,
      sum: model.sum.toInt(),
      creationTime: DateTime.parse(model.creationTime),
      appUserId: model.appUserId,
    );
  }

  static TransactionModel toModel(Transaction entity) {
    return TransactionModel(
      id: entity.id,
      sum: entity.sum.toDouble(),
      creationTime: entity.creationTime.toIso8601String(),
      appUserId: entity.appUserId,
    );
  }
}
