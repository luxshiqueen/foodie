import 'package:cloud_firestore/cloud_firestore.dart';

class GroceryModel {
  final String id;
  final String recipeName;
  final List<Map<String, dynamic>> items;

  GroceryModel({this.id = '', required this.recipeName, required this.items});

  
  Map<String, dynamic> toMap() {
    return {
      'recipeName': recipeName,
      'items': items,
    };
  }

 
  static GroceryModel fromMap(Map<String, dynamic> map, String id) {
    return GroceryModel(
      id: id,
      recipeName: map['recipeName'],
      items: List<Map<String, dynamic>>.from(map['items']),
    );
  }

  
  static Future<void> saveToFirestore(GroceryModel grocery) async {
    final collection = FirebaseFirestore.instance.collection('grocery_lists');
    await collection.add(grocery.toMap());
  }

  
  static Stream<List<GroceryModel>> fetchAll() {
    final collection = FirebaseFirestore.instance.collection('grocery_lists');
    return collection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return GroceryModel.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }

 
  static Future<void> deleteFromFirestore(String id) async {
    final collection = FirebaseFirestore.instance.collection('grocery_lists');
    await collection.doc(id).delete();
  }

 
  static Future<void> updateInFirestore(GroceryModel updatedGrocery) async {
    final collection = FirebaseFirestore.instance.collection('grocery_lists');
    await collection.doc(updatedGrocery.id).update(updatedGrocery.toMap());
  }
}


