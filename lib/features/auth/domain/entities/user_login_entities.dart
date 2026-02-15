// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class UserLoginEntities extends Equatable {
  String? username;
  String? password;
  String? idPerangkat;
  String? email;
  String? createdAt;
  String? startDate;
  String? activeAccount;

  UserLoginEntities({
    this.username,
    this.password,
    this.idPerangkat,
    this.email,
    this.createdAt,
    this.startDate,
    this.activeAccount,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    username,
    email,
    password,
    idPerangkat,
    createdAt,
    startDate,
    activeAccount,
  ];
}
