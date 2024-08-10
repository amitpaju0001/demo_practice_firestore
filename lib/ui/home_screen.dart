import 'package:demo_practice_firestore/model/product_model.dart';
import 'package:demo_practice_firestore/provider/product_provider.dart';
import 'package:demo_practice_firestore/ui/add_product_screen.dart';
import 'package:demo_practice_firestore/ui/update_screen.dart';
import 'package:demo_practice_firestore/ui/user_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProductProvider>(context, listen: false).fetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          if (productProvider.product.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: productProvider.product.length,
              itemBuilder: (context, index) {
                ProductModel product = productProvider.product[index];
                return Card(
                  margin: const EdgeInsets.all(10.0),
                  child: ListTile(
                    title: Text(product.productName),
                    subtitle: Text('Price: ${product.productPrice}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                       IconButton(
                         icon: const Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                             MaterialPageRoute(
                               builder: (context) => UpdateScreen(product: product,),
                              ),
                            );
                         },
                       ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Delete User'),
                                  content: const Text('Confirm to delete  user?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Provider.of<ProductProvider>(context, listen: false).deleteProduct(product.productId);
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Confirm'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserDetailsScreen(product: product),
                       ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddProductScreen()),
          );
          Provider.of<ProductProvider>(context, listen: false).fetchProduct();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
