import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:i_cash/features/setting/domain/entities/tax_entites.dart';
import 'package:i_cash/features/setting/domain/usecases/add_tax.dart';
import 'package:i_cash/features/setting/domain/usecases/get_tax.dart';

part 'tax_event.dart';
part 'tax_state.dart';

class TaxBloc extends Bloc<TaxEvent, TaxState> {
  final AddTax _addTax;
  final GetTax _getTax;

  TaxBloc(this._addTax, this._getTax) : super(TaxInitial()) {
    on<AddTaxDataSettingEvent>(addTaxDataSettingEvent);
    on<GetTaxDataSettingEvent>(getTaxDataSettingEvent);
  }

  FutureOr<void> addTaxDataSettingEvent(
    AddTaxDataSettingEvent event,
    Emitter<TaxState> emit,
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
    Emitter<TaxState> emit,
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
}
