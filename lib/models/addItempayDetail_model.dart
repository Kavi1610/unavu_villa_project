class InvoicePay {
  // Define your properties here
  double totalAmount;
  double tax;

  double discountAmount;
  double roundOff;
  double grandTotal;

  InvoicePay({
    required this.totalAmount,
    required this.tax,
    required this.discountAmount,
    required this.roundOff,
    required this.grandTotal,
  });
}
