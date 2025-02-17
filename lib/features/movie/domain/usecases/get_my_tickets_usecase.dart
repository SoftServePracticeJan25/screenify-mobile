import 'package:screenify/core/datasource/data_state.dart';
import 'package:screenify/core/usecase/usecase.dart';
import 'package:screenify/features/movie/domain/entities/ticket.dart';
import 'package:screenify/features/movie/domain/repository/ticket_repository.dart';

class GetMyTicketsUseCase
    implements
        UseCase<Future<DataState<List<Ticket>>>, GetMyTicketsUseCaseParam> {
  final TicketRepository ticketRepository;

  GetMyTicketsUseCase({required this.ticketRepository});

  @override
  Future<DataState<List<Ticket>>> call({
    required GetMyTicketsUseCaseParam param,
  }) async {
    return await ticketRepository.getMyTickets();
  }
}

interface class GetMyTicketsUseCaseParam {}
