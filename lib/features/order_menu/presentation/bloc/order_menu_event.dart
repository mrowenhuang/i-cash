part of 'order_menu_bloc.dart';

abstract class OrderMenuEvent extends Equatable {
  const OrderMenuEvent();

  @override
  List<Object?> get props => [];
}

final class GetMenuMakananOrderMenuEvent extends OrderMenuEvent {}

final class GetMenuMinumanOrderMenuEvent extends OrderMenuEvent {}

final class ChangeTabOrderMenuEvent extends OrderMenuEvent {
  final int index;

  const ChangeTabOrderMenuEvent({required this.index});

  @override
  List<Object?> get props => [index];
}

final class SearchMenuOrderMenuEvent extends OrderMenuEvent {
  final String key;

  const SearchMenuOrderMenuEvent({required this.key});

  @override
  List<Object?> get props => [key];
}
