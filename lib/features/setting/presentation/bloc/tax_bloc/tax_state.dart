part of 'tax_bloc.dart';

sealed class TaxState extends Equatable {
  const TaxState();

  @override
  List<Object> get props => [];
}

final class TaxInitial extends TaxState {}

final class LoadingAddTaxDataSettingState extends TaxState {}

final class SuccessAddTaxDataSettingState extends TaxState {
  final String message;

  const SuccessAddTaxDataSettingState(this.message);
}

final class FailedAddTaxDataSettingState extends TaxState {
  final String message;

  const FailedAddTaxDataSettingState(this.message);
}

final class LoadingGetTaxDataSettingState extends TaxState {}

final class SuccessGetTaxDataSettingState extends TaxState {
  final List<TaxEntites> taxEntites;

  const SuccessGetTaxDataSettingState(this.taxEntites);
}

final class FailedGetTaxDataSettingState extends TaxState {
  final String message;

  const FailedGetTaxDataSettingState(this.message);
}
