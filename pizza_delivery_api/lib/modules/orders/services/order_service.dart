import 'package:injectable/injectable.dart';
import 'package:pizza_delivery_api/application/entities/order.dart';
import 'package:pizza_delivery_api/modules/orders/data/i_order_repository.dart';
import 'package:pizza_delivery_api/modules/orders/services/i_order_service.dart';
import 'package:pizza_delivery_api/modules/orders/view_objects/save_order_input_model.dart';

@LazySingleton(as: IOrderService)
class OrderService implements IOrderService {

  final IOrderRepository _repository;

  OrderService(this._repository);

  @override
  Future<void> saveOrder(SaveOrderInputModel saveOrder) async {
    await _repository.saveOrder(saveOrder);
  }

  @override
  Future<List<Order>> findByUserId(int userId) async {
    return await _repository.findOrdersByUserId(userId);
  }
}