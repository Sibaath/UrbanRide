import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:login/paymentportal.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login.dart';
import 'signup.dart';
import 'chatbot.dart';
import 'mapscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UrbanRide',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 23, 142, 234),
              Color.fromARGB(255, 170, 207, 121)
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'UrbanRide 🚌',
                  style: GoogleFonts.montserrat(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 30),
                Image.asset('assets/image.png', height: 250),
                const SizedBox(height: 15),
                const Text(
                  'Where Effortless Rides Happen Everywhere! 🌟',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.white70),
                ),
                const SizedBox(height: 50),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        child: const Text('Sign in 👤',
                            style: TextStyle(fontSize: 18)),
                        style: ElevatedButton.styleFrom(
                          iconColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpPage()));
                        },
                        child:
                            Text('Register 📝', style: TextStyle(fontSize: 18)),
                        style: ElevatedButton.styleFrom(
                          iconColor: Colors.blue[700],
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static List<Widget> _pages = <Widget>[
    HomeScreen(),
    RideBookingPage(),
    MapScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _openChatbot() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text('UrbanRideChatbot'),
          backgroundColor: const Color.fromARGB(255, 68, 119, 176),
        ),
        body: ChatScreen(),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Important for the floating effect
      appBar: GradientAppBar(title: 'UrbanRide'),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color.fromARGB(255, 0, 114, 207),
              const Color.fromARGB(255, 64, 100, 116)
            ],
          ),
        ),
        child: _pages[_selectedIndex],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openChatbot,
        child: Icon(Icons.chat),
        backgroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 2,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.directions_car),
                  label: 'Rides',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.map),
                  label: 'Maps',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.blue[800],
              unselectedItemColor: Colors.grey,
              onTap: _onItemTapped,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              elevation: 0,
              showSelectedLabels: false,
              showUnselectedLabels: false,
            ),
          ),
        ),
      ),
    );
  }
}

class RidesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child:
          Text('Rides Screen - Coming Soon!', style: TextStyle(fontSize: 22)),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child:
          Text('Profile Screen - Coming Soon!', style: TextStyle(fontSize: 22)),
    );
  }
}

class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  GradientAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.green],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(title),
        centerTitle: true,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData) {
          return Center(child: Text('No user data found'));
        }

        var userData = snapshot.data!.data() as Map<String, dynamic>;

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue[300]!, Colors.green[300]!],
            ),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildUserInfo(userData),
                SizedBox(height: 20),
                _buildBalance(userData),
                SizedBox(height: 20),
                _buildSubscriptionButton(context, userData),
                SizedBox(height: 20),
                _buildTravelHistory(user?.uid),
                SizedBox(
                  height: 300,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildUserInfo(Map<String, dynamic> userData) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '👤 User Information',
              style: GoogleFonts.montserrat(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
            SizedBox(height: 10),
            _buildInfoRow(Icons.person, 'Name', userData['name']),
            _buildInfoRow(Icons.email, 'Email', userData['email']),
            _buildInfoRow(Icons.phone, 'Phone', userData['phone']),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue[600], size: 20),
          SizedBox(width: 10),
          Text('$label: ', style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value, style: TextStyle(fontSize: 16))),
        ],
      ),
    );
  }

  Widget _buildBalance(Map<String, dynamic> userData) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '💰 Balance',
              style: GoogleFonts.montserrat(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
            ),
            Text(
              '₹${userData['balance'] ?? 0}',
              style: GoogleFonts.montserrat(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubscriptionButton(
      BuildContext context, Map<String, dynamic> userData) {
    return ElevatedButton(
      onPressed: () => _handleSubscription(context, userData),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        child: Text(
          '🚀 Pay Subscription',
          style: TextStyle(fontSize: 18),
        ),
      ),
      style: ElevatedButton.styleFrom(
        iconColor: Colors.orange,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }

  void _handleSubscription(
      BuildContext context, Map<String, dynamic> userData) {
    // Example subscription amount
    final subscriptionAmount = 50;
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Subscription'),
          content: Text(
              'Do you want to pay ₹$subscriptionAmount for the subscription?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Pay'),
              onPressed: () {
                // Update user's balance in Firestore
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(currentUserId)
                    .update({
                  'balance': FieldValue.increment(subscriptionAmount)
                }).then((_) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Subscription payment successful!')),
                  );
                }).catchError((error) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: ${error.toString()}')),
                  );
                });
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildTravelHistory(String? userId) {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '🚗 Travel History',
              style: GoogleFonts.montserrat(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.purple[800],
              ),
            ),
            SizedBox(height: 10),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(currentUserId)
                  .collection('rides')
                  .orderBy('date', descending: true)
                  .limit(5)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Text('No travel history available.');
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var trip = snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;
                    return ListTile(
                      leading:
                          Icon(Icons.directions_car, color: Colors.purple[600]),
                      title: Text(trip['destination']),
                      subtitle: Text(DateFormat('MMM d, yyyy')
                          .format(trip['date'].toDate())),
                      trailing: Text('\$${trip['cost']}'),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
