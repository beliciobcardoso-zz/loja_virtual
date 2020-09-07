import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual/models/product_manager.dart';
import 'package:loja_virtual/screens/products/components/product_list_tile.dart';
import 'package:loja_virtual/screens/products/components/search_dalog.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text('Produtos'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final search = await showDialog<String>(
                context: context,
                builder: (context) => SearchDialog(),
              );
              if (search != null) {
                context.read<ProductManager>().search = search;
              }
            },
          ),
        ],
      ),
      body: Consumer<ProductManager>(builder: (_, productManager, __) {
        final filteredProducts = productManager.filteredProducts;
        return ListView.builder(
          padding: const EdgeInsets.all(4),
          itemCount: filteredProducts.length,
          itemBuilder: (_, index) {
            return ProductListTile(filteredProducts[index]);
          },
        );
      }),
    );
  }
}
