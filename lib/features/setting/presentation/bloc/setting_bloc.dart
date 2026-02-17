import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_x/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:i_cash/features/auth/domain/entities/user_login_entities.dart';
import 'package:i_cash/features/setting/domain/entities/tax_entites.dart';
import 'package:i_cash/features/setting/domain/usecases/add_tax.dart';
import 'package:i_cash/features/setting/domain/usecases/get_tax.dart';
import 'package:i_cash/features/setting/domain/usecases/sync_menu.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final SyncMenu _syncMenu;

  SettingBloc(this._syncMenu)
    : super(SettingInitial()) {
    on<SyncMenuDataSettingEvent>(syncMenuDataSettingEvent);
  }

  FutureOr<void> syncMenuDataSettingEvent(
    SyncMenuDataSettingEvent event,
    Emitter<SettingState> emit,
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
