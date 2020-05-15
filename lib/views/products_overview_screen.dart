import 'package:flutter/material.dart';
import 'package:shopapp/data/dummy_data.dart';
import 'package:shopapp/models/product.dart';
import 'package:shopapp/widgets/product_item.dart';

class ProductsOverviewScreen extends StatelessWidget {
  final List<Product> loadedProducts = DUMMY_PRODUCTS;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minha Loja"),
      ),
      body: GridView.builder(
        itemCount: loadedProducts.length,
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //quantidade por linha
          crossAxisCount: 2,
          
          childAspectRatio: 3 / 2,
          //spacing
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,

        ),
        itemBuilder: (ctx, index) => ProductItem(loadedProducts[index]),
      ),
    );
  }
}
