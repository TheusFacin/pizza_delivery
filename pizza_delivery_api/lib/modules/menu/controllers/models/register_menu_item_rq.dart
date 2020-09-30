import 'package:aqueduct/aqueduct.dart';

class RegisterMenuItemRq extends Serializable {

  String name;
  int groupId;
  double price;

  @override
  Map<String, dynamic> asMap() {
    return {
      'name': name,
      'groupId': groupId,
      'price': price
    };
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    name = object['name'] as String;
    groupId = object['groupId'] as int;
    price = object['price'] as double;
  }
}