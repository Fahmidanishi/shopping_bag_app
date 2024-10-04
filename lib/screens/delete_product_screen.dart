import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shopping_bag_app/screens/add_new_product_screen.dart';
import 'package:shopping_bag_app/widgets/product_item.dart';
import 'package:shopping_bag_app/models/product.dart';

class DeleteProductScreen extends StatefulWidget {
  const DeleteProductScreen({super.key, required this.product});
  final Product product;
  @override
  State<DeleteProductScreen> createState() => _DeleteProductScreenState();
}

class _DeleteProductScreenState extends State<DeleteProductScreen> {
  List<Product> productList = [];
  bool _inProgress = false;

  @override
  void initState() {
    super.initState();
    getProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product list'),
        actions: [
          IconButton(
            onPressed: () {
              getProductList();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: _inProgress
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.separated(
          itemCount: productList.length,
          itemBuilder: (context, index) {
            return ProductItem(
              product: productList[index],
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 16);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return const AddNewProductScreen();
            }),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

 /* Future<void> DeleteProduct(Product product) async {
    setState(() {
      _inProgress = true;
    });

    print('Requesting');
    Uri uri = Uri.parse('http://152.42.163.176:2008/api/v1/DeleteProduct/${product.id}'); // Replace with actual base URL
    Response response = await get(uri);

    //print(response);
    //print(response.statusCode);
    //print(response.body);


   /* Response Response(product ) = await get(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(requestBody),
    ); */


    if (response.statusCode == 200) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product deleted successfully')));
          } else {
      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Failed to delete product')));
      }



    setState(() {
      _inProgress = false;
    });
  } */
Future<void> getProductList() async {

}
}
