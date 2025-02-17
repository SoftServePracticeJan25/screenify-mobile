import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:screenify/core/datasource/data_state.dart';
import 'package:screenify/features/movie/domain/entities/room.dart';
import 'package:screenify/features/movie/domain/repository/room_repository.dart';
import 'package:screenify/features/movie/domain/usecases/get_room_by_id_usecase.dart';

part 'room_event.dart';

part 'room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  final RoomRepository _roomRepository = GetIt.I<RoomRepository>();

  RoomBloc() : super(const RoomInitial()) {
    on<GetRoomByIdEvent>(_onGetRoomById);
  }

  FutureOr<void> _onGetRoomById(
    GetRoomByIdEvent event,
    Emitter<RoomState> emit,
  ) async {
    emit(const RoomLoading());
    final useCase = GetRoomByIdUseCase(roomRepository: _roomRepository);
    final response =
        await useCase(param: GetRoomByIdUseCaseParam(roomId: event.roomId));
    if (response is DataSuccess) {
      emit(RoomLoaded(room: response.data!));
    } else {
      emit(RoomFailed(message: response.message ?? "Unknown bloc error"));
    }
  }
}
