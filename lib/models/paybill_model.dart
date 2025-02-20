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
}
