import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:i_cash/features/setting/domain/entities/tax_entites.dart';
import 'package:i_cash/features/setting/domain/usecases/add_table.dart';
import 'package:i_cash/features/setting/domain/usecases/add_tax.dart';
import 'package:i_cash/features/setting/domain/usecases/delete_table.dart';
import 'package:i_cash/features/setting/domain/usecases/delete_tax.dart';
import 'package:i_cash/features/setting/domain/usecases/get_table.dart';
import 'package:i_cash/features/setting/domain/usecases/get_tax.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final AddTax _addTax;
  final GetTax _getTax;
  final DeleteTax _deleteTax;
  final AddTable _addTable;
  final GetTable _getTable;
  final DeleteTable _deleteTable;

  SettingBloc(
    this._addTax,
    this._getTax,
    this._addTable,
    this._getTable,
    this._deleteTable,
    this._deleteTax,
  ) : super(SettingInitial()) {
    on<AddTaxDataSettingEvent>(addTaxDataSettingEvent);
    on<GetTaxDataSettingEvent>(getTaxDataSettingEvent);
    on<AddNumberOftableSettingEvent>(addNumberOftableSettingEvent);
    on<GetTableDataSettingEvent>(getTableDataSettingEvent);
    on<DeleteTableDataSettingEvent>(deleteTableDataSettingEvent);
    on<DeleteTaxDataSettingEvent>(deleteTaxDataSettingEvent);
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
        await getTableDataSettingEvent(GetTableDataSettingEvent(), emit);
      },
    );
  }

  FutureOr<void> getTableDataSettingEvent(
    GetTableDataSettingEvent event,
    Emitter<SettingState> emit,
  ) async {
    emit(LoadingGetTableDataSettingState());
    final response = await _getTable.call();

    response.fold(
      (l) {
        print(l.message);
        emit(FailedGetTableDataSettingState(l.message));
      },
      (r) {
        emit(SuccessGetTableDataSettingState(r));
      },
    );
  }

  FutureOr<void> deleteTableDataSettingEvent(
    DeleteTableDataSettingEvent event,
    Emitter<SettingState> emit,
  ) async {
    emit(LoadingDeleteTableDataSettingState());
    final response = await _deleteTable.call(key: event.key);

    await response.fold(
      (l) async {
        emit(FailedDeleteTableDataSettingState(l.message));
      },
      (r) async {
        emit(SuccessDeleteTableDataSettingState(r));
        await getTableDataSettingEvent(GetTableDataSettingEvent(), emit);
      },
    );
  }

  FutureOr<void> deleteTaxDataSettingEvent(
    DeleteTaxDataSettingEvent event,
    Emitter<SettingState> emit,
  ) async {
    emit(LoadingDeleteTaxDataSettingState());
    final response = await _deleteTax.call(key: event.key);

    await response.fold(
      (l) async {
        emit(FailedDeleteTaxDataSettingState(l.message));
      },
      (r) async {
        emit(SuccessDeleteTaxDataSettingState(r));
        await getTaxDataSettingEvent(GetTaxDataSettingEvent(), emit);
      },
    );
  }
}
