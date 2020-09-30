import 'package:injectable/injectable.dart';
import 'package:pizza_delivery_api/application/exceptions/user_already_exists_exception.dart';
import 'package:pizza_delivery_api/modules/users/controllers/models/register_user_rq.dart';
import 'package:pizza_delivery_api/modules/users/services/i_user_service.dart';
import 'package:pizza_delivery_api/modules/users/view_models/register_user_input_model.dart';
import 'package:pizza_delivery_api/pizza_delivery_api.dart';

@Injectable()
class RegisterUserController extends ResourceController {

  final IUserService _service;

  RegisterUserController(this._service);
  
  @Operation.post()
  Future<Response> registerUser(@Bind.body() RegisterUserRq registerRq) async {
    try {
      final registerInput = mapper(registerRq);
      await _service.registerUser(registerInput);
      return Response.ok({
        'message': 'Usuário criado com sucesso'
      });
    } on UserAlreadyExistsException catch (e) {
      print(e);
      return Response.conflict(body: {
        'message': 'Usuário já existe'
      });
    } catch (e) {
      print(e);
      return Response.serverError(body: {
        'message': 'Erro ao registrar novo usuário'
      });
    }
  }

  RegisterUserInputModel mapper(RegisterUserRq registerUserRq) {
    return RegisterUserInputModel(
      name: registerUserRq.name,
      email: registerUserRq.email,
      password: registerUserRq.password
    );
  }

}