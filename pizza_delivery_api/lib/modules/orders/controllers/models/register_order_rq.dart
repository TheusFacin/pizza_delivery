import 'package:aqueduct/aqueduct.dart';

class RegisterOrderRq extends Serializable {

  int userId;
  String address;
  String paymentType;
  List<int> itemsIds;

  @override
  Map<String, dynamic> asMap() {
    return {
      'userId': userId,
      'address': address,
      'paymentType': paymentType,
      'itemsIds': itemsIds,
    };
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    userId = object['userId'] as int;
    address = object['address'] as String;
    paymentType = object['paymentType'] as String;
    itemsIds = (object['itemsIds'] as List).cast();
  }
}