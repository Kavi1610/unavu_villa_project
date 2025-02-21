class InvoicePay {
  // Define your properties here
  double totalAmount;
  double tax;
  double discountAmount;
  double roundOff;
  double grandTotal;
  String address;
  int orderType;
  int status;
  int tableId;
  String numberOfPeople;
  String captainName;
  String waiterName;
  String customerName;
  String customerMobile;
  String email;
  String location;
  String customerGSTIN;
  String notes;
  int orderBy;
  int branchId;
  int printerId;
  int floorId;
  int order;

  InvoicePay(
      {required this.totalAmount,
      required this.tax,
      required this.discountAmount,
      required this.roundOff,
      required this.grandTotal,
      required this.address,
      required this.orderType,
      required this.status,
      required this.tableId,
      required this.numberOfPeople,
      required this.captainName,
      required this.waiterName,
      required this.customerName,
      required this.customerMobile,
      required this.email,
      required this.location,
      required this.customerGSTIN,
      required this.notes,
      required this.orderBy,
      required this.branchId,
      required this.printerId,
      required this.floorId,
      required this.order});
}
