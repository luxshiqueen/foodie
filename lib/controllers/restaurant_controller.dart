import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:myapp/model/restaurant.dart';

class RestaurantController {
  final String apiKey =
      'AIzaSyCEHQzXBK89ZY4ROQ5LEUN-i0JF79_yMEE'; 

  Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied.');
      }
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<List<Restaurant>> getNearbyRestaurants(Position position) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${position.latitude},${position.longitude}&radius=1500&type=restaurant&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List data = json.decode(response.body)['results'];
      return data.map<Restaurant>((item) {
        return Restaurant.fromJson(item); // Utilize fromJson method
      }).toList();
    } else {
      throw Exception('Failed to fetch nearby restaurants');
    }
  }

  Future<Restaurant> fetchRestaurantDetails(String restaurantId) async {
    final response = await http.get(Uri.parse(
        'https://api.example.com/restaurants/$restaurantId')); // Replace API endpoint

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return Restaurant.fromJson(data);
    } else {
      throw Exception('Failed to load restaurant details');
    }
  }
}
