# Shop App

This is a Shop App developed using the Flutter framework and integrated with Firebase. The app allows users to browse and purchase products from the shop, manage their cart, and place orders.

## Features

- User Authentication: Users can create an account, log in, and log out. Firebase Authentication is used for secure user authentication and management.
- Product Catalog: The app displays a list of products available for purchase, including product details such as name, description, price, and images.
- Shopping Cart: Users can add products to their shopping cart, update quantities, and remove items.
- Order Placement: Users can place orders for items in their cart, providing shipping and payment information.
- Order History: Users can view their order history, including details such as order status and total amount.

## Installation and Setup

1. Ensure you have Flutter installed on your development machine. You can download Flutter from the official Flutter website (https://flutter.dev).
2. Clone the repository or download the source code.
3. Open the project in your preferred code editor.
4. Run `flutter pub get` to install the required dependencies.
5. Set up Firebase project and enable Firebase Authentication and Firestore.
6. Download the `google-services.json` file from the Firebase Console and place it in the `android/app` directory.
7. Update the Firebase configuration in the `android/app/build.gradle` and `ios/Runner/Info.plist` files.
8. Run the app using the `flutter run` command.

## Project Structure

- `lib/` contains the main source code for the app.
  - `models/` contains the data models used in the app.
  - `screens/` contains the different screens of the app.
  - `widgets/` contains reusable widgets used in the app.
  - `main.dart` is the entry point of the app.
- `android/` contains the Android-specific configuration files.
- `ios/` contains the iOS-specific configuration files.

## Dependencies

- `firebase_core` - Firebase Core package for Flutter.
- `firebase_auth` - Firebase Authentication package for Flutter.
- `cloud_firestore` - Firebase Firestore package for Flutter.
- `intl` - Internationalization package for Flutter.
- `numberpicker` - Number picker package for Flutter.
- `fluttertoast` - Toast package for Flutter.

## Contributing

Contributions to this project are welcome. If you encounter any issues or have suggestions for improvements, please submit an issue or a pull request on the project's GitHub repository.


