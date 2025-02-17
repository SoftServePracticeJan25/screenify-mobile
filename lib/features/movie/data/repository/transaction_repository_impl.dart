import 'dart:convert';

import 'package:http/http.dart';
import 'package:screenify/core/datasource/data_state.dart';
import 'package:screenify/features/movie/data/mappers/transaction_mapper.dart';
import 'package:screenify/features/movie/data/models/transaction_model.dart';
import 'package:screenify/features/movie/data/services/secure_storage_service.dart';
import 'package:screenify/features/movie/domain/entities/transaction.dart';
import 'package:screenify/features/movie/domain/repository/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final Client client;

  const TransactionRepositoryImpl({required this.client});

  static const String _baseUrl = String.fromEnvironment('BASE_URL');
  final String _transactionUrl = '$_baseUrl/api/transaction';

  @override
  Future<DataState<Transaction>> createTransaction(
    Transaction transaction,
  ) async {
    try {
      final service = SecureStorageService();
      final token = await service.readToken();
      final url = Uri.parse(_transactionUrl);
      print(jsonEncode(
        TransactionMapper.toModel(transaction).toJson(),
      ));
      final response = await client.post(
        url,
        headers: {
          'Authorization': "Bearer $token",
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          TransactionMapper.toModel(transaction).toJson(),
        ),
      );
      if (response.statusCode >= 200 && response.statusCode <= 300) {
        print(jsonDecode(response.body));
        return DataSuccess(
          TransactionMapper.toEntity(
            TransactionModel.fromJson(
              jsonDecode(response.body) as Map<String, dynamic>,
            ),
          ),
        );
      } else {
        return DataFailure(response.reasonPhrase ?? "Unknown error");
      }
    } catch (e) {
      return DataFailure(e.toString());
    }
  }
}
