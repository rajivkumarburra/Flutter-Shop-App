import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/cart_item.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  static const routeName = '/cart';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String uid = '';

  @override
  void initState() {
    //get uid
    setState(() {
      uid = FirebaseAuth.instance.currentUser!.uid;
    });
    super.initState();
  }

  String getRandomString(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final rnd = Random();
    final buf = StringBuffer();
    for (var x = 0; x < length; x++) {
      buf.write(chars[rnd.nextInt(chars.length)]);
    }
    return buf.toString();
  }

  void placeOrder() async {
    try {
      for (var i = 0; i < CartItem.cartItems.length; i++) {
        final cartItem = CartItem.cartItems[i];
        final orderId = getRandomString(10);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('orders')
            .doc(orderId)
            .set({
          'orderId': orderId,
          'productName': cartItem.name,
          'productImage': cartItem.imageURL,
          'productPrice': cartItem.price,
          'productQuantity': cartItem.quantity,
          'orderDate': DateTime.now(),
        });
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cart',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: CartItem.cartItems.isEmpty
          ? Center(
              child: Image.asset('assets/images/empty_cart.png'),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: CartItem.cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = CartItem.cartItems[index];
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Dismissible(
                          key: ValueKey(cartItem.id),
                          direction: DismissDirection.startToEnd,
                          onDismissed: (direction) {
                            setState(() {
                              CartItem.cartItems.removeAt(index);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Item removed from cart!',
                                  textAlign: TextAlign.center,
                                ),
                                duration: Duration(seconds: 2),
                                backgroundColor: Colors.red,
                              ),
                            );
                          },
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(left: 20),
                            margin: const EdgeInsets.all(10),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                          child: Card(
                            elevation: 5,
                            child: ListTile(
                              leading: Image.network(
                                cartItem.imageURL,
                                fit: BoxFit.cover,
                              ),
                              title: Text(
                                cartItem.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.deepPurple,
                                ),
                              ),
                              subtitle: Text(
                                'Quantity: ${cartItem.quantity}',
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              trailing: Text(
                                '₹ ${cartItem.price * cartItem.quantity}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '₹ ${CartItem.totalAmountCalc()}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.06,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      placeOrder();
                      setState(() {
                        CartItem.cartItems.clear();
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Order Placed Successfully!',
                            textAlign: TextAlign.center,
                          ),
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.of(context)
                          .pushReplacementNamed('/order-placed');
                    },
                    child: const Text(
                      'Place Order',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
