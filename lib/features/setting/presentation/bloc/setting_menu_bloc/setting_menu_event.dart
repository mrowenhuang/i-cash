part of 'setting_menu_bloc.dart';

sealed class SettingMenuEvent extends Equatable {
  const SettingMenuEvent();

  @override
  List<Object> get props => [];
}

final class SyncMenuDataSettingEvent extends SettingMenuEvent {
  final UserLoginEntities userLoginEntities;

  const SyncMenuDataSettingEvent(this.userLoginEntities);
}
