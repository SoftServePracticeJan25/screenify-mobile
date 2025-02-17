import 'package:screenify/core/datasource/data_state.dart';
import 'package:screenify/features/movie/domain/entities/ticket.dart';

abstract class TicketRepository {
  Future<DataState<List<Ticket>>> getMyTickets();

  Future<DataState<Ticket>> creteTicket({
    required int seatNum,
    required int transactionId,
    required int sessionId,
  });
}
