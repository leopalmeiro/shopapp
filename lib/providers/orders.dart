import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:shopapp/providers/cart.dart';

class Order {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime date;

  Order({this.id, this.amount, this.products, this.date});
}

class Orders with ChangeNotifier {
  List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  int get itemsCount{
    return _items.length;
  }
  void addOrder(Cart cart) {
    //final total = products.fold(0.0, (total, prod) => total + (prod.price * prod.quantity));
    _items.insert(
      0,
      Order(
        id: Random().nextDouble().toString(),
        amount: cart.totalAmount,
        date: DateTime.now(),
        products: cart.items.values.toList(),
      ),
    );
    notifyListeners();
  }

}
