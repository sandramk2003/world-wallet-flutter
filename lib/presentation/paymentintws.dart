import 'package:flutter/material.dart';

class PaymentProcess extends StatefulWidget {
  @override
  _PaymentProcessState createState() => _PaymentProcessState();
}

class _PaymentProcessState extends State<PaymentProcess> {
  final _amountController = TextEditingController();
  String selectedPaymentMethod = "Credit/Debit Card";
  final _cardNumberController = TextEditingController();
  final _upiIdController = TextEditingController();
  final _accountNumberController = TextEditingController();
  final _ifscController = TextEditingController();

  void processPayment() {
    // Simulate payment processing (In real-world, integrate with payment gateway like Stripe, PayPal, etc.)
    if (_amountController.text.isNotEmpty) {
      double amount = double.parse(_amountController.text);
      if (amount > 0) {
        // Simulate successful payment
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Payment Successful", style: TextStyle(fontWeight: FontWeight.bold)),
              content: Text("You have added \$${amount.toStringAsFixed(2)} to your wallet."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("OK", style: TextStyle(color: Colors.blue)),
                ),
              ],
            );
          },
        );
      } else {
        // Show error if amount is less than or equal to 0
        showError("Amount should be greater than 0.");
      }
    } else {
      // Show error if amount is empty
      showError("Please enter an amount.");
    }
  }

  void showError(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Error", style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK", style: TextStyle(color: Colors.red)),
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
        title: Text("PAYMENT", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal,
        leading: BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                "Payment process",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.teal[700]),
              ),
              SizedBox(height: 20),

              // Amount input field
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Amount",
                  hintText: "Enter amount to pay",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.teal, width: 2),
                  ),
                  filled: true,
                  fillColor: Colors.teal[50],
                ),
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),

              // Payment Method selection
              Text(
                "Select Payment Method",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.teal[700]),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.teal, width: 2),
                ),
                child: DropdownButton<String>(
                  value: selectedPaymentMethod,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedPaymentMethod = newValue!;
                    });
                  },
                  underline: SizedBox(),
                  isExpanded: true,
                  items: <String>["Credit/Debit Card", "Bank Transfer", "UPI"]
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: TextStyle(fontSize: 18)),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 20),

              // Show relevant input fields based on selected payment method
              if (selectedPaymentMethod == "Credit/Debit Card") ...[
                TextField(
                  controller: _cardNumberController,
                  decoration: InputDecoration(
                    labelText: "Card Number",
                    hintText: "Enter card number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.teal, width: 2),
                    ),
                    filled: true,
                    fillColor: Colors.teal[50],
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _cardNumberController,
                  decoration: InputDecoration(
                    labelText: "Expiry Date",
                    hintText: "MM/YY",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.teal, width: 2),
                    ),
                    filled: true,
                    fillColor: Colors.teal[50],
                  ),
                  keyboardType: TextInputType.datetime,
                ),
              ],
              if (selectedPaymentMethod == "UPI") ...[
                TextField(
                  controller: _upiIdController,
                  decoration: InputDecoration(
                    labelText: "UPI ID",
                    hintText: "Enter UPI ID",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.teal, width: 2),
                    ),
                    filled: true,
                    fillColor: Colors.teal[50],
                  ),
                ),
              ],
              if (selectedPaymentMethod == "Bank Transfer") ...[
                TextField(
                  controller: _accountNumberController,
                  decoration: InputDecoration(
                    labelText: "Account Number",
                    hintText: "Enter account number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.teal, width: 2),
                    ),
                    filled: true,
                    fillColor: Colors.teal[50],
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _ifscController,
                  decoration: InputDecoration(
                    labelText: "IFSC Code",
                    hintText: "Enter IFSC code",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.teal, width: 2),
                    ),
                    filled: true,
                    fillColor: Colors.teal[50],
                  ),
                ),
              ],

              SizedBox(height: 20),

              // Payment button
              ElevatedButton.icon(
                onPressed: processPayment,
                icon: Icon(Icons.payment, color: Colors.white),
                label: Text("Proceed to Payment", style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
