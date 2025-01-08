import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/model/RecipeModel.dart';


class ViewRecipe extends StatelessWidget {
  final Recipe recipe;

  const ViewRecipe({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set the background color to black
      appBar: AppBar(
        title: const Text('Recipe Details'),
        backgroundColor: Colors.orange, // Orange color for the AppBar
        iconTheme: const IconThemeData(color: Colors.white), // White back arrow
        foregroundColor: Colors.white, // White color for the title text
      ),
      body: Container(
        constraints:
            const BoxConstraints.expand(), // Make the container full screen
        padding: const EdgeInsets.all(16.0),
        child: Card(
          color: Colors.grey[850], // Set card background color to grey[850]
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(15), // Rounded corners for the card
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: TextEditingController(text: recipe.title),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color:
                        Colors.white, // Set text color to white for visibility
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none, // Remove border
                  ),
                  enabled: false, // Make it non-editable
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: TextEditingController(
                      text: 'Description: ${recipe.description}'),
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white, // Set text color to white
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none, // Remove border
                  ),
                  enabled: false, // Make it non-editable
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: TextEditingController(
                      text: 'Ingredients: ${recipe.ingredients.join(', ')}'),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white, // Set text color to white
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none, // Remove border
                  ),
                  enabled: false, // Make it non-editable
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: TextEditingController(
                      text: 'Instructions: ${recipe.instructions}'),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white, // Set text color to white
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none, // Remove border
                  ),
                  enabled: false, // Make it non-editable
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: TextEditingController(
                      text: 'Created by: ${recipe.createdBy}'),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey, // Set text color to grey
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none, // Remove border
                  ),
                  enabled: false, // Make it non-editable
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: TextEditingController(
                      text:
                          'Created on: ${DateFormat('MM/dd/yyyy HH:mm').format(recipe.createdAt)}'),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey, // Set text color to grey
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none, // Remove border
                  ),
                  enabled: false, // Make it non-editable
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Go back on button press
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.orange, // Set button color to orange
                  ),
                  child: const Text('Go Back',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
