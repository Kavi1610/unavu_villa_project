class Bill {
  String? email;
  int tableId;
  int orderId;
  int status;
  String updatedAt;
  int branchId;
  String location;
  int orderType;
  int floorId;
  String address;
  String? deletedAt;
  String numberOfPeople;
  int printerId;
  String customerGSTIN;
  bool isDeleted;
  double discountAmount;
  String captainName;
  int orderBy;
  int paymentMethod;
  double totalAmount;
  String waiterName;
  String customerName;
  double grandTotal;
  String notes;
  String customerMobile;
  int id;
  String? billNo;
  String createdAt;

  Bill({
    this.email,
    required this.tableId,
    required this.orderId,
    required this.status,
    required this.updatedAt,
    required this.branchId,
    required this.location,
    required this.orderType,
    required this.floorId,
    required this.address,
    this.deletedAt,
    required this.numberOfPeople,
    required this.printerId,
    this.customerGSTIN = '',
    required this.isDeleted,
    required this.discountAmount,
    required this.captainName,
    required this.orderBy,
    required this.paymentMethod,
    required this.totalAmount,
    required this.waiterName,
    required this.customerName,
    required this.grandTotal,
    this.notes = '',
    required this.customerMobile,
    required this.id,
    this.billNo,
    required this.createdAt,
  });

  factory Bill.fromJson(Map<String, dynamic> json) {
    return Bill(
      email: json['email'],
      tableId: json['tableid'],
      orderId: json['orderid'],
      status: json['status'],
      updatedAt: json['updated_at'],
      branchId: json['branchid'],
      location: json['location'],
      orderType: json['ordertype'],
      floorId: json['floorid'],
      address: json['address'],
      deletedAt: json['deleted_at'],
      numberOfPeople: json['numberofpeople'],
      printerId: json['printerid'],
      customerGSTIN: json['customerGSTIN'],
      isDeleted: json['is_deleted'],
      discountAmount: json['discountamount'].toDouble(),
      captainName: json['captainname'],
      orderBy: json['order_by'],
      paymentMethod: json['paymentmethod'],
      totalAmount: json['totalamount'].toDouble(),
      waiterName: json['waitername'],
      customerName: json['customername'],
      grandTotal: json['grandtotal'].toDouble(),
      notes: json['knotes'],
      customerMobile: json['customemobile'],
      id: json['id'],
      billNo: json['billno'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'tableid': tableId,
      'orderid': orderId,
      'status': status,
      'updated_at': updatedAt,
      'branchid': branchId,
      'location': location,
      'ordertype': orderType,
      'floorid': floorId,
      'address': address,
      'deleted_at': deletedAt,
      'numberofpeople': numberOfPeople,
      'printerid': printerId,
      'customerGSTIN': customerGSTIN,
      'is_deleted': isDeleted,
      'discountamount': discountAmount,
      'captainname': captainName,
      'order_by': orderBy,
      'paymentmethod': paymentMethod,
      'totalamount': totalAmount,
      'waitername': waiterName,
      'customername': customerName,
      'grandtotal': grandTotal,
      'knotes': notes,
      'customemobile': customerMobile,
      'id': id,
      'billno': billNo,
      'created_at': createdAt,
    };
  }
}
