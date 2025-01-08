import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/model/user_model.dart';


class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign up user with email and password
  Future<UserModel?> signUp(String email, String password) async {
    try {
      // Create a new user
      var userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      // Return UserModel on successful sign-up
      if (user != null) {
        return UserModel(uid: user.uid, email: user.email!);
      } else {
        return null;
      }
    } on FirebaseAuthException {
      rethrow; // Propagate Firebase errors
    }
  }
}
