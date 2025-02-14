import 'package:equatable/equatable.dart';
import 'package:screenify/features/movie/data/models/actor_model.dart';

class MovieActorModel extends Equatable {
  final ActorModel actorModel;
  final String roleName;
  final String characterName;

  const MovieActorModel({
    required this.actorModel,
    required this.roleName,
    required this.characterName,
  });

  Map<String, dynamic> toJson() {
    return {
      "actor": actorModel.toJson(),
      "roleName": roleName,
      "characterName": characterName,
    };
  }

  @override
  List<Object?> get props => [actorModel, roleName, characterName];

  factory MovieActorModel.fromJson(Map<String, dynamic> json) {
    return MovieActorModel(
      actorModel: ActorModel.fromJson(json['actor']),
      roleName: json['roleName']['roleName'] as String,
      characterName: json['characterName'],
    );
  }
}
