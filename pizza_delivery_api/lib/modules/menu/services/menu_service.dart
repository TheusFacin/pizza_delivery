import 'package:injectable/injectable.dart';
import 'package:pizza_delivery_api/application/entities/menu.dart';
import 'package:pizza_delivery_api/modules/menu/data/i_menu_repository.dart';
import 'package:pizza_delivery_api/modules/menu/services/i_menu_service.dart';
import 'package:pizza_delivery_api/modules/menu/view_models/register_menu_group_input_model.dart';
import 'package:pizza_delivery_api/modules/menu/view_models/register_menu_item_input_model.dart';

@LazySingleton(as: IMenuService)
class MenuService implements IMenuService {

  final IMenuRepository _repository;

  MenuService(this._repository);

  @override
  Future<List<Menu>> getAllMenus() {
    return _repository.findAll();
  }

  @override
  Future<void> registerMenuGroup(RegisterMenuGroupInputModel registerInput) async {
    await _repository.saveGroup(registerInput);
  }

  @override
  Future<void> registerMenuItem(RegisterMenuItemInputModel registerInput) async {
    await _repository.saveItem(registerInput);
  }

}