import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

void main() {
  runApp(MyApp());
}

class Restaurant {
  final String name;
  final String imageUrl;
  final String description;
  final List<String> menu;
  final double rating;
  final String cuisine;
  final double priceRange;
  final LatLng location;
  final List<String> reviews;

  Restaurant({
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.menu,
    required this.rating,
    required this.cuisine,
    required this.priceRange,
    required this.location,
    required this.reviews,
  });
}

// Sample list of restaurants
List<Restaurant> restaurants = [
  Restaurant(
    name: 'paragon',
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdNBnDe-O51UtOt3c7zIMTsVksTYIDEJ2Gdg&s',
    description: 'Fresh sushi rolls with a variety of toppings.',
    menu: ['chicken', 'mutton kurma', 'fishfry'],
    rating: 4.5,
    cuisine: 'indian',
    priceRange: 1500,
    location: LatLng(37.7749, -122.4194),
    reviews: ['Great biriyani!', 'Fresh and delicious.', 'Highly recommend!'],
  ),
  Restaurant(
    name: 'M-grill',
    imageUrl: 'https://media-cdn.tripadvisor.com/media/photo-s/0a/bf/53/42/outside.jpg',
    description: 'Authentic Italian pasta with handmade sauces.',
    menu: ['Spaghetti', 'Lasagna', 'Fettuccine Alfredo'],
    rating: 1000,
    cuisine: 'Italian',
    priceRange: 15,
    location: LatLng(37.7750, -122.4195),
    reviews: ['Amazing pasta!', 'Love the Italian food.', 'Great portion sizes.'],
  ),
  // Add more restaurants as needed
];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant Finder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: RestaurantSearchPage(),
    );
  }
}

class RestaurantSearchPage extends StatefulWidget {
  @override
  _RestaurantSearchPageState createState() => _RestaurantSearchPageState();
}

class _RestaurantSearchPageState extends State<RestaurantSearchPage> {
  List<Restaurant> filteredRestaurants = restaurants;
  String selectedCuisine = 'All';
  double minPrice = 0;
  double maxPrice = 50;
  double minRating = 0;

  void filterRestaurants() {
    setState(() {
      filteredRestaurants = restaurants.where((restaurant) {
        return (selectedCuisine == 'All' || restaurant.cuisine == selectedCuisine) &&
            restaurant.priceRange >= minPrice &&
            restaurant.priceRange <= maxPrice &&
            restaurant.rating >= minRating;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find Nearby Restaurants'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Filter options for restaurants
            Row(
              children: [
                Expanded(
                  child: InputDecorator(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.deepOrangeAccent),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    child: DropdownButton<String>(
                      value: selectedCuisine,
                      isExpanded: true,
                      items: ['All', 'Japanese', 'Italian', 'Indian', 'Chinese']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedCuisine = newValue!;
                        });
                        filterRestaurants();
                      },
                      style: TextStyle(color: Colors.deepOrangeAccent),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Text('Price Range:'),
                Slider(
                  min: 0,
                  max: 50,
                  value: maxPrice,
                  activeColor: Colors.deepOrangeAccent,
                  onChanged: (value) {
                    setState(() {
                      maxPrice = value;
                    });
                    filterRestaurants();
                  },
                ),
              ],
            ),
            Row(
              children: [
                Text('Min Rating:'),
                RatingBar.builder(
                  initialRating: minRating,
                  minRating: 0,
                  itemCount: 5,
                  itemSize: 20.0,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      minRating = rating;
                    });
                    filterRestaurants();
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            // List of filtered restaurants
            Expanded(
              child: ListView.builder(
                itemCount: filteredRestaurants.length,
                itemBuilder: (context, index) {
                  final restaurant = filteredRestaurants[index];
                  return Card(
                    elevation: 8,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          restaurant.imageUrl,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        restaurant.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${restaurant.cuisine} Cuisine'),
                          Text('\$${restaurant.priceRange} per dish'),
                          RatingBarIndicator(
                            rating: restaurant.rating,
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 20.0,
                            direction: Axis.horizontal,
                          ),
                        ],
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.deepOrangeAccent,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RestaurantDetailPage(restaurant: restaurant),
                          ),
                        );
                      },
                    ),
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

class RestaurantDetailPage extends StatelessWidget {
  final Restaurant restaurant;

  RestaurantDetailPage({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(restaurant.name), backgroundColor: Colors.deepOrangeAccent),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(restaurant.imageUrl),
              ),
              SizedBox(height: 16),
              Text(
                restaurant.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('Cuisine: ${restaurant.cuisine}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text('Price Range: \$${restaurant.priceRange}', style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              Text('Description:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text(restaurant.description, style: TextStyle(fontSize: 16)),
              SizedBox(height: 16),
              Text('Menu:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              for (var item in restaurant.menu)
                Text(item, style: TextStyle(fontSize: 16)),
              SizedBox(height: 16),
              Text('Reviews:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              for (var review in restaurant.reviews)
                Text('• $review', style: TextStyle(fontSize: 16)),
              SizedBox(height: 16),
              // Show restaurant location on map
              SizedBox(
                height: 300,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: restaurant.location,
                    zoom: 15.0,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId(restaurant.name),
                      position: restaurant.location,
                      infoWindow: InfoWindow(title: restaurant.name),
                    ),
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
