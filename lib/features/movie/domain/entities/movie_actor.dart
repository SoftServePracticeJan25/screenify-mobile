import 'package:equatable/equatable.dart';
import 'package:screenify/features/movie/domain/entities/actor.dart';

class MovieActor extends Equatable {
  final Actor actor;
  final String roleName;
  final String characterName;

  const MovieActor({
    required this.actor,
    required this.roleName,
    required this.characterName,
  });

  @override
  List<Object?> get props => [actor, roleName, characterName];
}
