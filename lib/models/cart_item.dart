import 'package:cloud_firestore/cloud_firestore.dart';

class CartItem {
  final String id;
  final String name;
  final int price;
  final String imageURL;
  final String category;
  final int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.imageURL,
    required this.category,
    required this.quantity,
  });

  static List<CartItem> cartItems = [];
  static int totalAmount = 0;
  static int totalAmountCalc() {
    totalAmount = 0;
    for (int i = 0; i < cartItems.length; i++) {
      totalAmount += cartItems[i].price * cartItems[i].quantity;
    }
    return totalAmount;
  }

  static addToCart(
    String id,
    String category,
    int quantity,
  ) async {
    final doc = await FirebaseFirestore.instance
        .collection(category.toLowerCase())
        .doc(id)
        .get();
    final data = doc.data() as Map<String, dynamic>;
    final cartItem = CartItem(
      id: id,
      name: data['name'],
      price: data['price'],
      imageURL: data['imageURL'],
      category: category,
      quantity: quantity,
    );
    cartItems.add(cartItem);
  }
}
