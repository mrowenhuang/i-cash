// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:i_cash/features/auth/domain/entities/user_login_entities.dart';

class UserLogin implements UserLoginEntities {
  @override
  String? createdAt;

  @override
  String? email;

  @override
  String? idPerangkat;

  @override
  String? password;

  @override
  String? username;

  @override
  String? activeAccount;

  @override
  String? startDate;
  
  UserLogin({
    this.createdAt,
    this.email,
    this.idPerangkat,
    this.password,
    this.username,
    this.activeAccount,
    this.startDate,
  });

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();

  UserLogin copyWith({
    String? createdAt,
    String? email,
    String? idPerangkat,
    String? password,
    String? username,
    String? activeAccount,
    String? startDate,
  }) {
    return UserLogin(
      createdAt: createdAt ?? this.createdAt,
      email: email ?? this.email,
      idPerangkat: idPerangkat ?? this.idPerangkat,
      password: password ?? this.password,
      username: username ?? this.username,
      activeAccount: activeAccount ?? this.activeAccount,
      startDate: startDate ?? this.startDate,
    );
  }

  @override
  String toString() {
    return 'UserLogin(createdAt: $createdAt, email: $email, idPerangkat: $idPerangkat, password: $password, username: $username, activeAccount: $activeAccount, startDate: $startDate)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'createdAt': createdAt,
      'email': email,
      'idPerangkat': idPerangkat,
      'password': password,
      'username': username,
      'activeAccount': activeAccount,
      'startDate': startDate,
    };
  }

  factory UserLogin.fromMap(Map<String, dynamic> map) {
    return UserLogin(
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      idPerangkat: map['idPerangkat'] != null ? map['idPerangkat'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      activeAccount: map['activeAccount'] != null ? map['activeAccount'] as String : null,
      startDate: map['startDate'] != null ? map['startDate'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserLogin.fromJson(String source) =>
      UserLogin.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant UserLogin other) {
    if (identical(this, other)) return true;
  
    return 
      other.createdAt == createdAt &&
      other.email == email &&
      other.idPerangkat == idPerangkat &&
      other.password == password &&
      other.username == username &&
      other.activeAccount == activeAccount &&
      other.startDate == startDate;
  }

  @override
  int get hashCode {
    return createdAt.hashCode ^
      email.hashCode ^
      idPerangkat.hashCode ^
      password.hashCode ^
      username.hashCode ^
      activeAccount.hashCode ^
      startDate.hashCode;
  }
}
