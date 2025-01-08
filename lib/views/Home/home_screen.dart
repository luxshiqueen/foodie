import 'package:flutter/material.dart';
import 'package:myapp/controllers/HomeController.dart';
import 'package:myapp/views/Home/CategoryDetailsScreen.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> sliderItems = [
      {
        'image':
            'https://ca-times.brightspotcdn.com/dims4/default/ee761ed/2147483647/strip/true/crop/6720x4479+0+1/resize/2000x1333!/quality/75/?url=https%3A%2F%2Fcalifornia-times-brightspot.s3.amazonaws.com%2F18%2Feb%2F1fb3c62f4f389b5296c27e87e544%2F1198545-la-fo-cooking-thanksgiving-2022-14.jpg',
        'text': 'Create your amazing recipes here!',
      },
      {
        'image':
            'https://ch-api.healthhub.sg/api/public/content/76f7bc30044740108705e4cc2b3baa23?v=934b6239',
        'text': 'You can’t forget your meal planning time!',
      },
      {
        'image':
            'https://cdn.prod.website-files.com/602eb6861cd59a7ac7908779/64ef83859029c31799e2330b_Meal%20Plan.png',
        'text': 'whats your meal planner today!',
      },
      {
        'image':
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/2b/e5/e7/24/main-dining-area.jpg?w=600&h=-1&s=1',
        'text': 'Find nearby restaurants easily!',
      },
    ];

    return ChangeNotifierProvider(
      create: (_) => HomeController()..fetchCategories(),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title:
              const Text('Home Screen', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.orange,
          iconTheme: const IconThemeData(
              color: Colors.white), // Change back arrow color
        ),
        body: Column(
          children: [
            // Add space below the AppBar
            const SizedBox(height: 20), // Adjust the height as needed
            // Add the carousel slider
            Container(
              height: 150.0, // Adjust the height of the carousel here
              margin: const EdgeInsets.only(bottom: 10),
              child: CarouselSlider(
                items: sliderItems.map((item) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[850],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Image.network(
                              item['image']!,
                              width: double.infinity,
                              height:
                                  150.0, // Adjust image height to match container
                              fit: BoxFit.cover,
                            ),
                            Container(
                              width: double.infinity,
                              color: Colors.black54,
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                item['text']!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }).toList(),
                options: CarouselOptions(
                  height: 250.0, // Match the height here
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 5),
                  enlargeCenterPage: true,
                  viewportFraction: 0.8,
                ),
              ),
            ),
            // Add spacing between the carousel and the categories
            const SizedBox(height: 10),
            Expanded(
              child: Consumer<HomeController>(
                builder: (context, controller, _) {
                  if (controller.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.orange),
                    );
                  }

                  if (controller.categories.isEmpty) {
                    return const Center(
                      child: Text(
                        'No categories found',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: controller.categories.length,
                    itemBuilder: (context, index) {
                      final category = controller.categories[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  CategoryDetailsScreen(category: category),
                            ),
                          );
                        },
                        child: Card(
                          color: Colors.grey[850],
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                            leading: Image.network(
                              category.strCategoryThumb,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                            title: Text(
                              category.strCategory,
                              style: const TextStyle(color: Colors.white),
                            ),
                            trailing: const Icon(Icons.arrow_forward,
                                color: Colors.orange),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
