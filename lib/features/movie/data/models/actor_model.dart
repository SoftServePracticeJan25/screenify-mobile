import 'package:equatable/equatable.dart';

class ActorModel extends Equatable {
  final String actorName;
  final String? bio;
  final String birthdate;
  final String photoUrl;

  const ActorModel({
    required this.actorName,
    required this.bio,
    required this.birthdate,
    required this.photoUrl,
  });

  factory ActorModel.fromJson(Map<String, dynamic> json) {
    return ActorModel(
      actorName: json['name'],
      bio: json['bio'],
      birthdate: json['birthDate'],
      photoUrl: json['photoUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "actorName": actorName,
      'bio': bio,
      'birthdate': birthdate,
      'photoUrl': photoUrl,
    };
  }

  @override
  List<Object?> get props => [actorName, bio, birthdate, photoUrl];
}
