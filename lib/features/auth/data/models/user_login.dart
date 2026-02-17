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

  @override
  String? address;

  @override
  String? brand;

  @override
  String? status;
  
  @override
  String? userRole;

  UserLogin({
    this.createdAt,
    this.email,
    this.idPerangkat,
    this.password,
    this.username,
    this.activeAccount,
    this.startDate,
    this.address,
    this.brand,
    this.status,
    this.userRole,
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
    String? address,
    String? brand,
    String? status,
    String? userRole,
  }) {
    return UserLogin(
      createdAt: createdAt ?? this.createdAt,
      email: email ?? this.email,
      idPerangkat: idPerangkat ?? this.idPerangkat,
      password: password ?? this.password,
      username: username ?? this.username,
      activeAccount: activeAccount ?? this.activeAccount,
      startDate: startDate ?? this.startDate,
      address: address ?? this.address,
      brand: brand ?? this.brand,
      status: status ?? this.status,
      userRole: userRole ?? this.userRole,
    );
  }

  @override
  String toString() {
    return 'UserLogin(createdAt: $createdAt, email: $email, idPerangkat: $idPerangkat, password: $password, username: $username, activeAccount: $activeAccount, startDate: $startDate, address: $address, brand: $brand, status: $status, userRole: $userRole)';
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
      'address': address,
      'brand': brand,
      'status': status,
      'userRole': userRole,
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
      address: map['address'] != null ? map['address'] as String : null,
      brand: map['brand'] != null ? map['brand'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      userRole: map['userRole'] != null ? map['userRole'] as String : null,
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
      other.startDate == startDate &&
      other.address == address &&
      other.brand == brand &&
      other.status == status &&
      other.userRole == userRole;
  }

  @override
  int get hashCode {
    return createdAt.hashCode ^
      email.hashCode ^
      idPerangkat.hashCode ^
      password.hashCode ^
      username.hashCode ^
      activeAccount.hashCode ^
      startDate.hashCode ^
      address.hashCode ^
      brand.hashCode ^
      status.hashCode ^
      userRole.hashCode;
  }
}
