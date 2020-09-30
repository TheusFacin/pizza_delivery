import 'package:injectable/injectable.dart';
import 'package:mysql1/mysql1.dart';
import 'package:pizza_delivery_api/application/database/i_database_connection.dart';
import 'package:pizza_delivery_api/application/entities/menu.dart';
import 'package:pizza_delivery_api/application/entities/menu_item.dart';
import 'package:pizza_delivery_api/application/exceptions/database_error_exception.dart';
import 'package:pizza_delivery_api/modules/menu/data/i_menu_repository.dart';
import 'package:pizza_delivery_api/modules/menu/view_models/register_menu_group_input_model.dart';
import 'package:pizza_delivery_api/modules/menu/view_models/register_menu_item_input_model.dart';

@LazySingleton(as: IMenuRepository)
class MenuRepository implements IMenuRepository {

  final IDatabaseConnection _connection;

  MenuRepository(this._connection);

  @override
  Future<List<Menu>> findAll() async {
    final conn = await _connection.openConnection();

    try {
      final result = await conn.query('SELECT * FROM cardapio_grupo');

      if (result.isNotEmpty) {
        final menus = result.map<Menu>((row) {
          final fields = row.fields;

          return Menu(
            id: fields['id_cardapio_grupo'] as int,
            name: fields['nome_grupo'] as String
          );
        }).toList();

        for (var menu in menus) {
          final resultItems = await conn.query(
            'SELECT * FROM cardapio_grupo_item WHERE id_cardapio_grupo = ?',
            [menu.id]
          );

          if (resultItems.isNotEmpty) {
            final items = resultItems.map((row) {
              final fields = row.fields;
              return MenuItem(
                id: fields['id_cardapio_grupo_item'] as int,
                name: fields['nome'] as String,
                price: fields['valor'] as double
              );
            }).toList();
            menu.items = items;
          }
        }

        return menus;
      }

      return [];
    } on MySqlException catch (e) {
      print(e);
      throw DatabaseErrorException();
    } finally {
      await conn?.close();
    }
  }

  @override
  Future<void> saveGroup(RegisterMenuGroupInputModel inputModel) async {
    final conn = await _connection.openConnection();

    try {
      await conn.query(
        'insert cardapio_grupo (nome_grupo) values (?)',
        [inputModel.name]
      );
    } on MySqlConnection catch (e) {
      print(e);
      throw DatabaseErrorException(message: 'Erro ao registrar grupo');
    } finally {
      await conn?.close();
    }
  }

  @override
  Future<void> saveItem(RegisterMenuItemInputModel inputModel) async {
    final conn = await _connection.openConnection();

    try {
      await conn.query(
        'insert cardapio_grupo_item (id_cardapio_grupo, nome, valor) values (?,?,?)',
        [inputModel.groupId, inputModel.name, inputModel.price]
      );
    } on MySqlConnection catch (e) {
      print(e);
      throw DatabaseErrorException(message: 'Erro ao registrar item');
    } finally {
      await conn?.close();
    }
  }
  
}