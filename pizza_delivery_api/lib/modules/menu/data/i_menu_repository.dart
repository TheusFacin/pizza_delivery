import 'package:pizza_delivery_api/application/entities/menu.dart';
import 'package:pizza_delivery_api/modules/menu/view_models/register_menu_group_input_model.dart';
import 'package:pizza_delivery_api/modules/menu/view_models/register_menu_item_input_model.dart';

abstract class IMenuRepository {
  Future<List<Menu>> findAll();
  Future<void> saveGroup(RegisterMenuGroupInputModel inputModel);
  Future<void> saveItem(RegisterMenuItemInputModel inputModel);
}