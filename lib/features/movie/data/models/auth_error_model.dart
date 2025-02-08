import 'dart:convert';

class AuthErrorModel {
  final String error;

  AuthErrorModel(this.error);

  factory AuthErrorModel.fromJson(String source) {
    final Map<String, dynamic> jsonData = json.decode(source);

    if (jsonData.containsKey('errors')) {
      final errors = jsonData['errors'] as Map<String, dynamic>;
      if (errors.isNotEmpty) {
        final firstErrorKey = errors.keys.first;
        final firstErrorList = errors[firstErrorKey];
        if (firstErrorList is List && firstErrorList.isNotEmpty) {
          return AuthErrorModel(firstErrorList.last);
        }
      }
    }

    return AuthErrorModel('An unknown error occurred.');
  }
}
