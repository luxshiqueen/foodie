import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/model/user_model.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign up user with email and password
  Future<UserModel?> signUp(String email, String password) async {
    try {
      // Create the user with the provided email and password
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        return UserModel(
            uid: user.uid, email: user.email!); 
      }
      return null; // If user is null, return null
    } on FirebaseAuthException catch (e) {
      // Handle Firebase authentication error
      throw Exception('Error signing up: ${e.message}'); // Custom error message
    } catch (e) {
      throw Exception('Unknown error: $e'); // Catch any other errors
    }
  }

  // Sign in user with email and password
  Future<UserModel?> signIn(String email, String password) async {
    try {
      // Sign in with provided email and password
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        return UserModel(
            uid: user.uid, email: user.email!); // Return user model
      }
      return null; // If user is null, return null
    } on FirebaseAuthException catch (e) {
      // Handle Firebase authentication error
      throw Exception('Error signing in: ${e.message}'); // Custom error message
    } catch (e) {
      throw Exception('Unknown error: $e'); // Catch any other errors
    }
  }
}
