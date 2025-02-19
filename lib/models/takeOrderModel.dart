class OrderModel {
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
  final List<OrderItemModel> items;
  final int orderBy;
  final int paymentMethod;
  final String knotes;

  OrderModel({
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
    required this.items,
    required this.orderBy,
    required this.paymentMethod,
    required this.knotes,
  });
}

class OrderItemModel {
  final int itemcode;
  final String itemname;
  final int quantity;
  final double price;
  final bool comp;
  final double total;
  final bool isDeleted;

  OrderItemModel({
    required this.itemcode,
    required this.itemname,
    required this.quantity,
    required this.price,
    required this.comp,
    required this.total,
    required this.isDeleted,
  });
}
