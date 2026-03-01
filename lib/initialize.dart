import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:i_cash/common/db/local_database.dart';
import 'package:i_cash/features/auth/data/datasources/local/auth_local_datasource.dart';
import 'package:i_cash/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:i_cash/features/auth/data/repositories/auth_repositories_impl.dart';
import 'package:i_cash/features/auth/domain/repositories/auth_repositories.dart';
import 'package:i_cash/features/auth/domain/usecases/auth_login.dart';
import 'package:i_cash/features/auth/domain/usecases/auth_login_offline.dart';
import 'package:i_cash/features/auth/domain/usecases/auth_read_login_data.dart';
import 'package:i_cash/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:i_cash/features/menu/data/datasources/local/menu_local_datasource.dart';
import 'package:i_cash/features/menu/data/repositories/menu_repositories_impl.dart';
import 'package:i_cash/features/menu/domain/repositories/menu_repositories.dart';
import 'package:i_cash/features/menu/domain/usecases/get_menu_data.dart';
import 'package:i_cash/features/menu/presentation/bloc/menu_bloc.dart';
import 'package:i_cash/features/order_menu/data/datasources/local/order_menu_local_datasource.dart';
import 'package:i_cash/features/order_menu/data/repositories/order_menu_repositories_impl.dart';
import 'package:i_cash/features/order_menu/domain/repositories/order_menu_repositories.dart';
import 'package:i_cash/features/order_menu/domain/usecases/add_order_menu_take_away.dart';
import 'package:i_cash/features/order_menu/domain/usecases/get_menu_makanan.dart';
import 'package:i_cash/features/order_menu/domain/usecases/get_menu_minuman.dart';
import 'package:i_cash/features/order_menu/presentation/bloc/handle_order_menu_bloc/handle_order_menu_bloc.dart';
import 'package:i_cash/features/order_menu/presentation/bloc/order_menu_bloc.dart';
import 'package:i_cash/features/order_menu/presentation/bloc/tax_bloc/tax_bloc.dart';
import 'package:i_cash/features/setting/data/datasources/local/setting_local_datasource.dart';
import 'package:i_cash/features/setting/data/datasources/remote/setting_remote_datasource.dart';
import 'package:i_cash/features/setting/data/repositories/setting_reposiotries_impl.dart';
import 'package:i_cash/features/setting/domain/repositories/setting_repositories.dart';
import 'package:i_cash/features/setting/domain/usecases/add_table.dart';
import 'package:i_cash/features/setting/domain/usecases/add_tax.dart';
import 'package:i_cash/features/setting/domain/usecases/delete_table.dart';
import 'package:i_cash/features/setting/domain/usecases/delete_tax.dart';
import 'package:i_cash/features/setting/domain/usecases/get_table.dart';
import 'package:i_cash/features/setting/domain/usecases/get_tax.dart';
import 'package:i_cash/features/setting/domain/usecases/sync_menu.dart';
import 'package:i_cash/features/setting/presentation/bloc/setting_bloc.dart';
import 'package:i_cash/features/setting/presentation/bloc/setting_menu_bloc/setting_menu_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependecies() async {
  // firebase instances
  sl.registerLazySingleton(() => FirebaseDatabase.instance);
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => LocalDatabase.instance);

  // datasources
  sl.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(sl<FirebaseDatabase>(), sl<FirebaseAuth>()),
  );
  sl.registerLazySingleton<AuthLocalDatasource>(
    () => AuthLocalDatasourceImpl(sl()),
  );
  sl.registerLazySingleton<SettingRemoteDatasource>(
    () => SettingRemoteDatasourceImpl(sl()),
  );
  sl.registerLazySingleton<SettingLocalDatasource>(
    () => SettingLocalDatasourceImpl(sl()),
  );
  sl.registerLazySingleton<MenuLocalDatasource>(
    () => MenuLocalDatasourceImpl(sl()),
  );
  sl.registerLazySingleton<OrderMenuLocalDatasource>(
    () => OrderMenuLocalDatasourceImpl(sl()),
  );

  // usecases
  sl.registerLazySingleton(() => AuthLogin(sl()));
  sl.registerLazySingleton(() => AuthLoginOffline(sl()));
  sl.registerLazySingleton(() => AuthReadLoginData(sl()));
  sl.registerLazySingleton(() => SyncMenu(sl()));
  sl.registerLazySingleton(() => AddTax(sl()));
  sl.registerLazySingleton(() => GetTax(sl()));
  sl.registerLazySingleton(() => DeleteTax(sl()));
  sl.registerLazySingleton(() => AddTable(sl()));
  sl.registerLazySingleton(() => GetTable(sl()));
  sl.registerLazySingleton(() => DeleteTable(sl()));
  sl.registerLazySingleton(() => GetMenuData(sl()));
  sl.registerLazySingleton(() => GetMenuMakanan(sl()));
  sl.registerLazySingleton(() => GetMenuMinuman(sl()));
  sl.registerLazySingleton(() => AddOrderMenuTakeAway(sl()));

  // repositories
  sl.registerLazySingleton<AuthRepositories>(
    () => AuthRepositoriesImpl(sl(), sl()),
  );
  sl.registerLazySingleton<SettingRepositories>(
    () => SettingReposiotriesImpl(sl(), sl()),
  );
  sl.registerLazySingleton<MenuRepositories>(() => MenuRepositoriesImpl(sl()));
  sl.registerLazySingleton<OrderMenuRepositories>(
    () => OrderMenuRepositoriesImpl(sl()),
  );

  // blocs
  sl.registerFactory(() => AuthBloc(sl(), sl(), sl()));
  sl.registerFactory(() => SettingMenuBloc(sl()));
  sl.registerFactory(() => SettingBloc(sl(), sl(), sl(), sl(), sl(), sl()));
  sl.registerFactory(() => MenuBloc(sl()));
  sl.registerFactory(() => OrderMenuBloc(sl(), sl()));
  sl.registerFactory(() => HandleOrderMenuBloc(sl()));
  sl.registerFactory(() => TaxBloc(sl()));
  
}
