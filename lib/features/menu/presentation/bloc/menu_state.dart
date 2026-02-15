part of 'menu_bloc.dart';

abstract class MenuState extends Equatable {
  const MenuState();

  @override
  List<Object> get props => [];
}

class MenuInitial extends MenuState {}

final class LoadingMenuState extends MenuState {}

// final class SuccessMenuState extends MenuState {
//   final List<MenuEntities> menuData;

//   const SuccessMenuState({required this.menuData});
// }
class SuccessMenuState extends MenuState {
  final List<MenuEntities> menuData;
  final Map<String, List<MenuEntities>> groupedMenu;

  const SuccessMenuState({required this.menuData, required this.groupedMenu});
}

final class FailedMenuState extends MenuState {
  final String message;

  const FailedMenuState({required this.message});
}
