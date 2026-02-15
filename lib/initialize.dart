import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:i_cash/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:i_cash/features/auth/data/repositories/auth_repositories_impl.dart';
import 'package:i_cash/features/auth/domain/repositories/auth_repositories.dart';
import 'package:i_cash/features/auth/domain/usecases/auth_login.dart';
import 'package:i_cash/features/auth/domain/usecases/auth_read_login_data.dart';
import 'package:i_cash/features/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependecies() async {
  // firebase instances
  sl.registerLazySingleton(() => FirebaseDatabase.instance);
  sl.registerLazySingleton(() => FirebaseAuth.instance);

  // datasources
  sl.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(sl<FirebaseDatabase>(), sl<FirebaseAuth>()),
  );

  // usecases
  sl.registerLazySingleton(() => AuthLogin(sl()));
  sl.registerLazySingleton(() => AuthReadLoginData(sl()));

  // repositories
  sl.registerLazySingleton<AuthRepositories>(() => AuthRepositoriesImpl(sl()));

  // blocs
  sl.registerFactory(() => AuthBloc(sl(),sl()));
}
