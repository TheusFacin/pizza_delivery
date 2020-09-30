import 'package:json_annotation/json_annotation.dart';
import 'package:pizza_delivery_api/application/entities/menu_item.dart';

part 'order_item.g.dart';

@JsonSerializable()
class OrderItem {

  final int id;
  final MenuItem item;

  OrderItem({this.id, this.item});

  factory OrderItem.fromJson(Map<String, dynamic> json) => _$OrderItemFromJson(json);
  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}