part of 'menu_bloc.dart';

abstract class MenuEvent extends Equatable {
  const MenuEvent();

  @override
  List<Object> get props => [];
}

final class GetMenuDataEvent extends MenuEvent {}

final class ChangeTabMenuEvent extends MenuEvent {
  final Map<String, List<MenuEntities>> groupedMenu;
  final int index;

  const ChangeTabMenuEvent({required this.groupedMenu, required this.index});
}

