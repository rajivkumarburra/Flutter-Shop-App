import 'package:flutter/material.dart';

import '../screens/product_screen.dart';

class ProductItem extends StatelessWidget {
  final String imageURL;
  final String name;
  final int price;
  final String category;
  final String id;

  const ProductItem(
      {super.key,
      required this.imageURL,
      required this.name,
      required this.price,
      required this.category,
      required this.id});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          ProductScreen.routeName,
          arguments: [id, category],
        );
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 2),
              blurRadius: 6,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              // decoration: BoxDecoration(
              //   border: Border.all(color: Colors.deepPurple, width: 2),
              // ),
              width: MediaQuery.of(context).size.width * 0.3,
              child: Hero(tag: id, child: Image.network(imageURL)),
            ),
            const SizedBox(
              width: 20,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '₹$price',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
