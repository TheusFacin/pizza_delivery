import 'package:injectable/injectable.dart';
import 'package:pizza_delivery_api/modules/menu/controllers/models/register_menu_item_rq.dart';
import 'package:pizza_delivery_api/modules/menu/services/i_menu_service.dart';
import 'package:pizza_delivery_api/modules/menu/view_models/register_menu_item_input_model.dart';
import 'package:pizza_delivery_api/pizza_delivery_api.dart';

@Injectable()
class MenuItemController extends ResourceController {

  final IMenuService _service;

  MenuItemController(this._service);

  @Operation.post()
  Future<Response> registerMenuItem(@Bind.body() RegisterMenuItemRq registerRq) async {
    try {
      final registerInput = mapper(registerRq);
      await _service.registerMenuItem(registerInput);
      return Response.ok({
        'message': 'Item criado com sucesso'
      });
    } catch (e) {
      print(e);
      return Response.serverError(body: {
        'message': 'Erro ao registrar novo item'
      });
    }
  }

  RegisterMenuItemInputModel mapper(RegisterMenuItemRq registerMenuGroupRq) {
    return RegisterMenuItemInputModel(
      name: registerMenuGroupRq.name,
      groupId: registerMenuGroupRq.groupId,
      price: registerMenuGroupRq.price
    );
  }
}