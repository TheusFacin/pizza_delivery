import 'package:json_annotation/json_annotation.dart';
import 'package:pizza_delivery_api/application/entities/order_item.dart';
import 'package:pizza_delivery_api/application/entities/user.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {

  final int id;
  final String paymentMethod;
  final String address;
  final List<OrderItem> items;

  Order({this.id, this.paymentMethod, this.address, this.items});

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}