import 'package:equatable/equatable.dart';

class TransactionModel extends Equatable {
  final int id;
  final double sum;
  final String creationTime;
  final String appUserId;

  const TransactionModel({
    required this.id,
    required this.sum,
    required this.creationTime,
    required this.appUserId,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      sum: json['sum'],
      creationTime: json['creationTime'],
      appUserId: json['appUserId'],
    );
  }

  static List<TransactionModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((e) => TransactionModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sum': sum,
      'creationTime': creationTime,
      'appUserId': appUserId,
    };
  }

  @override
  List<Object?> get props => [id, sum, creationTime, appUserId];
}
