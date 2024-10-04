import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shopping_bag_app/models/product.dart';
import 'package:shopping_bag_app/screens/update_product_screen.dart';
//
class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.product,
    this.onDelete,  // Callback function
  });

  final Product product;
  final VoidCallback ? onDelete ;  // Define callback for deletion

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      tileColor: Colors.white,
      title: Text(product.productName),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Product Code: ${product.productCode}'),
          Text('Price: \$${product.unitPrice}'),
          Text('Quantity: ${product.quantity}'),
          Text('Total Price: \$${product.totalPrice}'),
          const Divider(),
          ButtonBar(
            children: [
              TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return UpdateProductScreen(product: product);
                    }),
                  );
                },
                icon: const Icon(Icons.edit),
                label: const Text('Edit'),
              ),
              TextButton.icon(
                onPressed: () {
                  DeleteProduct(context, product).then((_) {
                    onDelete!();  // Call the onDelete callback after deletion
                  });
                },
                icon: const Icon(
                  Icons.delete_outlined,
                  color: Colors.red,
                ),
                label: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Future<void> DeleteProduct(BuildContext context, Product product) async {
  print('Requesting');
  Uri uri = Uri.parse('http://152.42.163.176:2008/api/v1/DeleteProduct/${product.id}');
  Response response = await get(uri);

  if (response.statusCode == 200) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Product deleted successfully')),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Failed to delete product')),
    );
  }
}