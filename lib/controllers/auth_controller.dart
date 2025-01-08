import 'package:myapp/model/user_model.dart';
import 'package:myapp/services/firebase_services.dart';

class AuthController {
  final FirebaseService _firebaseService = FirebaseService();

  // Sign up user
  Future<String?> signUpUser(String email, String password) async {
    try {
      UserModel? user = await _firebaseService.signUp(email, password);
      if (user != null) {
        return null; // Success
      }
      return "Sign up failed"; // In case something goes wrong
    } catch (e) {
      return e.toString();
    }
  }

  // Log in user
  Future<String?> loginUser(String email, String password) async {
    try {
      UserModel? user = await _firebaseService.signIn(email, password);
      if (user != null) {
        return null; // Success
      }
      return "Login failed"; // In case something goes wrong
    } catch (e) {
      return e.toString();
    }
  }
}
