class OrderModel {
  String orderId;
  String orderDate;
  String serviceName;
  String address;
  String price;
  String area;
  String status;

  OrderModel({
    required this.orderId,
    required this.orderDate,
    required this.serviceName,
    required this.address,
    required this.price,
    required this.area,
    required this.status,
  });
}
