import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/model/RecipeModel.dart';

class RecipeService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get userId => _auth.currentUser?.uid ?? '';

  // Add new recipe
  Future<void> addRecipe(Recipe recipe) async {
    final recipeRef =
        _db.collection('Users').doc(userId).collection('recipes').doc();
    recipe.id = recipeRef.id;  // Assign the generated document ID
    await recipeRef.set(recipe.toMap());  // Save the recipe to Firestore
  }

  // Stream of all user's recipes
  Stream<List<Recipe>> getUserRecipes() {
    return _db
        .collection('Users')
        .doc(userId)
        .collection('recipes')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Recipe.fromMap(doc.data(), doc.id))
            .toList());
  }

  // Update an existing recipe
  Future<void> updateRecipe(Recipe updatedRecipe) async {
    final recipeRef = _db
        .collection('Users')
        .doc(userId)
        .collection('recipes')
        .doc(updatedRecipe.id);

    await recipeRef.update(updatedRecipe.toMap());  // Update the recipe in Firestore
  }

  // Delete a recipe
  Future<void> deleteRecipe(String recipeId) async {
    final recipeRef = _db
        .collection('Users')
        .doc(userId)
        .collection('recipes')
        .doc(recipeId);

    await recipeRef.delete();  // Delete the recipe from Firestore
  }
}
