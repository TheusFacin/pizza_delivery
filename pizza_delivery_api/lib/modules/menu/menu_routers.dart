import 'package:get_it/get_it.dart';
import 'package:pizza_delivery_api/application/routers/i_router_configure.dart';
import 'package:pizza_delivery_api/modules/menu/controllers/menu_group_controller.dart';
import 'package:pizza_delivery_api/modules/menu/controllers/menu_item_controller.dart';
import 'package:pizza_delivery_api/pizza_delivery_api.dart';

class MenuRouters implements IRouterConfigure {
  @override
  void configure(Router router) {
    router
      .route('/menus')
      .link(() => GetIt.I.get<MenuGroupController>());
    router
      .route('/menus/items')
      .link(() => GetIt.I.get<MenuItemController>());
  }
  
}