import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_cash/features/auth/domain/entities/user_login_entities.dart';
import 'package:i_cash/features/order_menu/presentation/pages/order_menu_page.dart';
import 'package:i_cash/features/order_menu/presentation/bloc/order_menu_bloc.dart';
import 'package:i_cash/features/order_menu/presentation/bloc/handle_order_menu_bloc/handle_order_menu_bloc.dart';
import 'package:i_cash/features/order_menu/presentation/bloc/tax_bloc/tax_bloc.dart';
import 'package:i_cash/initialize.dart';

class OrderMenuWrapper extends StatelessWidget {
  const OrderMenuWrapper({super.key, required this.userLoginEntities});

  final UserLoginEntities userLoginEntities;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<OrderMenuBloc>()),
        BlocProvider(create: (_) => sl<HandleOrderMenuBloc>()),
        BlocProvider(create: (_) => sl<TaxBloc>()),
      ],
      child: OrderMenuPage(userLoginEntities: userLoginEntities),
    );
  }
}
