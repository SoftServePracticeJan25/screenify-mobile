import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:screenify/features/movie/data/repository/auth_repository_impl.dart';
import 'package:screenify/features/movie/data/repository/movie_repository_impl.dart';
import 'package:screenify/features/movie/data/repository/review_repository_impl.dart';
import 'package:screenify/features/movie/data/repository/room_repository_impl.dart';
import 'package:screenify/features/movie/data/repository/session_repository_impl.dart';
import 'package:screenify/features/movie/data/repository/ticket_repository_impl.dart';
import 'package:screenify/features/movie/data/repository/transaction_repository_impl.dart';
import 'package:screenify/features/movie/data/services/secure_storage_service.dart';
import 'package:screenify/features/movie/domain/repository/auth_repository.dart';
import 'package:screenify/features/movie/domain/repository/movie_repository.dart';
import 'package:screenify/features/movie/domain/repository/review_repository.dart';
import 'package:screenify/features/movie/domain/repository/room_repository.dart';
import 'package:screenify/features/movie/domain/repository/session_repository.dart';
import 'package:screenify/features/movie/domain/repository/ticket_repository.dart';
import 'package:screenify/features/movie/domain/repository/transaction_repository.dart';

class DependencyInjection {
  const DependencyInjection();

  void injectDependencies() {
    GetIt.I.registerSingleton<Client>(Client());
    _registerServices();
    _registerRepositories();
  }

  void _registerServices() {
    if (!GetIt.instance.isRegistered<SecureStorageService>()) {
      GetIt.instance.registerSingleton(SecureStorageService());
    }
  }

  void _registerRepositories() {
    GetIt.I.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(client: GetIt.I<Client>()),
    );
    GetIt.I.registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(client: GetIt.I<Client>()),
    );
    GetIt.I.registerLazySingleton<ReviewRepository>(
      () => ReviewRepositoryImpl(client: GetIt.I<Client>()),
    );
    GetIt.I.registerLazySingleton<SessionRepository>(
      () => SessionRepositoryImpl(client: GetIt.I<Client>()),
    );
    GetIt.I.registerLazySingleton<RoomRepository>(
      () => RoomRepositoryImpl(client: GetIt.I<Client>()),
    );
    GetIt.I.registerLazySingleton<TransactionRepository>(
      () => TransactionRepositoryImpl(client: GetIt.I<Client>()),
    );
    GetIt.I.registerLazySingleton<TicketRepository>(
      () => TicketRepositoryImpl(client: GetIt.I<Client>()),
    );
  }
}
