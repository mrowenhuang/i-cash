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

final class LoadingDeleteTaxDataSettingState extends SettingState {}

final class SuccessDeleteTaxDataSettingState extends SettingState {
  final String message;

  const SuccessDeleteTaxDataSettingState(this.message);
}

final class FailedDeleteTaxDataSettingState extends SettingState {
  final String message;

  const FailedDeleteTaxDataSettingState(this.message);
}

final class LoadingAddTableDataSettingState extends SettingState {}

final class SuccessAddTableDataSettingState extends SettingState {
  final String message;

  const SuccessAddTableDataSettingState(this.message);
}

final class FailedAddTableDataSettingState extends SettingState {
  final String message;

  const FailedAddTableDataSettingState(this.message);
}

final class LoadingGetTableDataSettingState extends SettingState {}

final class SuccessGetTableDataSettingState extends SettingState {
  final String tableDate;

  const SuccessGetTableDataSettingState(this.tableDate);
}

final class FailedGetTableDataSettingState extends SettingState {
  final String message;

  const FailedGetTableDataSettingState(this.message);
}

final class LoadingDeleteTableDataSettingState extends SettingState {}

final class SuccessDeleteTableDataSettingState extends SettingState {
  final String message;

  const SuccessDeleteTableDataSettingState(this.message);
}

final class FailedDeleteTableDataSettingState extends SettingState {
  final String message;

  const FailedDeleteTableDataSettingState(this.message);
}
