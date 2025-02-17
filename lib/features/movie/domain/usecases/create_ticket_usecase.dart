import 'package:screenify/core/datasource/data_state.dart';
import 'package:screenify/core/usecase/usecase.dart';
import 'package:screenify/features/movie/domain/entities/ticket.dart';
import 'package:screenify/features/movie/domain/repository/ticket_repository.dart';

class CreateTicketUseCase
    implements UseCase<Future<DataState<Ticket>>, CreateTicketUseCaseParam> {
  final TicketRepository ticketRepository;

  const CreateTicketUseCase({required this.ticketRepository});

  @override
  Future<DataState<Ticket>> call({
    required CreateTicketUseCaseParam param,
  }) async {
    return await ticketRepository.creteTicket(
      seatNum: param.seatNum,
      transactionId: param.transactionId,
      sessionId: param.sessionId,
    );
  }
}

interface class CreateTicketUseCaseParam {
  final int seatNum;
  final int sessionId;
  final int transactionId;

  const CreateTicketUseCaseParam({
    required this.seatNum,
    required this.sessionId,
    required this.transactionId,
  });
}
