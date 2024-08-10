import 'package:demo_practice_firestore/model/product_model.dart';
import 'package:demo_practice_firestore/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateScreen extends StatefulWidget {
  final ProductModel product;

  const UpdateScreen({super.key, required this.product});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  late TextEditingController _productNameController = TextEditingController();
  late TextEditingController _priceController = TextEditingController();
  late  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _productNameController = TextEditingController(text: widget.product.productName);
    _priceController = TextEditingController(text: widget.product.productPrice);
    _descriptionController = TextEditingController(text: widget.product.productDesc);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _productNameController,
                decoration: const InputDecoration(labelText: 'Product name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter product name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter price';
                  }
                  if (int.tryParse(value) == null || int.parse(value) <= 0) {
                    return 'Please enter price';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ProductModel updatedProduct = ProductModel(
                      productId: widget.product.productId,
                      productName: _productNameController.text,
                      productPrice: _priceController.text,
                      productDesc: _descriptionController.text,
                    );
                    Provider.of<ProductProvider>(context, listen: false)
                        .updateProduct(updatedProduct);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Product updated successfully')),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
