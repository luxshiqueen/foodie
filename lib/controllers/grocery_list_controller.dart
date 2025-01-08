import 'package:myapp/model/grocery_list_model.dart';

class GroceryController {
  
  Future<void> addGroceryList(String recipeName, List<Map<String, dynamic>> items) async {
    final grocery = GroceryModel(recipeName: recipeName, items: items);
    await GroceryModel.saveToFirestore(grocery);
  }

  
  Stream<List<GroceryModel>> getGroceryLists() {
    return GroceryModel.fetchAll();
  }

  
  Future<void> deleteGroceryList(String id) async {
    await GroceryModel.deleteFromFirestore(id);
  }

  
  Future<void> updateGroceryList(String id, String recipeName, List<Map<String, dynamic>> items) async {
    final updatedGrocery = GroceryModel(id: id, recipeName: recipeName, items: items);
    await GroceryModel.updateInFirestore(updatedGrocery);
  }
}


