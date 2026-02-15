part of 'setting_bloc.dart';

abstract class SettingState extends Equatable {
  const SettingState();

  @override
  List<Object> get props => [];
}

class SettingInitial extends SettingState {}

final class LoadingSyncMenuDataSettingState extends SettingState {}

final class SuccessSyncMenuDataSettingState extends SettingState {
  final String message;

  const SuccessSyncMenuDataSettingState(this.message);
}

final class FailedSyncMenuDataSettingState extends SettingState {
  final String message;

  const FailedSyncMenuDataSettingState(this.message);
}
