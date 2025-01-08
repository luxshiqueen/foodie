import 'package:flutter/material.dart';
import 'package:myapp/controllers/restaurant_controller.dart';
import 'package:myapp/model/restaurant.dart';
import 'package:myapp/views/ResturantFinder/RestaurantFinderScreen.dart';
import 'package:myapp/widget/custom_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late RestaurantController controller;
  List<Restaurant> restaurants = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    controller = RestaurantController();
    _fetchRestaurants();
  }

  Future<void> _fetchRestaurants() async {
    try {
      final position = await controller.getCurrentLocation();
      final data = await controller.getNearbyRestaurants(position);
      setState(() {
        restaurants = data;
        isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set the background color to black
      appBar: const CustomAppBar(
        title: 'Nearby Restaurants',
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                final restaurant = restaurants[index];
                return Card(
                  color: Colors.grey[900], // Set card color to dark grey
                  child: ListTile(
                    leading: Image.network(
                      restaurant.imageUrl,
                      fit: BoxFit.cover,
                      width: 50,
                    ),
                    title: Text(
                      restaurant.name,
                      style: const TextStyle(
                        color: Colors.white, // Set text color to white
                      ),
                    ),
                    subtitle: Text(
                      'Rating: ${restaurant.rating} ★',
                      style: const TextStyle(
                        color: Colors.white70, // Use lighter white for subtitles
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RestaurantFinderScreen(restaurant: restaurant),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
