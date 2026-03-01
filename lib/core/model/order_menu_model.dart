// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:i_cash/core/entities/order_menu_entities.dart';

class OrderMenuModel implements OrderMenuEntities {
  @override
  String? createdAt;

  @override
  String? drinkOrder;

  @override
  String? employeeName;

  @override
  String? employeeRole;

  @override
  String? foodOrder;

  @override
  int? id;

  @override
  String? noTaxPrice;

  @override
  String? orderDate;

  @override
  String? orderId;

  @override
  String? sendAt;

  @override
  String? sendStatus;

  @override
  String? serviceAndTax;

  @override
  String? status;

  @override
  String? totalPrice;

  @override
  String? updateAt;
  OrderMenuModel({
    this.createdAt,
    this.drinkOrder,
    this.employeeName,
    this.employeeRole,
    this.foodOrder,
    this.id,
    this.noTaxPrice,
    this.orderDate,
    this.orderId,
    this.sendAt,
    this.sendStatus,
    this.serviceAndTax,
    this.status,
    this.totalPrice,
    this.updateAt,
  });

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();

  OrderMenuModel copyWith({
    String? createdAt,
    String? drinkOrder,
    String? employeeName,
    String? employeeRole,
    String? foodOrder,
    int? id,
    String? noTaxPrice,
    String? orderDate,
    String? orderId,
    String? sendAt,
    String? sendStatus,
    String? serviceAndTax,
    String? status,
    String? totalPrice,
    String? updateAt,
  }) {
    return OrderMenuModel(
      createdAt: createdAt ?? this.createdAt,
      drinkOrder: drinkOrder ?? this.drinkOrder,
      employeeName: employeeName ?? this.employeeName,
      employeeRole: employeeRole ?? this.employeeRole,
      foodOrder: foodOrder ?? this.foodOrder,
      id: id ?? this.id,
      noTaxPrice: noTaxPrice ?? this.noTaxPrice,
      orderDate: orderDate ?? this.orderDate,
      orderId: orderId ?? this.orderId,
      sendAt: sendAt ?? this.sendAt,
      sendStatus: sendStatus ?? this.sendStatus,
      serviceAndTax: serviceAndTax ?? this.serviceAndTax,
      status: status ?? this.status,
      totalPrice: totalPrice ?? this.totalPrice,
      updateAt: updateAt ?? this.updateAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'createdAt': createdAt,
      'drinkOrder': drinkOrder,
      'employeeName': employeeName,
      'employeeRole': employeeRole,
      'foodOrder': foodOrder,
      'id': id,
      'noTaxPrice': noTaxPrice,
      'orderDate': orderDate,
      'orderId': orderId,
      'sendAt': sendAt,
      'sendStatus': sendStatus,
      'serviceAndTax': serviceAndTax,
      'status': status,
      'totalPrice': totalPrice,
      'updateAt': updateAt,
    };
  }

  factory OrderMenuModel.fromMap(Map<String, dynamic> map) {
    return OrderMenuModel(
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      drinkOrder: map['drinkOrder'] != null
          ? map['drinkOrder'] as String
          : null,
      employeeName: map['employeeName'] != null
          ? map['employeeName'] as String
          : null,
      employeeRole: map['employeeRole'] != null
          ? map['employeeRole'] as String
          : null,
      foodOrder: map['foodOrder'] != null ? map['foodOrder'] as String : null,
      id: map['id'] != null ? map['id'] as int : null,
      noTaxPrice: map['noTaxPrice'] != null
          ? map['noTaxPrice'] as String
          : null,
      orderDate: map['orderDate'] != null ? map['orderDate'] as String : null,
      orderId: map['orderId'] != null ? map['orderId'] as String : null,
      sendAt: map['sendAt'] != null ? map['sendAt'] as String : null,
      sendStatus: map['sendStatus'] != null
          ? map['sendStatus'] as String
          : null,
      serviceAndTax: map['serviceAndTax'] != null
          ? map['serviceAndTax'] as String
          : null,
      status: map['status'] != null ? map['status'] as String : null,
      totalPrice: map['totalPrice'] != null
          ? map['totalPrice'] as String
          : null,
      updateAt: map['updateAt'] != null ? map['updateAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderMenuModel.fromJson(String source) =>
      OrderMenuModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderMenuModel(createdAt: $createdAt, drinkOrder: $drinkOrder, employeeName: $employeeName, employeeRole: $employeeRole, foodOrder: $foodOrder, id: $id, noTaxPrice: $noTaxPrice, orderDate: $orderDate, orderId: $orderId, sendAt: $sendAt, sendStatus: $sendStatus, serviceAndTax: $serviceAndTax, status: $status, totalPrice: $totalPrice, updateAt: $updateAt)';
  }

  @override
  bool operator ==(covariant OrderMenuModel other) {
    if (identical(this, other)) return true;

    return other.createdAt == createdAt &&
        other.drinkOrder == drinkOrder &&
        other.employeeName == employeeName &&
        other.employeeRole == employeeRole &&
        other.foodOrder == foodOrder &&
        other.id == id &&
        other.noTaxPrice == noTaxPrice &&
        other.orderDate == orderDate &&
        other.orderId == orderId &&
        other.sendAt == sendAt &&
        other.sendStatus == sendStatus &&
        other.serviceAndTax == serviceAndTax &&
        other.status == status &&
        other.totalPrice == totalPrice &&
        other.updateAt == updateAt;
  }

  @override
  int get hashCode {
    return createdAt.hashCode ^
        drinkOrder.hashCode ^
        employeeName.hashCode ^
        employeeRole.hashCode ^
        foodOrder.hashCode ^
        id.hashCode ^
        noTaxPrice.hashCode ^
        orderDate.hashCode ^
        orderId.hashCode ^
        sendAt.hashCode ^
        sendStatus.hashCode ^
        serviceAndTax.hashCode ^
        status.hashCode ^
        totalPrice.hashCode ^
        updateAt.hashCode;
  }
}
