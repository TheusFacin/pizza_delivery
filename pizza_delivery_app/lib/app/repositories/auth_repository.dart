import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pizza_delivery_app/app/exceptions/rest_exception.dart';
import 'package:pizza_delivery_app/app/models/user_model.dart';

class AuthRepository {

  Future<UserModel> login(String email, String password) async {
    String url = DotEnv().env['API_URL'] + '/users/auth';
    try {
      final response = await Dio().post(url, data: {
        'email': email,
        'password': password
      });

      return UserModel.fromMap(response.data);
    } on DioError catch (e) {
      print(e);
      String message = 'Erro ao autenticar usuário';

      if (e?.response?.statusCode == 403) {
        message = 'Usuário ou senha inválidos';
      }

      throw RestException(message);
    } catch (e) {
      print(e);
      throw e;
    }
  }
}