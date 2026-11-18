
const menu = {
  'Adobo rice': 85.0,
  'Iced tea': 35.0,
  'Turon': 25.0
};

class OrderItem {
  final String name;
  final double price;
  final int qty;

  OrderItem(this.name, this.price, this.qty);

  double get subtotal => price * qty;
}

OrderItem orderOf(String name, int qty) {
  final price = menu[name];

  if (price == null) {
    throw ArgumentError('Item not found in menu: $name');
  }

  return OrderItem(name, price, qty);
}

double total(List<OrderItem> items) {
  return items.fold(0.0, (sum, item) => sum + item.subtotal);
}

void printReceipt(List<OrderItem> items, {String? customer}) {
  final name = customer ?? 'Guest';
  final subtotal = total(items);

  final discount = subtotal >= 300 ? subtotal * 0.10 : 0.0;
  final finalTotal = subtotal - discount;

  print('Order for $name');

  for (var item in items) {
    final quantity = '${item.qty} x ${item.name}'.padRight(19);
    final amount = item.subtotal.toStringAsFixed(2).padLeft(7);

    print('$quantity$amount');
  }

  print('Subtotal'.padRight(19) +
      subtotal.toStringAsFixed(2).padLeft(7));

  if (discount > 0) {
    print('Discount 10%'.padRight(19) +
        '-${discount.toStringAsFixed(2)}'.padLeft(7));
  }

  print('Total'.padRight(19) +
      finalTotal.toStringAsFixed(2).padLeft(7));

  print('');
}

void main() {
  final order1 = [
    orderOf('Adobo rice', 3),
    orderOf('Iced tea', 1),
    orderOf('Turon', 3),
  ];

  printReceipt(order1);

  final order2 = [
    orderOf('Adobo rice', 1),
    orderOf('Iced tea', 1),
  ];

  printReceipt(order2, customer: 'Camila');
}
