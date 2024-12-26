import 'package:flutter/material.dart';
import 'package:flutterproject1/oters/restaurantsearch1.dart';
import 'package:flutterproject1/oters/roomsearch1.dart';
import 'package:flutterproject1/presentation/notification.dart';
import 'package:flutterproject1/presentation/roombookinghistory.dart';
import 'package:flutterproject1/presentation/roomsearch1.dart';
import 'package:flutterproject1/presentation/trackorder.dart';
import 'package:flutterproject1/presentation/walletmanage.dart';



class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Budget Travel App"),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade200, Colors.blueAccent.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome Section
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    "Welcome to Budget Travel",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  "Book affordable rooms, discover budget-friendly restaurants, and manage your expenses in one place.",
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),

                SizedBox(height: 30),

                // Room Reservation Section
                _buildFeatureCard(
                  icon: Icons.hotel,
                  title: "Room Reservations",
                  description:
                      "Browse and reserve rooms based on price, location, and amenities.",
                  onTap: () {
                    // Navigate to Room Reservation screen
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>RoomSearch1()));
                  },
                ),
                SizedBox(height: 20),

                // Nearby Restaurants Section
                _buildFeatureCard(
                  icon: Icons.restaurant,
                  title: "Nearby Restaurants",
                  description:
                      "Explore nearby restaurants and enjoy meals within your budget.",
                  onTap: () {
                    // Navigate to Restaurant Discovery screen
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>RestaurantSearchPage()));
                  },
                ),
                SizedBox(height: 20),

                // Wallet Management Section
                _buildFeatureCard(
                  icon: Icons.wallet_travel,
                  title: "Wallet Management",
                  description:
                      "Add funds, track your expenses, and view transaction history.",
                  onTap: () {
                    // Navigate to Wallet Management screen
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>WalletExpenseScreen()));
                  },
                ),
                SizedBox(height: 20),
                //    _buildFeatureCard(
                //   icon: Icons.history,
                //   title: "Booking History",
                //   description:
                //       "view booking history.",
                //   onTap: () {
                //     // Navigate to Wallet Management screen
                //   },
                // ),
                // SizedBox(height: 20),

                // Bottom Navigation
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        flex: 1,
                        child: _buildNavButton(
                          icon: Icons.history,
                          label: "booking history",
                          onTap: () {
                            // Navigate to booking history
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>BookingHistoryScreen()));
                          },
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: _buildNavButton(
                          icon: Icons.delivery_dining_outlined,
                          label: " my order",
                          onTap: () {
                            // Navigate to order status
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderStatusScreen()));
                          },
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: _buildNavButton(
                          icon: Icons.notifications,
                          label: "notification",
                          onTap: () {
                            // Navigate to notifications
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationPage()));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
  required IconData icon,
  required String title,
  required String description,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 50, color: Colors.blueAccent),
            SizedBox(width: 16),
            Expanded(  // Use Expanded here to ensure text can take up available space
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                    softWrap: true,  // Ensure the text wraps
                    overflow: TextOverflow.ellipsis,  // Truncate text with ellipsis if it's too long
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}


  Widget _buildNavButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 40,
            color: const Color.fromARGB(255, 233, 235, 240),
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(color: const Color.fromARGB(255, 232, 237, 246)),
          ),
        ],
      ),
    );
  }
}
