class OrderResponseModel {
  final bool status;
  final OrderData data;
  final String message;

  OrderResponseModel({
    required this.status,
    required this.data,
    required this.message,
  });

  factory OrderResponseModel.fromJson(Map<String, dynamic> json) {
    return OrderResponseModel(
      status: json['status'],
      data: OrderData.fromJson(json['data']),
      message: json['message'],
    );
  }
}

class OrderData {
  final int ordertype;
  final int status;
  final int tableid;
  final String numberofpeople;
  final String captainname;
  final String waitername;
  final String customername;
  final String customermobile;
  final String email;
  final String location;
  final String address;
  final String customerGSTIN;
  final int order_by;
  final int paymentmethod;
  final String knotes;

  OrderData({
    required this.ordertype,
    required this.status,
    required this.tableid,
    required this.numberofpeople,
    required this.captainname,
    required this.waitername,
    required this.customername,
    required this.customermobile,
    required this.email,
    required this.location,
    required this.address,
    required this.customerGSTIN,
    required this.order_by,
    required this.paymentmethod,
    required this.knotes,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      ordertype: json['ordertype'],
      status: json['status'],
      tableid: json['tableid'],
      numberofpeople: json['numberofpeople'],
      captainname: json['captainname'],
      waitername: json['waitername'],
      customername: json['customername'],
      customermobile: json['customemobile'],
      email: json['email'],
      location: json['location'],
      address: json['address'],
      customerGSTIN: json['customerGSTIN'],
      order_by: json['order_by'],
      paymentmethod: json['paymentmethod'],
      knotes: json['knotes'],
    );
  }
}
