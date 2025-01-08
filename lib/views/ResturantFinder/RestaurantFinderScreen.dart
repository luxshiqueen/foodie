import 'package:flutter/material.dart';
import 'package:myapp/widget/custom_appbar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../model/restaurant.dart';

class RestaurantFinderScreen extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantFinderScreen({super.key, required this.restaurant});

  // Function to launch URL
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set the background color to black
      appBar: CustomAppBar(
        title: restaurant.name,
        backgroundColor: Colors.orange,
        titleColor: Colors.white,
        leadingIcon: Icons.arrow_back,
        onLeadingPressed: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                restaurant.imageUrl,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 8.0),
              Text(
                restaurant.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Set text color to white
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Rating: ${restaurant.rating} ★',
                style: const TextStyle(
                  color: Colors.white70, // Use lighter white for secondary text
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Contact: ${restaurant.contactNumber}',
                style: const TextStyle(
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Address: ${restaurant.address}',
                style: const TextStyle(
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Description: ${restaurant.description}',
                style: const TextStyle(
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 8.0),
              InkWell(
                onTap: () => _launchURL(restaurant.googleMapsLink),
                child: const Text(
                  'View on Google Maps',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              // Add more widgets as needed to display other details
            ],
          ),
        ),
      ),
    );
  }
}
