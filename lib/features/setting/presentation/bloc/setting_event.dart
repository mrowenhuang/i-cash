part of 'setting_bloc.dart';

abstract class SettingEvent extends Equatable {
  const SettingEvent();

  @override
  List<Object> get props => [];
}

final class SyncMenuDataSettingEvent extends SettingEvent {
  final UserLoginEntities userLoginEntities;

  const SyncMenuDataSettingEvent(this.userLoginEntities);
}
