import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign in with email and password
  Future<String?> signInWithEmail(String email, String password) async {
    try {
      // Sign in using the provided credentials
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null; // Success
    } catch (e) {
      return e.toString(); // Return error message
    }
  }

  // Sign up with email and password
  Future<String?> signUpWithEmail(String email, String password) async {
    try {
      // Create a new user with email and password
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null; // Success
    } catch (e) {
      return e.toString(); // Return error message
    }
  }
}
