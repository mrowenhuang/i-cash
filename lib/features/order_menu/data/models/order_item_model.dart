import 'dart:convert';

import 'package:i_cash/features/menu/data/models/menu_model.dart';
import 'package:i_cash/features/menu/domain/entities/menu_entities.dart';
import 'package:i_cash/features/order_menu/domain/entities/order_item_entites.dart';

class OrderItemModel implements OrderItemEntites {
  @override
  final MenuModel menu;

  @override
  final int quantity;

  const OrderItemModel({required this.menu, required this.quantity});

  /// ===== ENTITY -> MODEL =====
  factory OrderItemModel.fromEntity(OrderItemEntites entity) {
    return OrderItemModel(
      menu: entity.menu as MenuModel, // ✅ langsung cast
      quantity: entity.quantity,
    );
  }

  /// ===== MAP -> MODEL =====
  factory OrderItemModel.fromMap(Map<String, dynamic> map) {
    return OrderItemModel(
      menu: MenuModel.fromMap(map['menu']),
      quantity: map['quantity'] ?? 0,
    );
  }

  /// ===== MODEL -> MAP =====
  Map<String, dynamic> toMap() {
    return {'menu': menu.toMap(), 'quantity': quantity};
  }

  /// ===== JSON =====
  String toJson() => json.encode(toMap());

  factory OrderItemModel.fromJson(String source) =>
      OrderItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  /// ===== COPY =====
  @override
  OrderItemModel copyWith({MenuEntities? menu, int? quantity}) {
    return OrderItemModel(
      menu: menu != null ? menu as MenuModel : this.menu,
      quantity: quantity ?? this.quantity,
    );
  }

  /// ===== EQUATABLE =====
  @override
  List<Object?> get props => [menu, quantity];

  @override
  bool? get stringify => true;

  @override
  String toString() => 'OrderItemModel(menu: $menu, quantity: $quantity)';
}
