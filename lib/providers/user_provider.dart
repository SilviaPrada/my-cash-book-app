import 'package:flutter/foundation.dart';
import 'package:my_cash_book/models/user.dart'; // Import your User model
import 'package:my_cash_book/helper/dbhelper.dart'; // Import your DbHelper class

class UserProvider extends ChangeNotifier {
  User? _user;
  final DbHelper dbHelper = DbHelper(); // Create an instance of your DbHelper

  User? get user => _user;

  // Fetch user data by username
  Future<void> fetchUserByUsername(String username) async {
    final user = await dbHelper.getUserByUsername(username);
    if (user != null) {
      _user = user;
      notifyListeners(); // Notify listeners of the change in user data
    }
  }
}
