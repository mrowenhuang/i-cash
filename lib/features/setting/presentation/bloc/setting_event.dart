part of 'setting_bloc.dart';

abstract class SettingEvent extends Equatable {
  const SettingEvent();

  @override
  List<Object> get props => [];
}

final class AddTaxDataSettingEvent extends SettingEvent {
  final String taxName;
  final String taxPercent;

  const AddTaxDataSettingEvent(this.taxName, this.taxPercent);
}

final class GetTaxDataSettingEvent extends SettingEvent {}

final class AddNumberOftableSettingEvent extends SettingEvent {
  final String numberOfTable;

  const AddNumberOftableSettingEvent(this.numberOfTable);
}