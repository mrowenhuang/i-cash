// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class OrderMenuEntities extends Equatable {
  int? id;
  String? orderId;
  String? orderDate;
  String? employeeName;
  String? employeeRole;
  String? foodOrder;
  String? drinkOrder;
  String? serviceAndTax;
  String? noTaxPrice;
  
  String? totalPrice;
  String? status;
  String? sendStatus;
  String? createdAt;
  String? sendAt;
  String? updateAt;

  OrderMenuEntities({
    this.orderId,
    this.orderDate,
    this.employeeName,
    this.employeeRole,
    this.foodOrder,
    this.drinkOrder,
    this.serviceAndTax,
    this.noTaxPrice,
    this.totalPrice,
    this.status,
    this.sendStatus,
    this.createdAt,
    this.sendAt,
    this.updateAt,
    this.id,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    orderId,
    orderDate,
    employeeName,
    employeeRole,
    foodOrder,
    drinkOrder,
    serviceAndTax,
    noTaxPrice,
    totalPrice,
    status,
    sendStatus,
    createdAt,
    sendAt,
    updateAt,
  ];
}
