import 'package:flutter/material.dart';
import 'package:shopping_bag_app/screens/product_list_screen.dart';

class CurdApp extends StatelessWidget {
  const CurdApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:ProductListScreen(),
    );
  }
}
