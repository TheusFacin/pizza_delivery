import 'package:aqueduct/aqueduct.dart';

class RegisterMenuGroupRq extends Serializable {

  String name;

  @override
  Map<String, dynamic> asMap() {
    return { 'name': name };
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    name = object['name'] as String;
  }
}