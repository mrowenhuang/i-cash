import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:i_cash/features/setting/domain/entities/tax_entites.dart';
import 'package:i_cash/features/setting/domain/usecases/add_table.dart';
import 'package:i_cash/features/setting/domain/usecases/add_tax.dart';
import 'package:i_cash/features/setting/domain/usecases/get_tax.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final AddTax _addTax;
  final GetTax _getTax;
  final AddTable _addTable;
  SettingBloc(this._addTax, this._getTax, this._addTable)
    : super(SettingInitial()) {
    on<AddTaxDataSettingEvent>(addTaxDataSettingEvent);
    on<GetTaxDataSettingEvent>(getTaxDataSettingEvent);
    on<AddNumberOftableSettingEvent>(addNumberOftableSettingEvent);
  }

  FutureOr<void> addTaxDataSettingEvent(
    AddTaxDataSettingEvent event,
    Emitter<SettingState> emit,
  ) async {
    emit(LoadingAddTaxDataSettingState());

    final response = await _addTax.call(
      taxName: event.taxName,
      taxPercent: event.taxPercent,
    );

    await response.fold(
      (l) async {
        emit(FailedAddTaxDataSettingState(l.message));
      },
      (r) async {
        emit(SuccessAddTaxDataSettingState(r));
        await getTaxDataSettingEvent(GetTaxDataSettingEvent(), emit);
      },
    );
  }

  FutureOr<void> getTaxDataSettingEvent(
    GetTaxDataSettingEvent event,
    Emitter<SettingState> emit,
  ) async {
    emit(LoadingGetTaxDataSettingState());
    final response = await _getTax.call();

    response.fold(
      (l) {
        emit(FailedGetTaxDataSettingState(l.message));
      },
      (r) {
        emit(SuccessGetTaxDataSettingState(r));
      },
    );
  }

  FutureOr<void> addNumberOftableSettingEvent(
    AddNumberOftableSettingEvent event,
    Emitter<SettingState> emit,
  ) async {
    emit(LoadingAddTableDataSettingState());

    final response = await _addTable.call(numberOfTable: event.numberOfTable);

    await response.fold(
      (l) async {
        emit(FailedAddTableDataSettingState(l.message));
      },
      (r) async {
        emit(SuccessAddTableDataSettingState(r));
        // await getTaxDataSettingEvent(GetTaxDataSettingEvent(), emit);
      },
    );
  }
}
