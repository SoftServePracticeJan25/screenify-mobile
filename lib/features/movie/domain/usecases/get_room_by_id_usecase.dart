import 'package:screenify/core/datasource/data_state.dart';
import 'package:screenify/core/usecase/usecase.dart';
import 'package:screenify/features/movie/domain/entities/room.dart';
import 'package:screenify/features/movie/domain/repository/room_repository.dart';

class GetRoomByIdUseCase implements UseCase<Future<DataState<Room>>, GetRoomByIdUseCaseParam>{
  final RoomRepository roomRepository;

  GetRoomByIdUseCase({required this.roomRepository});

  @override
  Future<DataState<Room>> call({required GetRoomByIdUseCaseParam param}) async{
    return await roomRepository.getById(param.roomId);
  }
}

interface class GetRoomByIdUseCaseParam{
  final int roomId;

  GetRoomByIdUseCaseParam({required this.roomId});
}