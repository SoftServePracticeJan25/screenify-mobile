part of 'ticket_bloc.dart';

sealed class TicketState extends Equatable {
  const TicketState();
}

final class TicketInitial extends TicketState {
  const TicketInitial();

  @override
  List<Object> get props => [];
}

final class TicketLoading extends TicketState {
  const TicketLoading();

  @override
  List<Object> get props => [];
}

final class TicketFailed extends TicketState {
  final String message;

  const TicketFailed({required this.message});

  @override
  List<Object> get props => [message];
}

final class TicketLoaded extends TicketState {
  final List<Ticket> tickets;

  const TicketLoaded({required this.tickets});

  @override
  List<Object> get props => [tickets];
}


final class TicketBought extends TicketState {
  const TicketBought();

  @override
  List<Object> get props => [];
}