import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './product.dart';

class Products with ChangeNotifier {
  final String _url = 'https://shopapp-9a338.firebaseio.com/products.json';

  List<Product> _items = [];

  List<Product> get items => [..._items];

  List<Product> get favoriteItems {
    return _items.where((prod) => prod.isFavorite).toList();
  }

  Future<void> loadProducts() async {
    final response = await http.get(
      _url,
    );
//    return null;
    Map<String, dynamic> data = json.decode(response.body);
    if (data != null) {
      _items.clear();
      data.forEach((prodId, productData) {
        _items.add(
          Product(
            id: prodId,
            title: productData['title'],
            description: productData['description'],
            price: productData['price'],
            isFavorite: productData['isFavorite'],
            imageUrl: productData['imageUrl'],
          ),
        );
      });
      notifyListeners();
    }
    return Future.value();
  }

  Future<void> addProduct(Product product) async {
    final response = await http.post(
      _url,
      body: jsonEncode(
        {
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'isFavorite': product.isFavorite,
        },
      ),
    );
    _items.add(Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl));
    notifyListeners();
    return response;
/*     return http
        .post(
      url,
      body: jsonEncode(
        {
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'isFavorite': product.isFavorite,
        },
      ),
    )
        .then((response) {
      print(json.decode(response.body));
      //add produts on screen
      _items.add(Product(
          id: Random().nextDouble().toString(),
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl));
      notifyListeners();
    }); */ /* .catchError((er) {
      print(er);
      throw er;
    }); */
  }

  void updateProduct(Product product) {
    if (product == null || product.id == null) {
      return;
    }
    final index = _items.indexWhere((prod) => prod.id == product.id);
    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    final index = _items.indexWhere((prod) => prod.id == id);
    if (index >= 0) {
      _items.removeWhere((prod) => prod.id == id);
      notifyListeners();
    }
  }

  int get itemsCount => _items.length;
}

// bool _showFavoriteOnly = false;

// void showFavoriteOnly() {
//   _showFavoriteOnly = true;
//   notifyListeners();

// }
// void showAll() {
//   _showFavoriteOnly = false;
//   notifyListeners();
// }
