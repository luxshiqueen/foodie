import 'package:flutter/material.dart';
import 'package:myapp/controllers/grocery_list_controller.dart';
import 'package:myapp/model/grocery_list_model.dart';
import 'package:myapp/widget/custom_appbar.dart';
import 'package:myapp/widget/custom_floating_action_button.dart';

class GroceryListScreen extends StatefulWidget {
  const GroceryListScreen({super.key});

  @override
  State<GroceryListScreen> createState() => _GroceryListScreenState();
}

class _GroceryListScreenState extends State<GroceryListScreen>
    with SingleTickerProviderStateMixin {
  final GroceryController _controller = GroceryController();
  final TextEditingController _recipeNameController = TextEditingController();
  final List<Map<String, dynamic>> _items = [];
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  void _showAddGroceryDialog(
      {GroceryModel? grocery, Map<String, dynamic>? itemToEdit}) {
    if (grocery != null) {
      _recipeNameController.text = grocery.recipeName;
      _items.addAll(grocery.items);
    } else {
      _recipeNameController.clear();
      _items.clear();
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 39, 39, 39),
          title: Text(
            grocery == null ? 'Add Grocery List' : 'Edit Grocery List',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _recipeNameController,
                  decoration: const InputDecoration(
                    labelText: 'Recipe Name',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                ..._items.map((item) {
                  return ListTile(
                    title: Text(
                      item['itemName'],
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      'Quantity: ${item['quantity']}',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit, color: Colors.orange),
                      onPressed: () {
                        setState(() {
                          _itemNameController.text = item['itemName'];
                          _quantityController.text = item['quantity'];
                          _items.remove(item);
                        });
                      },
                    ),
                  );
                }),
                TextField(
                  controller: _itemNameController,
                  decoration: const InputDecoration(
                    labelText: 'Item Name',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                TextField(
                  controller: _quantityController,
                  decoration: const InputDecoration(
                    labelText: 'Quantity',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _items.add({
                        'itemName': _itemNameController.text,
                        'quantity': _quantityController.text,
                      });
                      _itemNameController.clear();
                      _quantityController.clear();
                    });
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    'Add Item',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _recipeNameController.clear();
                _itemNameController.clear();
                _quantityController.clear();
                _items.clear();
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () async {
                if (_recipeNameController.text.isNotEmpty &&
                    _items.isNotEmpty) {
                  if (grocery == null) {
                    await _controller.addGroceryList(
                      _recipeNameController.text,
                      _items,
                    );
                  } else {
                    await _controller.updateGroceryList(
                      grocery.id,
                      _recipeNameController.text,
                      _items,
                    );
                  }
                  _recipeNameController.clear();
                  _itemNameController.clear();
                  _quantityController.clear();
                  _items.clear();
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Saved Successfully')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill in all fields')),
                  );
                }
              },
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.orange),
              ),
            ),
          ],
        );
      },
    );
  }

  void _deleteGrocery(String id) async {
    await _controller.deleteGroceryList(id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Deleted Successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Grocery List',
        backgroundColor: Colors.orange,
        titleColor: Colors.white,
      ),
      body: Container(
        color: Colors.black,
        child: StreamBuilder<List<GroceryModel>>(
          stream: _controller.getGroceryLists(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  'No Grocery Lists Found',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final grocery = snapshot.data![index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  color: Colors.grey[900],
                  elevation: 15,
                  shadowColor: Colors.black.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ExpansionTile(
                    title: Text(
                      grocery.recipeName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    iconColor: Colors.white,
                    collapsedIconColor:
                        const Color.fromARGB(255, 226, 226, 226),
                    children: [
                      ...grocery.items.map((item) => ListTile(
                            title: Text(
                              item['itemName'],
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              'Quantity: ${item['quantity']}',
                              style: const TextStyle(color: Colors.white70),
                            ),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.orange),
                            onPressed: () =>
                                _showAddGroceryDialog(grocery: grocery),
                          ),
                          IconButton(
                            icon:
                                const Icon(Icons.delete, color: Colors.orange),
                            onPressed: () => _deleteGrocery(grocery.id),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () => _showAddGroceryDialog(),
      ),
    );
  }
}
