import 'package:flutter/material.dart';

class OrderStatusScreen extends StatelessWidget {
  final String orderId = '123456';
  final String status = 'Preparing';
  final List<String> foodItems = ['Burger', 'Fries', 'Coke'];
  final String restaurant = 'Foodie Restaurant';
  final String estimatedTime = '30 minutes';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Status", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal[600],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order ID Section
            _orderIdWidget(),
            SizedBox(height: 10),
            _orderStatusWidget(),
            SizedBox(height: 20),
            _orderTimelineWidget(),
            SizedBox(height: 20),
            _orderDetailsWidget(),
            SizedBox(height: 20),
            _actionButtons(context),
          ],
        ),
      ),
    );
  }

  // Order ID Widget
  Widget _orderIdWidget() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.teal[50],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 2, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Text(
        "Order ID: $orderId",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal[700]),
      ),
    );
  }

  // Order Status Widget
  Widget _orderStatusWidget() {
    Color statusColor;
    if (status == 'Delivered') {
      statusColor = Colors.green;
    } else if (status == 'Preparing') {
      statusColor = Colors.orange;
    } else {
      statusColor = Colors.blue;
    }

    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: statusColor.withOpacity(0.2), spreadRadius: 2, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status,
              style: TextStyle(color: statusColor, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Spacer(),
          Text("Order Time: 2:00 PM", style: TextStyle(fontSize: 14, color: Colors.grey)),
        ],
      ),
    );
  }

  // Order Timeline Widget (Stepper)
  Widget _orderTimelineWidget() {
    return Stepper(
      currentStep: _getStepIndex(),
      onStepTapped: (index) {},
      steps: [
        Step(title: Text('Order Placed'), content: Text('Order successfully placed')),
        Step(title: Text('Preparing'), content: Text('Your food is being prepared')),
        Step(title: Text('Out for Delivery'), content: Text('Your food is on its way')),
        Step(title: Text('Delivered'), content: Text('Enjoy your meal!')),
      ],
    );
  }

  int _getStepIndex() {
    if (status == 'Preparing') {
      return 1;
    } else if (status == 'Out for Delivery') {
      return 2;
    } else if (status == 'Delivered') {
      return 3;
    }
    return 0; // Default to Order Placed
  }

  // Order Details Widget
  Widget _orderDetailsWidget() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.teal[50],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 2, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Restaurant: $restaurant", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text("Food Items Ordered:", style: TextStyle(fontSize: 16)),
          ListView.builder(
            shrinkWrap: true,
            itemCount: foodItems.length,
            itemBuilder: (context, index) {
              return Text("${foodItems[index]}", style: TextStyle(fontSize: 14, color: Colors.black));
            },
          ),
          SizedBox(height: 10),
          Text("Estimated Delivery Time: $estimatedTime", style: TextStyle(fontSize: 14, color: Colors.black)),
        ],
      ),
    );
  }

  // Action Buttons
  Widget _actionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            // Logic to cancel order
          },
          icon: Icon(Icons.cancel, color: Colors.white),
          label: Text("Cancel Order", style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        ElevatedButton.icon(
          onPressed: () {
            // Logic to contact the restaurant or delivery person
          },
          icon: Icon(Icons.phone, color: Colors.white),
          label: Text("Contact", style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ],
    );
  }
}

