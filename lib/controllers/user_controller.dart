import 'package:myapp/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/services/firebase_services.dart';

class UserController {
  final FirebaseService _firebaseService = FirebaseService();

  // Handle user login
  Future<String?> loginUser(String email, String password) async {
    try {
      // Attempt to log in the user
      UserModel? user = await _firebaseService.signIn(email, password);
      if (user != null) {
        return null; // Login successful, no error
      } else {
        return "Login failed"; // In case login fails
      }
    } on FirebaseAuthException catch (e) {
      // Handle specific FirebaseAuth errors
      if (e.code == 'user-not-found') {
        return "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        return "Incorrect password provided.";
      }
      return "Error: ${e.message}";
    } catch (e) {
      return "Error: $e"; // Catch all other errors
    }
  }
}
