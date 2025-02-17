part of 'ticket_bloc.dart';

sealed class TicketEvent extends Equatable {
  const TicketEvent();
}

class GetMyTicketsEvent extends TicketEvent {
  const GetMyTicketsEvent();

  @override
  List<Object?> get props => [];
}

class CreateTicketEvent extends TicketEvent {
  final int seatNum;
  final int sessionId;
  final int transactionId;

  const CreateTicketEvent({
    required this.seatNum,
    required this.sessionId,
    required this.transactionId,
  });

  @override
  List<Object?> get props => [seatNum, sessionId, transactionId];
}
