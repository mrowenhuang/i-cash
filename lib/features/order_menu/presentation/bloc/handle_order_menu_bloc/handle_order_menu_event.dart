part of 'handle_order_menu_bloc.dart';

sealed class HandleOrderMenuEvent extends Equatable {
  const HandleOrderMenuEvent();

  @override
  List<Object> get props => [];
}

final class AddOrderMenuDataEvent extends HandleOrderMenuEvent {
  final MenuEntities menu;

  const AddOrderMenuDataEvent({required this.menu});
}

final class DropOrderMenuDataEvent extends HandleOrderMenuEvent {
  final MenuEntities menu;

  const DropOrderMenuDataEvent({required this.menu});
}

final class ClearOrderMenuDataEvent extends HandleOrderMenuEvent {}

final class TakeAwayOrderMenuEvent extends HandleOrderMenuEvent {
  final String serviceAndTax;
  final UserLoginEntities userData;
  final String noTaxPrice;
  final String totalPrice;

  const TakeAwayOrderMenuEvent({
    required this.serviceAndTax,
    required this.userData,
    required this.noTaxPrice,
    required this.totalPrice,
  });
}

// final class AddOrderMenuMakananEvent extends HandleOrderMenuEvent {
//   final MenuEntities menu;

//   const AddOrderMenuMakananEvent({required this.menu});
// }

// final class AddOrderMenuMinumanEvent extends HandleOrderMenuEvent {
//   final MenuEntities menu;

//   const AddOrderMenuMinumanEvent({required this.menu});
// }
