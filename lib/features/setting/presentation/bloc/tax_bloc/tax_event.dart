part of 'tax_bloc.dart';

sealed class TaxEvent extends Equatable {
  const TaxEvent();

  @override
  List<Object> get props => [];
}

final class AddTaxDataSettingEvent extends TaxEvent {
  final String taxName;
  final String taxPercent;

  const AddTaxDataSettingEvent(this.taxName, this.taxPercent);
}

final class GetTaxDataSettingEvent extends TaxEvent {}
