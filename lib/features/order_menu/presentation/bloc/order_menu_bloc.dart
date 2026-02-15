import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'order_menu_event.dart';
part 'order_menu_state.dart';

class OrderMenuBloc extends Bloc<OrderMenuEvent, OrderMenuState> {
  OrderMenuBloc() : super(OrderMenuInitial()) {
    on<OrderMenuEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
