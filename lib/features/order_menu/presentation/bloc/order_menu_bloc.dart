import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:i_cash/features/menu/domain/entities/menu_entities.dart';
import 'package:i_cash/features/order_menu/domain/usecases/get_menu_minuman.dart';
import 'package:i_cash/features/order_menu/domain/usecases/get_menu_makanan.dart';

part 'order_menu_event.dart';
part 'order_menu_state.dart';

class OrderMenuBloc extends Bloc<OrderMenuEvent, OrderMenuState> {
  final GetMenuMakanan _getMenuMakanan;
  final GetMenuMinuman _getMenuMinuman;

  /// CACHE
  List<MenuEntities>? _cachedMakanan;
  List<MenuEntities>? _cachedMinuman;
  int _activeTab = 0;

  OrderMenuBloc(this._getMenuMinuman, this._getMenuMakanan)
    : super(OrderMenuInitial()) {
    on<GetMenuMakananOrderMenuEvent>(_getMenuMakananOrderMenuEvent);
    on<GetMenuMinumanOrderMenuEvent>(_getMenuMinumanOrderMenuEvent);
    on<ChangeTabOrderMenuEvent>(_changeTabOrderMenuEvent);
    on<SearchMenuOrderMenuEvent>(_searchMenuOrderMenuEvent);
  }

  /// =======================
  /// MAKANAN
  /// =======================
  Future<void> _getMenuMakananOrderMenuEvent(
    GetMenuMakananOrderMenuEvent event,
    Emitter<OrderMenuState> emit,
  ) async {
    /// kalau sudah ada cache → langsung return
    if (_cachedMakanan != null) {
      emit(SuccessOrderMenuMakananState(menuData: _cachedMakanan!));
      return;
    }

    emit(LoadingOrderMenuMakananState());

    final response = await _getMenuMakanan();

    response.fold(
      (failure) => emit(FailedOrderMenuMakananState(message: failure.message)),
      (menus) {
        _cachedMakanan = menus;

        /// simpan cache
        emit(SuccessOrderMenuMakananState(menuData: menus));
      },
    );
  }

  /// =======================
  /// MINUMAN
  /// =======================
  Future<void> _getMenuMinumanOrderMenuEvent(
    GetMenuMinumanOrderMenuEvent event,
    Emitter<OrderMenuState> emit,
  ) async {
    if (_cachedMinuman != null) {
      emit(SuccessOrderMenuMinumanState(menuData: _cachedMinuman!));
      return;
    }

    emit(LoadingOrderMenuMinumanState());

    final response = await _getMenuMinuman();

    response.fold(
      (failure) => emit(FailedOrderMenuMinumanState(message: failure.message)),
      (menus) {
        _cachedMinuman = menus;
        emit(SuccessOrderMenuMinumanState(menuData: menus));
      },
    );
  }

  FutureOr<void> _changeTabOrderMenuEvent(
    ChangeTabOrderMenuEvent event,
    Emitter<OrderMenuState> emit,
  ) async {
    _activeTab = event.index;

    if (_activeTab == 1) {
      add(GetMenuMinumanOrderMenuEvent());
    } else {
      add(GetMenuMakananOrderMenuEvent());
    }
  }

  FutureOr<void> _searchMenuOrderMenuEvent(
    SearchMenuOrderMenuEvent event,
    Emitter<OrderMenuState> emit,
  ) async {
    final keyword = event.key.toLowerCase();

    print(keyword);

    final source = _activeTab == 1 ? _cachedMinuman : _cachedMakanan;
    if (source == null) return;

    /// kalau search kosong → tampilkan semua
    if (keyword.isEmpty) {
      if (_activeTab == 1) {
        emit(SuccessOrderMenuMinumanState(menuData: source));
      } else {
        emit(SuccessOrderMenuMakananState(menuData: source));
      }
      return;
    }

    final result = source
        .where((e) => (e.name ?? "").toLowerCase().contains(keyword))
        .toList();

    if (_activeTab == 1) {
      emit(SuccessOrderMenuMinumanState(menuData: result));
    } else {
      emit(SuccessOrderMenuMakananState(menuData: result));
    }
  }
}
