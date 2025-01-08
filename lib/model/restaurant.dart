class Restaurant {
  final String name;
  final String description;
  final String imageUrl;
  final double rating; // Ensure rating is a double
  final String contactNumber;
  final String address;
  final List<String> openingHours;
  final String websiteUrl;
  final String reviewsUrl;
  final String googleMapsLink;

  Restaurant({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.contactNumber,
    required this.address,
    required this.openingHours,
    required this.websiteUrl,
    required this.reviewsUrl,
    required this.googleMapsLink,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      name: json['name'] ?? 'No name provided',
      description: json['vicinity'] ?? 'No description available.',
      imageUrl: json['photos'] != null
          ? 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${json['photos'][0]['photo_reference']}&key=AIzaSyCEHQzXBK89ZY4ROQ5LEUN-i0JF79_yMEE' // Replace API Key
          : 'https://via.placeholder.com/150',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      contactNumber: json['formatted_phone_number'] ?? 'N/A',
      address: json['vicinity'] ?? 'Address not available.',
      openingHours: json['opening_hours'] != null
          ? List<String>.from(json['opening_hours']['weekday_text'] ?? [])
          : ['Opening hours not available'],
      websiteUrl: json['website'] ?? 'N/A',
      reviewsUrl: json['place_id'] != null
          ? 'https://api.your-reviews-source.com/restaurant-reviews/${json['place_id']}'
          : 'N/A',
      googleMapsLink: json['geometry'] != null
          ? 'https://www.google.com/maps/search/?api=1&query=${json['geometry']['location']['lat']},${json['geometry']['location']['lng']}'
          : 'N/A',
    );
  }
}
