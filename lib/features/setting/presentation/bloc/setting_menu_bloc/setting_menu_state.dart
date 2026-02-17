part of 'setting_menu_bloc.dart';

sealed class SettingMenuState extends Equatable {
  const SettingMenuState();

  @override
  List<Object> get props => [];
}

final class MenuInitial extends SettingMenuState {}

final class LoadingSyncMenuDataSettingState extends SettingMenuState {}

final class SuccessSyncMenuDataSettingState extends SettingMenuState {
  final String message;

  const SuccessSyncMenuDataSettingState(this.message);
}

final class FailedSyncMenuDataSettingState extends SettingMenuState {
  final String message;

  const FailedSyncMenuDataSettingState(this.message);
}
