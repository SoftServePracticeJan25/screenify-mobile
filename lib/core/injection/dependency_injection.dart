import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:screenify/features/movie/data/repository/auth_repository_impl.dart';
import 'package:screenify/features/movie/data/services/secure_storage_service.dart';
import 'package:screenify/features/movie/domain/repository/auth_repository.dart';

void injectDependencies() {
  GetIt.I.registerSingleton<Client>(Client());
  registerServices();
  GetIt.I.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(client: GetIt.I<Client>()),
  );
}

void registerServices(){
  if (!GetIt.instance.isRegistered<SecureStorageService>()) {
    GetIt.instance.registerSingleton(SecureStorageService());
  }
}
