class OrderItem {
  final String name;
  final int quantity;
  final bool isDelivered;

  OrderItem({
    required this.name,
    required this.quantity,
    this.isDelivered = false,
  });
}
