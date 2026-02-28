import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_x/get.dart';
import 'package:i_cash/common/db/local_database.dart';
import 'package:i_cash/common/theme/app_theme.dart';
import 'package:i_cash/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:i_cash/features/auth/presentation/pages/login_page.dart';
import 'package:i_cash/features/menu/presentation/bloc/menu_bloc.dart';
import 'package:i_cash/features/order_menu/presentation/bloc/order_menu_bloc.dart';
import 'package:i_cash/features/setting/presentation/bloc/setting_bloc.dart';
import 'package:i_cash/features/setting/presentation/bloc/setting_menu_bloc/setting_menu_bloc.dart';
import 'package:i_cash/firebase_options.dart';
import 'package:i_cash/initialize.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await initializeDependecies();
  await initializeDateFormatting('id_ID', null);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await requestStoragePermission();
  await LocalDatabase.instance.database;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AuthBloc>()..add(CheckInternetAuthEvent()),
        ),
        BlocProvider(create: (context) => sl<SettingMenuBloc>()),
        BlocProvider(create: (context) => sl<SettingBloc>()),
        BlocProvider(create: (context) => sl<MenuBloc>()),
        BlocProvider(create: (context) => sl<OrderMenuBloc>()),
      ],
      child: GetMaterialApp(
        title: 'i-cash',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
      ),
    );
  }
}
