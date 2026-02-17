import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:i_cash/features/auth/domain/entities/user_login_entities.dart';
import 'package:i_cash/features/setting/domain/usecases/sync_menu.dart';

part 'setting_menu_event.dart';
part 'setting_menu_state.dart';

class SettingMenuBloc extends Bloc<SettingMenuEvent, SettingMenuState> {
  final SyncMenu _syncMenu;

  SettingMenuBloc(this._syncMenu) : super(MenuInitial()) {
    on<SyncMenuDataSettingEvent>(syncMenuDataSettingEvent);
  }

  FutureOr<void> syncMenuDataSettingEvent(
    SyncMenuDataSettingEvent event,
    Emitter<SettingMenuState> emit,
  ) async {
    emit(LoadingSyncMenuDataSettingState());
    var response = await _syncMenu.call(userLoginData: event.userLoginEntities);

    response.fold(
      (l) {
        print(l.message);
        emit(FailedSyncMenuDataSettingState(l.message));
      },
      (r) {
        emit(SuccessSyncMenuDataSettingState(r));
      },
    );
  }
}
