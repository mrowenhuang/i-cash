import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:get_x/get_utils/src/platform/platform_stub.dart';
import 'package:i_cash/features/auth/domain/entities/user_login_entities.dart';
import 'package:i_cash/features/menu/domain/entities/menu_entities.dart';
import 'package:i_cash/features/order_menu/domain/entities/order_item_entites.dart';
import 'package:i_cash/features/order_menu/domain/usecases/add_order_menu_take_away.dart';

part 'handle_order_menu_event.dart';
part 'handle_order_menu_state.dart';

class HandleOrderMenuBloc
    extends Bloc<HandleOrderMenuEvent, HandleOrderMenuState> {
  List<OrderItemEntites> _cartMakanan = [];
  List<OrderItemEntites> _cartMinuman = [];

  final AddOrderMenuTakeAway _addOrderMenuTakeAway;

  HandleOrderMenuBloc(this._addOrderMenuTakeAway)
    : super(HandleorderInitial()) {
    on<AddOrderMenuDataEvent>(_addOrderMenuDataEvent);
    on<ClearOrderMenuDataEvent>(_clearOrderMenuDataEvent);
    on<DropOrderMenuDataEvent>(_dropOrderMenuDataEvent);
    on<TakeAwayOrderMenuEvent>(_takeAwayOrderMenuEvent);
    // on<DropOrderMenuDataEvent>(_dropOrderMenuDataEvent);
    // on<AddOrderMenuMinumanEvent>(_addOrderMenuMinumanEvent);
  }

  double get totalMakanan {
    return _cartMakanan.fold<double>(
      0,
      (sum, item) =>
          sum + (double.parse(item.menu.sellPrice ?? "0") * item.quantity),
    );
  }

  double get totalMinuman {
    return _cartMinuman.fold<double>(
      0,
      (sum, item) =>
          sum + (double.parse(item.menu.sellPrice ?? "0") * item.quantity),
    );
  }

  double get totalHarga {
    return totalMakanan + totalMinuman;
  }

  FutureOr<void> _addOrderMenuDataEvent(
    AddOrderMenuDataEvent event,
    Emitter<HandleOrderMenuState> emit,
  ) async {
    final isMinuman = event.menu.groupName?.toLowerCase() == "minuman";

    final cart = isMinuman ? _cartMinuman : _cartMakanan;

    final index = cart.indexWhere((e) => e.menu.idMenu == event.menu.idMenu);

    if (index != -1) {
      final currentItem = cart[index];
      cart[index] = currentItem.copyWith(quantity: currentItem.quantity + 1);
    } else {
      cart.add(OrderItemEntites(menu: event.menu, quantity: 1));
    }
    emit(LoadingAddOrderMenuState());

    emit(
      SuccessAddOrderMenuState(
        menuMakananData: List.from(_cartMakanan),
        menuMinumanData: List.from(_cartMinuman),
      ),
    );
  }

  // FutureOr<void> _addOrderMenuMinumanEvent(
  //   AddOrderMenuMinumanEvent event,
  //   Emitter<HandleOrderMenuState> emit,
  // ) {
  //   _cartMinuman.add(event.menu);
  // }

  // FutureOr<void> _dropOrderMenuDataEvent(
  //   DropOrderMenuDataEvent event,
  //   Emitter<HandleOrderMenuState> emit,
  // ) {
  //   if (event.menu.groupName?.toLowerCase() == "minuman") {
  //     _cartMinuman.removeWhere(
  //       (element) => element.idMenu == event.menu.idMenu,
  //     );
  //     emit(SuccessAddOrderMenuMinumanState(menuData: _cartMinuman));
  //   } else if (event.menu.groupName?.toLowerCase() == "makanan") {
  //     _cartMakanan.removeWhere(
  //       (element) => element.idMenu == event.menu.idMenu,
  //     );
  //     emit(SuccessAddOrderMenuMakananState(menuData: _cartMakanan));
  //   }
  // }

  FutureOr<void> _clearOrderMenuDataEvent(
    ClearOrderMenuDataEvent event,
    Emitter<HandleOrderMenuState> emit,
  ) async {
    emit(LoadingAddOrderMenuState());
    _cartMakanan.clear();
    _cartMinuman.clear();
    emit(
      SuccessAddOrderMenuState(
        menuMakananData: List.from(_cartMakanan),
        menuMinumanData: List.from(_cartMinuman),
      ),
    );
  }

  FutureOr<void> _dropOrderMenuDataEvent(
    DropOrderMenuDataEvent event,
    Emitter<HandleOrderMenuState> emit,
  ) async {
    final isMinuman = event.menu.groupName?.toLowerCase() == "minuman";

    final cart = isMinuman ? _cartMinuman : _cartMakanan;

    final index = cart.indexWhere((e) => e.menu.idMenu == event.menu.idMenu);

    if (index != -1) {
      final currentItem = cart[index];

      if (currentItem.quantity > 1) {
        // Kurangi 1 quantity
        cart[index] = currentItem.copyWith(quantity: currentItem.quantity - 1);
      } else {
        // Kalau tinggal 1 → hapus item
        cart.removeAt(index);
      }
    }

    emit(LoadingAddOrderMenuState());

    emit(
      SuccessAddOrderMenuState(
        menuMakananData: List.from(_cartMakanan),
        menuMinumanData: List.from(_cartMinuman),
      ),
    );
  }

  FutureOr<void> _takeAwayOrderMenuEvent(
    TakeAwayOrderMenuEvent event,
    Emitter<HandleOrderMenuState> emit,
  ) async {
    emit(LoadingAddOrderMenuTakeAwayState());

    final response = await _addOrderMenuTakeAway.call(
      serviceAndTax: event.serviceAndTax,
      userData: event.userData,
      noTaxPrice: event.noTaxPrice,
      totalPrice: event.totalPrice,
      cartMakanan: _cartMakanan,
      cartMinuman: _cartMinuman,
    );

    response.fold(
      (l) {
        emit(FailedAddOrderMenuTakeAwayState(message: l.message));
      },
      (r) {
        emit(SuccessAddOrderMenuTakeAwayState(message: r));
      },
    );
  }
}
