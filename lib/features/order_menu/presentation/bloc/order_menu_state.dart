part of 'order_menu_bloc.dart';

abstract class OrderMenuState extends Equatable {
  const OrderMenuState();
}

class OrderMenuInitial extends OrderMenuState {
  @override
  List<Object> get props => [];
}

final class LoadingOrderMenuMakananState extends OrderMenuState {
  @override
  List<Object> get props => [];
}

class SuccessOrderMenuMakananState extends OrderMenuState {
  final List<MenuEntities> menuData;

  const SuccessOrderMenuMakananState({required this.menuData});

  @override
  List<Object> get props => [menuData];
}

final class FailedOrderMenuMakananState extends OrderMenuState {
  final String message;

  const FailedOrderMenuMakananState({required this.message});

  @override
  List<Object> get props => [message];
}

final class LoadingOrderMenuMinumanState extends OrderMenuState {
  @override
  List<Object> get props => [];
}

class SuccessOrderMenuMinumanState extends OrderMenuState {
  final List<MenuEntities> menuData;

  const SuccessOrderMenuMinumanState({required this.menuData});

  @override
  List<Object> get props => [menuData];
}

final class FailedOrderMenuMinumanState extends OrderMenuState {
  final String message;

  const FailedOrderMenuMinumanState({required this.message});

  @override
  List<Object> get props => [message];
}


