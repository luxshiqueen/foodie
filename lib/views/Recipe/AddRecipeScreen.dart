import 'package:flutter/material.dart';
import 'package:myapp/model/RecipeModel.dart';
import 'package:myapp/services/RecipeService.dart';
import 'package:myapp/widget/custom_appbar.dart';
import 'package:myapp/widget/custom_elevated_button.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  _AddRecipeScreenState createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  List<String> ingredients = [];
  String instructions = '';
  bool isLoading = false;

  void _saveRecipe() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      setState(() {
        isLoading = true;
      });

      final recipe = Recipe(
        id: '',
        title: title,
        description: description,
        ingredients: ingredients,
        instructions: instructions,
        createdBy: 'Current User',
        createdAt: DateTime.now(), 
      );

      final recipeService = RecipeService();
      await recipeService.addRecipe(recipe);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Recipe added successfully!')),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Black background
      appBar: const CustomAppBar(
        title: 'Add Recipe',
        backgroundColor: Colors.orange,
        titleColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  style: const TextStyle(color: Colors.white), // White text
                  decoration: InputDecoration(
                    labelText: 'Title',
                    labelStyle: const TextStyle(
                        color:
                            Color.fromARGB(255, 250, 249, 247)), // Label color
                    filled: true,
                    fillColor: Colors.grey[850], // Dark grey background
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Colors.grey), // Light grey border
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Colors.orange), // Orange border on focus
                    ),
                  ),
                  onSaved: (value) => title = value ?? '',
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Title is required' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  style: const TextStyle(color: Colors.white), // White text
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: const TextStyle(
                        color:
                            Color.fromARGB(255, 254, 253, 251)), // Label color
                    filled: true,
                    fillColor: Colors.grey[850], // Dark grey background
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Colors.grey), // Light grey border
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Colors.orange), // Orange border on focus
                    ),
                  ),
                  onSaved: (value) => description = value ?? '',
                ),
                const SizedBox(height: 16),
                TextFormField(
                  style: const TextStyle(color: Colors.white), // White text
                  decoration: InputDecoration(
                    labelText: 'Ingredients (comma-separated)',
                    labelStyle: const TextStyle(
                        color:
                            Color.fromARGB(255, 250, 249, 248)), // Label color
                    filled: true,
                    fillColor: Colors.grey[850], // Dark grey background
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Colors.grey), // Light grey border
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Colors.orange), // Orange border on focus
                    ),
                  ),
                  onSaved: (value) {
                    ingredients =
                        value?.split(',').map((e) => e.trim()).toList() ?? [];
                  },
                  maxLines: 3, // Make it a text area
                ),
                const SizedBox(height: 16),
                TextFormField(
                  style: const TextStyle(color: Colors.white), // White text
                  decoration: InputDecoration(
                    labelText: 'Instructions',
                    labelStyle: const TextStyle(
                        color:
                            Color.fromARGB(255, 249, 249, 249)), // Label color
                    filled: true,
                    fillColor: Colors.grey[850], // Dark grey background
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Colors.grey), // Light grey border
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Colors.orange), // Orange border on focus
                    ),
                  ),
                  onSaved: (value) => instructions = value ?? '',
                  maxLines: 5, // Make it a text area
                ),
                const SizedBox(height: 16),
                if (isLoading)
                  const CircularProgressIndicator(
                      color: Colors.orange) // Orange loader
                else
                  CustomElevatedButton(
                    text: 'Save Recipe',
                    onPressed: _saveRecipe,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
