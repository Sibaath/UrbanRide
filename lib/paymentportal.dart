import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class RideBookingPage extends StatefulWidget {
  @override
  _RideBookingPageState createState() => _RideBookingPageState();
}

class _RideBookingPageState extends State<RideBookingPage> {
  final _formKey = GlobalKey<FormState>();
  String source = '';
  String destination = '';
  int cost = 0;
  int userBalance = 0;
  final currentUserId = FirebaseAuth.instance.currentUser?.uid;

  @override
  void initState() {
    super.initState();
    _loadUserBalance();
  }

  void _loadUserBalance() async {
    if (currentUserId != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .get();

      if (userDoc.exists) {
        setState(() {
          userBalance =
              (userDoc.data() as Map<String, dynamic>)['balance'] ?? 1000;
        });
      } else {
        // Create user document if it doesn't exist
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUserId)
            .set({
          'balance': 1000,
        });
        setState(() {
          userBalance = 1000;
        });
      }
    }
  }

  void _generateCost() {
    setState(() {
      cost = (Random().nextDouble() * (30 - 12) + 12).ceil();
    });
  }

  Future<void> _saveTravel() async {
    if (currentUserId != null) {
      await FirebaseFirestore.instance.collection('rides').add({
        'userId': currentUserId,
        'source': source,
        'destination': destination,
        'cost': cost,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Update user balance
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .update({
        'balance': FieldValue.increment(userBalance - cost),
      });

      // Reload user balance
      _loadUserBalance();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF7FD8A6), Color(0xFF56C8F1)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Book a Ride',
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Balance: ₹${userBalance.toStringAsFixed(2)}',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 30),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _buildTextField(
                          label: 'Source',
                          onSaved: (value) => source = value!,
                        ),
                        SizedBox(height: 20),
                        _buildTextField(
                          label: 'Destination',
                          onSaved: (value) => destination = value!,
                        ),
                        SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              _generateCost();
                            }
                          },
                          child: Text('Generate Cost',
                              style: GoogleFonts.poppins()),
                          style: ElevatedButton.styleFrom(
                            // primary: Colors.white,
                            iconColor: Color(0xFF56C8F1),
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        if (cost > 0)
                          Text(
                            'Cost: ₹${cost.toStringAsFixed(2)}',
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        SizedBox(height: 20),
                        if (cost > 0)
                          ElevatedButton(
                            onPressed: userBalance >= cost
                                ? () async {
                                    await _saveTravel();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PaymentPage(amount: cost),
                                      ),
                                    );
                                  }
                                : null,
                            child: Text('Pay', style: GoogleFonts.poppins()),
                            style: ElevatedButton.styleFrom(
                              // primary: Colors.white,
                              iconColor: Color(0xFF56C8F1),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        if (cost > 0 && userBalance < cost)
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              'Insufficient balance',
                              style: GoogleFonts.poppins(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 300),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      {required String label, required Function(String?) onSaved}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        style: GoogleFonts.poppins(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.poppins(color: Colors.white.withOpacity(0.7)),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
        onSaved: onSaved,
      ),
    );
  }
}

class PaymentPage extends StatefulWidget {
  final int amount;

  PaymentPage({required this.amount});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late Razorpay _razorpay;
  final currentUserId = FirebaseAuth.instance.currentUser?.uid;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    if (currentUserId != null) {
      // Update user balance in Firebase
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .update({
        'balance': FieldValue.increment(-widget.amount),
      });

      // Add the ride to user's rides collection
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .collection('rides')
          .add({
        'amount': widget.amount,
        'timestamp': FieldValue.serverTimestamp(),
        'paymentId': response.paymentId,
      });
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                'assets/animations.json',
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),
              Text(
                'Payment Successful!',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF56C8F1),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop(); // Return to RideBookingPage
                },
                child: Text('OK', style: GoogleFonts.poppins()),
                style: ElevatedButton.styleFrom(
                  // primary: Color(0xFF56C8F1),
                  iconColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
      msg: "Payment Failed: ${response.message}",
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  void openCheckout() {
    var options = {
      'key': 'rzp_test_gTt59EalUwYI7s',
      'amount': widget.amount * 100,
      'name': 'UrbanRide',
      'description': 'Ride Payment',
      'prefill': {'contact': '1234567890', 'email': 'test@example.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF7FD8A6), Color(0xFF56C8F1)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                SizedBox(height: 20),
                Text(
                  'Payment',
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Amount to pay',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '₹${widget.amount.toStringAsFixed(2)}',
                            style: GoogleFonts.poppins(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF56C8F1),
                            ),
                          ),
                          SizedBox(height: 30),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: openCheckout,
                              child: Text(
                                'Proceed to Payment',
                                style: GoogleFonts.poppins(fontSize: 18),
                              ),
                              style: ElevatedButton.styleFrom(
                                // primary: Color(0xFF56C8F1),
                                iconColor:
                                    const Color.fromARGB(255, 180, 163, 163),
                                padding: EdgeInsets.symmetric(vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
