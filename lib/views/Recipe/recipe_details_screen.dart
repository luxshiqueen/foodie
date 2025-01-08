import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/model/RecipeModel.dart';
import 'package:myapp/services/RecipeService.dart';
import 'package:myapp/views/Recipe/AddRecipeScreen.dart';
import 'package:myapp/views/Recipe/EditRecipeScreen.dart';
import 'package:myapp/views/Recipe/viewRecipe.dart';
import 'package:myapp/widget/custom_floating_action_button.dart';

class RecipeDetailsScreen extends StatefulWidget {
  const RecipeDetailsScreen({super.key});

  @override
  _RecipeDetailsScreenState createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  final recipeService = RecipeService();
  List<Recipe> allRecipes = [];
  List<Recipe> filteredRecipes = [];
  String searchQuery = '';
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    recipeService.getUserRecipes().listen((recipes) {
      setState(() {
        allRecipes = recipes;
        filteredRecipes = recipes;
      });
    });
  }

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
      filteredRecipes = allRecipes.where((recipe) {
        return recipe.title.contains(query) ||
            recipe.description.contains(query) ||
            recipe.ingredients.contains(query);
      }).toList();
    });
  }

  void deleteRecipe(String recipeId) async {
    await recipeService.deleteRecipe(recipeId);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Recipe deleted successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Colors.white), // White back arrow
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: isSearching
            ? TextField(
                onChanged: updateSearchQuery,
                style: const TextStyle(color: Colors.white),
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Search by title, ingredients...',
                  hintStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                ),
              )
            : const Text('Recipes', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: Icon(isSearching ? Icons.cancel : Icons.search,
                color: Colors.white), // White search icon
            onPressed: () {
              setState(() {
                if (isSearching) {
                  isSearching = false;
                  searchQuery = '';
                  filteredRecipes = allRecipes;
                } else {
                  isSearching = true;
                }
              });
            },
          ),
        ],
      ),
      body: filteredRecipes.isEmpty
          ? const Center(
              child: Text('No recipes found',
                  style: TextStyle(color: Colors.white)),
            )
          : ListView.builder(
              itemCount: filteredRecipes.length,
              itemBuilder: (context, index) {
                final recipe = filteredRecipes[index];
                final formattedDate =
                    DateFormat('MM/dd/yyyy HH:mm').format(recipe.createdAt);

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ViewRecipe(recipe: recipe), // Passing the recipe
                      ),
                    );
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[850],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          recipe.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          recipe.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Created by: ${recipe.createdBy}',
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Added on: $formattedDate',
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon:
                                  const Icon(Icons.edit, color: Colors.orange),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EditRecipeScreen(recipe: recipe),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddRecipeScreen()),
          );
        },
      ),
    );
  }
}
