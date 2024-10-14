// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'firebase_options.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'UrbanRide',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//         textTheme: GoogleFonts.poppinsTextTheme(),
//       ),
//       home: const LandingPage(),
//     );
//   }
// }

// class LandingPage extends StatelessWidget {
//   const LandingPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               const Color.fromARGB(255, 23, 142, 234),
//               const Color.fromARGB(255, 170, 207, 121)
//             ],
//           ),
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding: EdgeInsets.all(20.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'UrbanRide 🚌',
//                   style: GoogleFonts.montserrat(
//                     fontSize: 40,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                   textAlign: TextAlign.start,
//                 ),
//                 const SizedBox(height: 30),
//                 Image.asset('assets/image.png', height: 250),
//                 const SizedBox(height: 15),
//                 const Text(
//                   'Where Effortless Rides Happen Everywhere! 🌟',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontSize: 18, color: Colors.white70),
//                 ),
//                 SizedBox(height: 50),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => LoginPage()));
//                         },
//                         child:
//                             Text('Sign in 👤', style: TextStyle(fontSize: 18)),
//                         style: ElevatedButton.styleFrom(
//                           iconColor: Colors.white,
//                           padding: EdgeInsets.symmetric(vertical: 15),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 20),
//                     Expanded(
//                       child: ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => SignUpPage()));
//                         },
//                         child:
//                             Text('Register 📝', style: TextStyle(fontSize: 18)),
//                         style: ElevatedButton.styleFrom(
//                           iconColor: Colors.blue[700],
//                           padding: EdgeInsets.symmetric(vertical: 15),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class SignUpPage extends StatefulWidget {
//   @override
//   _SignUpPageState createState() => _SignUpPageState();
// }

// class _SignUpPageState extends State<SignUpPage> {
//   final _nameController = TextEditingController();
//   final _phoneController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final CollectionReference usersCollection =
//       FirebaseFirestore.instance.collection('users');

//   void addUser() {
//     final String name = _nameController.text;
//     final String phone = _phoneController.text;
//     final String email = _emailController.text;
//     final String password = _passwordController.text;
//     usersCollection.add({
//       'name': name,
//       'age': int.parse(phone),
//       'password': password,
//       'email': email
//     });
//     Navigator.of(context).pushReplacement(
//       MaterialPageRoute(builder: (context) => const LandingPage()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [Colors.purple[300]!, Colors.orange[300]!],
//           ),
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding: EdgeInsets.all(20.0),
//             child: SingleChildScrollView(
//               child: Form(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     IconButton(
//                       icon: Icon(Icons.arrow_back, color: Colors.white),
//                       onPressed: () => Navigator.pop(context),
//                     ),
//                     SizedBox(height: 20),
//                     Text(
//                       'Let\'s Register Your Account! 📝',
//                       style: GoogleFonts.montserrat(
//                         fontSize: 32,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     Text(
//                       'Hello user, you\'re about to start\na great journey with us! 🎉',
//                       style: TextStyle(fontSize: 18, color: Colors.white70),
//                     ),
//                     SizedBox(height: 40),
//                     TextFormField(
//                       controller: _nameController,
//                       decoration: InputDecoration(
//                         hintText: 'Name',
//                         filled: true,
//                         fillColor: Colors.white.withOpacity(0.9),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(30),
//                           borderSide: BorderSide.none,
//                         ),
//                         prefixIcon:
//                             Icon(Icons.person, color: Colors.purple[700]),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your name';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 30),
//                     TextFormField(
//                       controller: _phoneController,
//                       decoration: InputDecoration(
//                         hintText: 'Phone',
//                         filled: true,
//                         fillColor: Colors.white.withOpacity(0.9),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(30),
//                           borderSide: BorderSide.none,
//                         ),
//                         prefixIcon:
//                             Icon(Icons.phone, color: Colors.purple[700]),
//                       ),
//                     ),
//                     SizedBox(height: 30),
//                     TextFormField(
//                       controller: _emailController,
//                       decoration: InputDecoration(
//                         hintText: 'Email',
//                         filled: true,
//                         fillColor: Colors.white.withOpacity(0.9),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(30),
//                           borderSide: BorderSide.none,
//                         ),
//                         prefixIcon:
//                             Icon(Icons.email, color: Colors.purple[700]),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your email';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 30),
//                     TextFormField(
//                       controller: _passwordController,
//                       obscureText: true,
//                       decoration: InputDecoration(
//                         hintText: 'Password',
//                         filled: true,
//                         fillColor: Colors.white.withOpacity(0.9),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(30),
//                           borderSide: BorderSide.none,
//                         ),
//                         prefixIcon: Icon(Icons.lock, color: Colors.purple[700]),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter a password';
//                         }
//                         if (value.length < 6) {
//                           return 'Password must be at least 6 characters long';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 40),
//                     ElevatedButton(
//                       onPressed: addUser,
//                       child: Text('Sign Up', style: TextStyle(fontSize: 18)),
//                       style: ElevatedButton.styleFrom(
//                         foregroundColor: Colors.purple[700],
//                         minimumSize: Size(double.infinity, 50),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 30),
//                     Center(
//                       child: TextButton(
//                         onPressed: () {
//                           Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => LoginPage()));
//                         },
//                         child: Text('Already have an account? Login 🔑',
//                             style: TextStyle(color: Colors.white)),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('UrbanRide Home'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.exit_to_app),
//             onPressed: () async {
//               await FirebaseAuth.instance.signOut();
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => LandingPage()),
//               );
//             },
//           ),
//         ],
//       ),
//       body: StreamBuilder<DocumentSnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('users')
//             .doc(user?.uid)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }

//           if (!snapshot.hasData) {
//             return Center(child: Text('No user data found'));
//           }

//           var userData = snapshot.data!.data() as Map<String, dynamic>;

//           return Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: [Colors.blue[300]!, Colors.green[300]!],
//               ),
//             ),
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Welcome to UrbanRide! 🚌',
//                     style: GoogleFonts.montserrat(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Text(
//                     'Hello, ${userData['name']}!',
//                     style: TextStyle(fontSize: 22, color: Colors.white),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'Business: ${userData['businessName']}',
//                     style: TextStyle(fontSize: 18, color: Colors.white70),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'Email: ${userData['email']}',
//                     style: TextStyle(fontSize: 18, color: Colors.white70),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'Phone: ${userData['phone']}',
//                     style: TextStyle(fontSize: 18, color: Colors.white70),
//                   ),
//                   SizedBox(height: 40),
//                   ElevatedButton(
//                     onPressed: () {
//                       // TODO: Implement ride booking functionality
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('Ride booking coming soon!')),
//                       );
//                     },
//                     child:
//                         Text('Book a Ride 🚗', style: TextStyle(fontSize: 18)),
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Colors.blue[700],
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
  
//   final CollectionReference usersCollection =
//       FirebaseFirestore.instance.collection('users');

// void signin()
// {

// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topRight,
//             end: Alignment.bottomLeft,
//             colors: [Colors.green[300]!, Colors.blue[300]!],
//           ),
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding: EdgeInsets.all(20.0),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   IconButton(
//                     icon: Icon(Icons.arrow_back, color: Colors.white),
//                     onPressed: () => Navigator.pop(context),
//                   ),
//                   SizedBox(height: 20),
//                   Text(
//                     'Let\'s Sign You In! 🚀',
//                     style: GoogleFonts.montserrat(
//                       fontSize: 32,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'Welcome Back,\nYou\'ve Been Missed! 👋',
//                     style: TextStyle(fontSize: 20, color: Colors.white70),
//                   ),
//                   SizedBox(height: 40),
//                   TextFormField(
//                     controller: _emailController,
//                     decoration: InputDecoration(
//                       hintText: 'Email',
//                       filled: true,
//                       fillColor: Colors.white.withOpacity(0.9),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30),
//                         borderSide: BorderSide.none,
//                       ),
//                       prefixIcon: Icon(Icons.email, color: Colors.blue[700]),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your email';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(height: 20),
//                   TextFormField(
//                     controller: _passwordController,
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       hintText: 'Password',
//                       filled: true,
//                       fillColor: Colors.white.withOpacity(0.9),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30),
//                         borderSide: BorderSide.none,
//                       ),
//                       prefixIcon: Icon(Icons.lock, color: Colors.blue[700]),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your password';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(height: 10),
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: TextButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => ForgotPasswordPage()),
//                         );
//                       },
//                       child: Text('Forgot Password? 🤔',
//                           style: TextStyle(color: Colors.white)),
//                     ),
//                   ),
//                   SizedBox(height: 30),
//                   _isLoading
//                       ? Center(child: CircularProgressIndicator())
//                       : ElevatedButton(
//                           onPressed: _signIn,
//                           child:
//                               Text('Sign in', style: TextStyle(fontSize: 18)),
//                           style: ElevatedButton.styleFrom(
//                             foregroundColor: Colors.blue,
//                             minimumSize: Size(double.infinity, 50),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                           ),
//                         ),
//                   SizedBox(height: 30),
//                   Row(
//                     children: [
//                       Expanded(child: Divider(color: Colors.white70)),
//                       Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 10),
//                         child:
//                             Text('or', style: TextStyle(color: Colors.white70)),
//                       ),
//                       Expanded(child: Divider(color: Colors.white70)),
//                     ],
//                   ),
//                   Center(
//                     child: TextButton(
//                       onPressed: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => SignUpPage()));
//                       },
//                       child: Text("Don't have an account? Register Now 🆕",
//                           style: TextStyle(color: Colors.white)),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ForgotPasswordPage extends StatefulWidget {
//   @override
//   _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
// }

// class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//   // final _newPasswordController = TextEditingController();
//   bool _isLoading = false;
//   bool _emailSent = false;

//   Future<void> _resetPassword() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         _isLoading = true;
//       });
//       try {
//         await FirebaseAuth.instance.sendPasswordResetEmail(
//           email: _emailController.text.trim(),
//         );
//         setState(() {
//           _emailSent = true;
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//               content: Text('Password reset email sent. Check your inbox.')),
//         );
//       } on FirebaseAuthException catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(e.message ?? 'An error occurred')),
//         );
//       } finally {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topRight,
//             end: Alignment.bottomLeft,
//             colors: [Colors.purple[300]!, Colors.blue[300]!],
//           ),
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding: EdgeInsets.all(20.0),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   IconButton(
//                     icon: Icon(Icons.arrow_back, color: Colors.white),
//                     onPressed: () => Navigator.pop(context),
//                   ),
//                   SizedBox(height: 20),
//                   Text(
//                     'Reset Your Password 🔐',
//                     style: GoogleFonts.montserrat(
//                       fontSize: 32,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'Enter your email to receive a password reset link',
//                     style: TextStyle(fontSize: 18, color: Colors.white70),
//                   ),
//                   SizedBox(height: 40),
//                   TextFormField(
//                     controller: _emailController,
//                     decoration: InputDecoration(
//                       hintText: 'Email',
//                       filled: true,
//                       fillColor: Colors.white.withOpacity(0.9),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30),
//                         borderSide: BorderSide.none,
//                       ),
//                       prefixIcon: Icon(Icons.email, color: Colors.purple[700]),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your email';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(height: 30),
//                   _isLoading
//                       ? Center(child: CircularProgressIndicator())
//                       : ElevatedButton(
//                           onPressed: _resetPassword,
//                           child: Text('Send Reset Link',
//                               style: TextStyle(fontSize: 18)),
//                           style: ElevatedButton.styleFrom(
//                             foregroundColor: Colors.purple,
//                             minimumSize: Size(double.infinity, 50),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                           ),
//                         ),
//                   if (_emailSent)
//                     Padding(
//                       padding: const EdgeInsets.only(top: 20),
//                       child: Text(
//                         'Check your email for the password reset link',
//                         style: TextStyle(color: Colors.white, fontSize: 16),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
