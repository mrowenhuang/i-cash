import 'package:equatable/equatable.dart';
import 'package:i_cash/features/menu/domain/entities/menu_entities.dart';

class OrderItemEntites extends Equatable {
  final MenuEntities menu;
  final int quantity;

  const OrderItemEntites({required this.menu, required this.quantity});

  OrderItemEntites copyWith({int? quantity}) {
    return OrderItemEntites(menu: menu, quantity: quantity ?? this.quantity);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [menu, quantity];
}
