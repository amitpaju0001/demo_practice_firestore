import 'package:demo_practice_firestore/model/product_model.dart';
import 'package:flutter/material.dart';

class UserDetailsScreen extends StatelessWidget {
  final ProductModel product;

  const UserDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${product.productName}', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            Text('Age: ${product.productPrice}', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            Text('Address: ${product.productDesc}', style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
