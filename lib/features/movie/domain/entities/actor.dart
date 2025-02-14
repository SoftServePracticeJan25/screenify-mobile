import 'package:equatable/equatable.dart';

class Actor extends Equatable {
  final String actorName;
  final String? bio;
  final String birthdate;
  final String photoUrl;

  const Actor({
    required this.actorName,
    required this.bio,
    required this.birthdate,
    required this.photoUrl,
  });

  @override
  List<Object?> get props => [actorName, bio, birthdate, photoUrl];
}
