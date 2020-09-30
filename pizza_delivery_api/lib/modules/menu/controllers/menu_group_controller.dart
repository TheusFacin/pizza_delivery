import 'package:injectable/injectable.dart';
import 'package:pizza_delivery_api/modules/menu/controllers/models/register_menu_group_rq.dart';
import 'package:pizza_delivery_api/modules/menu/services/i_menu_service.dart';
import 'package:pizza_delivery_api/modules/menu/view_models/register_menu_group_input_model.dart';
import 'package:pizza_delivery_api/pizza_delivery_api.dart';

@Injectable()
class MenuGroupController extends ResourceController {

  final IMenuService _service;

  MenuGroupController(this._service);

  @Operation.get()
  Future<Response> findALl() async {
    final menus = await _service.getAllMenus();
    return Response.ok(menus.map((e) => e.toJson()).toList());
  }

  @Operation.post()
  Future<Response> registerMenuGroup(@Bind.body() RegisterMenuGroupRq registerRq) async {
    try {
      final registerInput = mapper(registerRq);
      await _service.registerMenuGroup(registerInput);
      return Response.ok({
        'message': 'Grupo criado com sucesso'
      });
    } catch (e) {
      print(e);
      return Response.serverError(body: {
        'message': 'Erro ao registrar novo grupo'
      });
    }
  }

  RegisterMenuGroupInputModel mapper(RegisterMenuGroupRq registerMenuGroupRq) {
    return RegisterMenuGroupInputModel(
      name: registerMenuGroupRq.name
    );
  }
}