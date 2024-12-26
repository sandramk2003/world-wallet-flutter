import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Room Booking History',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: BookingHistoryScreen(),
    );
  }
}

class Booking {
  final String bookingId;
  final String customerName;
  final String roomNumber;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final String paymentStatus;
  bool isCancelled;

  Booking({
    required this.bookingId,
    required this.customerName,
    required this.roomNumber,
    required this.checkInDate,
    required this.checkOutDate,
    required this.paymentStatus,
    this.isCancelled = false,
  });
}

// Sample data for bookings
List<Booking> bookings = [
  Booking(
    bookingId: 'B001',
    customerName: 'John Doe',
    roomNumber: '101',
    checkInDate: DateTime(2024, 12, 1),
    checkOutDate: DateTime(2024, 12, 5),
    paymentStatus: 'Paid',
  ),
  Booking(
    bookingId: 'B002',
    customerName: 'Jane Smith',
    roomNumber: '102',
    checkInDate: DateTime(2024, 12, 3),
    checkOutDate: DateTime(2024, 12, 7),
    paymentStatus: 'Pending',
  ),
  Booking(
    bookingId: 'B003',
    customerName: 'Alice Johnson',
    roomNumber: '103',
    checkInDate: DateTime(2024, 12, 10),
    checkOutDate: DateTime(2024, 12, 12),
    paymentStatus: 'Paid',
  ),
];

class BookingHistoryScreen extends StatefulWidget {
  @override
  _BookingHistoryScreenState createState() => _BookingHistoryScreenState();
}

class _BookingHistoryScreenState extends State<BookingHistoryScreen> {

  // Cancel Booking Function
  void cancelBooking(String bookingId) {
    setState(() {
      bookings.firstWhere((booking) => booking.bookingId == bookingId).isCancelled = true;
    });

    // Cancellation Confirmation
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Booking Cancelled'),
          content: Text('Your booking has been cancelled successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking History'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          final booking = bookings[index];
          return Card(
            elevation: 5,
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Booking ID: ${booking.bookingId}', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Customer: ${booking.customerName}'),
                  Text('Room Number: ${booking.roomNumber}'),
                  Text('Check-in: ${booking.checkInDate.toString().split(' ')[0]}'),
                  Text('Check-out: ${booking.checkOutDate.toString().split(' ')[0]}'),
                  Text('Payment Status: ${booking.paymentStatus}'),
                  if (!booking.isCancelled)
                    ElevatedButton(
                      onPressed: () => cancelBooking(booking.bookingId),
                      child: Text('Cancel Booking'),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    ),
                  if (booking.isCancelled) 
                    Text('Booking Cancelled', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
