// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class MenuEntities extends Equatable {
  String? idMenu;
  String? capitalPrice;
  String? createdAt;
  String? groupName;
  String? image;
  String? name;
  String? sellPrice;
  String? status;
  String? uomPrice;
  String? updatedAt;

  MenuEntities({
    this.idMenu,
    this.capitalPrice,
    this.createdAt,
    this.groupName,
    this.image,
    this.name,
    this.sellPrice,
    this.status,
    this.uomPrice,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
    idMenu,
    capitalPrice,
    createdAt,
    groupName,
    image,
    name,
    sellPrice,
    status,
    uomPrice,
    updatedAt,
  ];
}
