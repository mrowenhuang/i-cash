part of 'handle_order_menu_bloc.dart';

sealed class HandleOrderMenuState extends Equatable {
  const HandleOrderMenuState();

  @override
  List<Object> get props => [];
}

final class HandleorderInitial extends HandleOrderMenuState {}

final class LoadingAddOrderMenuState extends HandleOrderMenuState {
  @override
  List<Object> get props => [];
}

final class SuccessAddOrderMenuState extends HandleOrderMenuState {
  final List<OrderItemEntites> menuMakananData;
  final List<OrderItemEntites> menuMinumanData;
  // final Map<String, List<OrderItemEntites>> groupedMenu;

  const SuccessAddOrderMenuState({
    // required this.groupedMenu,
    required this.menuMakananData,
    required this.menuMinumanData,
  });
  @override
  List<Object> get props => [];
}

final class FailedAddOrderMenuState extends HandleOrderMenuState {
  final String message;

  const FailedAddOrderMenuState({required this.message});
  @override
  List<Object> get props => [message];
}

final class LoadingAddOrderMenuTakeAwayState extends HandleOrderMenuState {
  @override
  List<Object> get props => [];
}

final class SuccessAddOrderMenuTakeAwayState extends HandleOrderMenuState {
  final String message;

  const SuccessAddOrderMenuTakeAwayState({required this.message});
  @override
  List<Object> get props => [message];
}

final class FailedAddOrderMenuTakeAwayState extends HandleOrderMenuState {
  final String message;

  const FailedAddOrderMenuTakeAwayState({required this.message});
  @override
  List<Object> get props => [message];
}

// final class LoadingAddOrderMenuMinumanState extends HandleOrderMenuState {
//   @override
//   List<Object> get props => [];
// }

// final class SuccessAddOrderMenuMinumanState extends HandleOrderMenuState {
//   final List<OrderItemEntites> menuData;
//   // final Map<String, List<OrderItemEntites>> groupedMenu;

//   const SuccessAddOrderMenuMinumanState({
//     required this.menuData,
//     // required this.groupedMenu,
//   });
//   @override
//   List<Object> get props => [];
// }

// final class FailedAddOrderMenuMinumanState extends HandleOrderMenuState {
//   final String message;

//   const FailedAddOrderMenuMinumanState({required this.message});
//   @override
//   List<Object> get props => [message];
// }
