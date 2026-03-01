// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:i_cash/features/setting/domain/entities/tax_entites.dart';
import 'package:i_cash/features/setting/domain/usecases/get_tax.dart';

part 'tax_event.dart';
part 'tax_state.dart';

class TaxBloc extends Bloc<TaxEvent, TaxState> {
  final GetTax _getTax;

  TaxBloc(this._getTax) : super(TaxInitial()) {
    on<GetTaxEvent>(_getTaxEvent);
  }

  FutureOr<void> _getTaxEvent(GetTaxEvent event, Emitter<TaxState> emit) async {
    emit(LoadingGetTaxState());
    final response = await _getTax.call();

    response.fold(
      (l) {
        emit(FailedGetTaxState(message: l.message));
      },
      (r) {
        emit(SuccessGetTaxState(taxData: r));
      },
    );
  }
}
