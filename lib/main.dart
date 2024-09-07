import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ShoppingCart(),
    );
  }
}

class Product {
  final String name;
  final String color;
  final String size;
  final int price;
  final String imageUrl;
  int quantity;

  Product({
    required this.name,
    required this.color,
    required this.size,
    required this.price,
    required this.imageUrl,
    required this.quantity,
  });
}

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key});

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  List<Product> items = [
    Product(
      name: 'Pullover',
      color: 'Black',
      size: 'L',
      price: 51,
      quantity: 1,
      imageUrl: 'https://i.ebayimg.com/images/g/kcoAAOSwYvFZOAu7/s-l1600.jpg',
    ),
    Product(
      name: 'T-Shirt',
      color: 'Gray',
      size: 'L',
      price: 30,
      quantity: 1,
      imageUrl: 'https://i.ebayimg.com/images/g/kcoAAOSwYvFZOAu7/s-l1600.jpg',
    ),
    Product(
      name: 'Sport Dress',
      color: 'Black',
      size: 'M',
      price: 43,
      quantity: 1,
      imageUrl:
          'https://m.media-amazon.com/images/I/A13usaonutL._CLa%7C2140%2C2000%7C51LKTFd1CTL.png%7C0%2C0%2C2140%2C2000%2B0.0%2C0.0%2C2140.0%2C2000.0_AC_UX679_.png',
    ),
  ];

  int getTotalAmount() {
    int total = 0;
    for (var item in items) {
      total += item.price * item.quantity;
    }
    return total;
  }

  void increaseQuantity(int index) {
    setState(() {
      items[index].quantity++;
    });
  }

  void decreaseQuantity(int index) {
    setState(() {
      if (items[index].quantity > 1) {
        items[index].quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Bag'),
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Card(
                    margin: EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            item.imageUrl,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: 16),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                    'Color: ${item.color}  Size: ${item.size}'),
                                Row(
                                  children: [
                                    // Decrease quantity button
                                    IconButton(
                                      onPressed: () => decreaseQuantity(index),
                                      icon: Icon(Icons.remove_circle_outline),
                                    ),
                                    // Display quantity
                                    Text(
                                      item.quantity.toString(),
                                      style: TextStyle(fontSize: 18),
                                    ),

                                    IconButton(
                                      onPressed: () => increaseQuantity(index),
                                      icon: Icon(Icons.add_circle_outline),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Product price
                          Text(
                            '\$${item.price}',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total amount:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '\$${getTotalAmount()}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Checkout button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 64),
              ),
              onPressed: () {
                final snackBar = SnackBar(
                    content: Text('Congratulations on your purchase!'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: Text('CHECK OUT', style: TextStyle(fontSize: 18)),
            ),


          ],
        ),
      ),
    );
  }
}
