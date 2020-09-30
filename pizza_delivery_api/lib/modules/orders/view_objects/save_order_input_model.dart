class SaveOrderInputModel {
  int userId;
  String address;
  String paymentType;
  List<int> itemsIds;

  SaveOrderInputModel({
    this.userId,
    this.address,
    this.paymentType,
    this.itemsIds,
  });
  
}
