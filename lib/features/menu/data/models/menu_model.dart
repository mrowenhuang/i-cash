// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:i_cash/features/menu/domain/entities/menu_entities.dart';

class MenuModel implements MenuEntities {
  @override
  String? capitalPrice;

  @override
  String? createdAt;

  @override
  String? groupName;

  @override
  String? image;

  @override
  String? name;

  @override
  String? sellPrice;

  @override
  String? status;

  @override
  String? uomPrice;

  @override
  String? updatedAt;

  @override
  String? idMenu;
  MenuModel({
    this.capitalPrice,
    this.createdAt,
    this.groupName,
    this.image,
    this.name,
    this.sellPrice,
    this.status,
    this.uomPrice,
    this.updatedAt,
    this.idMenu,
  });

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();

  MenuModel copyWith({
    String? capitalPrice,
    String? createdAt,
    String? groupName,
    String? image,
    String? name,
    String? sellPrice,
    String? status,
    String? uomPrice,
    String? updatedAt,
    String? idMenu,
  }) {
    return MenuModel(
      capitalPrice: capitalPrice ?? this.capitalPrice,
      createdAt: createdAt ?? this.createdAt,
      groupName: groupName ?? this.groupName,
      image: image ?? this.image,
      name: name ?? this.name,
      sellPrice: sellPrice ?? this.sellPrice,
      status: status ?? this.status,
      uomPrice: uomPrice ?? this.uomPrice,
      updatedAt: updatedAt ?? this.updatedAt,
      idMenu: idMenu ?? this.idMenu,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'capitalPrice': capitalPrice,
      'createdAt': createdAt,
      'groupName': groupName,
      'image': image,
      'name': name,
      'sellPrice': sellPrice,
      'status': status,
      'uomPrice': uomPrice,
      'updatedAt': updatedAt,
      'idMenu': idMenu,
    };
  }

  factory MenuModel.fromMap(Map<String, dynamic> map) {
    return MenuModel(
      capitalPrice: map['capitalPrice'] != null ? map['capitalPrice'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      groupName: map['groupName'] != null ? map['groupName'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      sellPrice: map['sellPrice'] != null ? map['sellPrice'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      uomPrice: map['uomPrice'] != null ? map['uomPrice'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
      idMenu: map['idMenu'] != null ? map['idMenu'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MenuModel.fromJson(String source) =>
      MenuModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MenuModel(capitalPrice: $capitalPrice, createdAt: $createdAt, groupName: $groupName, image: $image, name: $name, sellPrice: $sellPrice, status: $status, uomPrice: $uomPrice, updatedAt: $updatedAt, idMenu: $idMenu)';
  }

  @override
  bool operator ==(covariant MenuModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.capitalPrice == capitalPrice &&
      other.createdAt == createdAt &&
      other.groupName == groupName &&
      other.image == image &&
      other.name == name &&
      other.sellPrice == sellPrice &&
      other.status == status &&
      other.uomPrice == uomPrice &&
      other.updatedAt == updatedAt &&
      other.idMenu == idMenu;
  }

  @override
  int get hashCode {
    return capitalPrice.hashCode ^
      createdAt.hashCode ^
      groupName.hashCode ^
      image.hashCode ^
      name.hashCode ^
      sellPrice.hashCode ^
      status.hashCode ^
      uomPrice.hashCode ^
      updatedAt.hashCode ^
      idMenu.hashCode;
  }
}
