class ShoppingListItem {
  final String name;
  final int quantity;
  final double price;
  bool isBought;

  ShoppingListItem({
    required this.name,
    required this.quantity,
    required this.price,
    this.isBought = false,
  });
}
