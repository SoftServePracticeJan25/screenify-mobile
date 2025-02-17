import 'dart:convert';

import 'package:http/http.dart';
import 'package:screenify/core/datasource/data_state.dart';
import 'package:screenify/features/movie/data/mappers/ticket_mapper.dart';
import 'package:screenify/features/movie/data/models/ticket_model.dart';
import 'package:screenify/features/movie/data/services/secure_storage_service.dart';
import 'package:screenify/features/movie/domain/entities/ticket.dart';
import 'package:screenify/features/movie/domain/repository/ticket_repository.dart';

class TicketRepositoryImpl implements TicketRepository {
  final Client client;

  const TicketRepositoryImpl({required this.client});

  static const String _baseUrl = String.fromEnvironment('BASE_URL');
  final String _ticketUrl = '$_baseUrl/api/ticket';

  @override
  Future<DataState<List<Ticket>>> getMyTickets() async {
    try {
      final service = SecureStorageService();
      final token = await service.readToken();
      final url = Uri.parse('$_ticketUrl/my-tickets');
      final response = await client.get(
        url,
        headers: {
          'Authorization': "Bearer $token",
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode >= 200 && response.statusCode <= 300) {
        final tickets =
            TicketModel.toJsonList(jsonDecode(response.body) as List<dynamic>)
                .map(
                  (e) => TicketMapper.toEntity(e),
                )
                .toList();
        return DataSuccess(tickets);
      } else {
        return DataFailure(response.reasonPhrase ?? "Unknown error");
      }
    } catch (e) {
      return DataFailure(e.toString());
    }
  }

  @override
  Future<DataState<Ticket>> creteTicket({
    required int seatNum,
    required int transactionId,
    required int sessionId,
  }) async {
    try {
      final service = SecureStorageService();
      final token = await service.readToken();
      final url = Uri.parse(_ticketUrl);
      print(jsonEncode({
        'seatNum': seatNum,
        'transactionId': transactionId,
        'sessionId': sessionId,
      }),);
      final response = await client.post(
        url,
        headers: {
          'Authorization': "Bearer $token",
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'seatNum': seatNum,
          'transactionId': transactionId,
          'sessionId': sessionId,
        }),
      );
      print(response.body);
      if (response.statusCode >= 200 && response.statusCode <= 300) {
        return DataSuccess(
          TicketMapper.toEntity(
            TicketModel.fromJson(
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
