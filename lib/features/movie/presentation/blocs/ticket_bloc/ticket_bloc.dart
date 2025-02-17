import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:screenify/core/datasource/data_state.dart';
import 'package:screenify/features/movie/domain/entities/ticket.dart';
import 'package:screenify/features/movie/domain/repository/ticket_repository.dart';
import 'package:screenify/features/movie/domain/usecases/create_ticket_usecase.dart';
import 'package:screenify/features/movie/domain/usecases/get_my_tickets_usecase.dart';

part 'ticket_event.dart';

part 'ticket_state.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  final TicketRepository _ticketRepository = GetIt.I<TicketRepository>();

  TicketBloc() : super(const TicketInitial()) {
    on<GetMyTicketsEvent>(_onGetMyTickets);
    on<CreateTicketEvent>(_onCreateTicket);
  }

  FutureOr<void> _onCreateTicket(
    CreateTicketEvent event,
    Emitter<TicketState> emit,
  ) async {
    final ticketsList = (state as TicketLoaded).tickets;
    emit(const TicketLoading());
    final useCase = CreateTicketUseCase(ticketRepository: _ticketRepository);
    final response = await useCase(
      param: CreateTicketUseCaseParam(
        seatNum: event.seatNum,
        sessionId: event.sessionId,
        transactionId: event.transactionId,
      ),
    );
    if (response is DataSuccess) {
      emit(const TicketBought());
      ticketsList.add(response.data!);
      emit(TicketLoaded(tickets: ticketsList));
    } else {

      emit(TicketFailed(message: response.message ?? "Unknown bloc error"));
    }
  }

  FutureOr<void> _onGetMyTickets(
    GetMyTicketsEvent event,
    Emitter<TicketState> emit,
  ) async {
    emit(const TicketLoading());
    final useCase = GetMyTicketsUseCase(ticketRepository: _ticketRepository);
    final response = await useCase(param: GetMyTicketsUseCaseParam());
    if (response is DataSuccess) {
      emit(TicketLoaded(tickets: response.data!));
    } else {

      emit(TicketFailed(message: response.message ?? "Unknown bloc message"));
    }
  }
}
