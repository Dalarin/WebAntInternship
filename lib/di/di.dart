import 'package:dio/dio.dart';
import 'package:domain/domain.dart';
import 'package:data/data.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:webant_internship/resources/app_const.dart';

GetIt injection = GetIt.I;

Future<void> setDi() async {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: AppConst.apiUrl,
    ),
  );

  const storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  final securedStorage = SecuredStorageRepositoryImpl(storage);

  dio.interceptors.add(
    MiddlewareInterceptor(
      repository: securedStorage,
      refreshRepository: RefreshTokenRepositoryImpl(),
    ),
  );

  injection.registerLazySingleton<SharedPreferencesRepository>(
    () => securedStorage,
  );

  injection.registerLazySingleton<MediaRepository>(
    () => MediaRepositoryImpl(dio),
  );

  injection.registerLazySingleton<FirebaseRepository>(
    () => FirebaseRepositoryImpl(),
  );

  injection.registerLazySingleton<AuthenticateRepository>(
    () => AuthenticateRepositoryImpl(dio),
  );
  injection.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(dio: dio, repository: securedStorage),
  );
}
