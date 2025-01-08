import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:myapp/views/Grocery/grocery_list_screen.dart';
import 'package:myapp/views/MealPlanner/meal_plan_screen.dart';
import 'package:myapp/views/Home/home_screen.dart';
import 'package:myapp/views/Recipe/recipe_details_screen.dart';
import 'package:myapp/views/ResturantFinder/home_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // List of screens corresponding to each navigation item
  final List<Widget> _pages = [
    const HomeScreen(),
    const MealPlanScreen(),
    const RecipeDetailsScreen(),
    const GroceryListScreen(),
    const HomePage()
  ];

  // Function to handle bottom navigation item tap
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _pages[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.black,
        color: Colors.orange,
        buttonBackgroundColor: Colors.orange,
        height: 65.0,
        items: const <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white), // Home icon
          Icon(Icons.calendar_today,
              size: 30, color: Colors.white), // Meal Planner icon
          Icon(Icons.restaurant_menu,
              size: 30, color: Colors.white), // Recipe Details icon
          Icon(Icons.shopping_cart,
              size: 30, color: Colors.white), // Grocery List icon
          Icon(Icons.location_on,
              size: 30, color: Colors.white), // Restaurant Finder icon
        ],
        index: _currentIndex, // Ensures correct active index
        onTap: _onItemTapped,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
      ),
    );
  }
}
