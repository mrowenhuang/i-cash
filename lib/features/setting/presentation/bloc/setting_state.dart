part of 'setting_bloc.dart';

abstract class SettingState extends Equatable {
  const SettingState();

  @override
  List<Object> get props => [];
}

class SettingInitial extends SettingState {}

final class LoadingAddTaxDataSettingState extends SettingState {}

final class SuccessAddTaxDataSettingState extends SettingState {
  final String message;

  const SuccessAddTaxDataSettingState(this.message);
}

final class FailedAddTaxDataSettingState extends SettingState {
  final String message;

  const FailedAddTaxDataSettingState(this.message);
}

final class LoadingGetTaxDataSettingState extends SettingState {}

final class SuccessGetTaxDataSettingState extends SettingState {
  final List<TaxEntites> taxEntites;

  const SuccessGetTaxDataSettingState(this.taxEntites);
}

final class FailedGetTaxDataSettingState extends SettingState {
  final String message;

  const FailedGetTaxDataSettingState(this.message);
}

final class LoadingAddTableDataSettingState extends SettingState {}

final class SuccessAddTableDataSettingState extends SettingState {
  final String taxEntites;

  const SuccessAddTableDataSettingState(this.taxEntites);
}

final class FailedAddTableDataSettingState extends SettingState {
  final String message;

  const FailedAddTableDataSettingState(this.message);
}
