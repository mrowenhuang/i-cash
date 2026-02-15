import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:i_cash/features/menu/domain/entities/menu_entities.dart';
import 'package:i_cash/features/menu/domain/usecases/get_menu_data.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final GetMenuData _getMenuData;

  MenuBloc(this._getMenuData) : super(MenuInitial()) {
    on<GetMenuDataEvent>(getMenuDataEvent);
    on<ChangeTabMenuEvent>(changeTabMenuEvent);
  }

  // FutureOr<void> getMenuDataEvent(
  //   GetMenuDataEvent event,
  //   Emitter<MenuState> emit,
  // ) async {
  //   emit(LoadingMenuState());

  //   final response = await _getMenuData.call();

  //   response.fold(
  //     (failure) {
  //       emit(FailedMenuState(message: failure.message));
  //     },
  //     (response) {
  //       emit(SuccessMenuState(menuData: response));
  //     },
  //   );
  // }

  FutureOr<void> getMenuDataEvent(
    GetMenuDataEvent event,
    Emitter<MenuState> emit,
  ) async {
    emit(LoadingMenuState());

    final response = await _getMenuData.call();

    response.fold(
      (failure) {
        emit(FailedMenuState(message: failure.message));
      },
      (menus) {
        final grouped = _groupByGroup(menus);

        emit(SuccessMenuState(menuData: menus, groupedMenu: grouped));
      },
    );
  }

  FutureOr<void> changeTabMenuEvent(
    ChangeTabMenuEvent event,
    Emitter<MenuState> emit,
  ) {
    emit(LoadingMenuState());

    if (event.index == 0) {
      emit(
        SuccessMenuState(
          menuData: event.groupedMenu.values.expand((e) => e).toList(),
          groupedMenu: event.groupedMenu,
        ),
      );
    } else {
      emit(
        SuccessMenuState(
          menuData: event.groupedMenu.values.toList()[event.index - 1],
          groupedMenu: event.groupedMenu,
        ),
      );
    }
  }

  Map<String, List<MenuEntities>> _groupByGroup(List<MenuEntities> menus) {
    final Map<String, List<MenuEntities>> grouped = {};
    for (var menu in menus) {
      if (grouped.containsKey(menu.groupName)) {
        grouped[menu.groupName]!.add(menu);
      } else {
        grouped[menu.groupName!] = [menu];
      }
    }
    return grouped;
  }
}
