import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _idNumberController =
      TextEditingController(); // New
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _collegeController =
      TextEditingController(); // Changed from course
  final TextEditingController _yearSectionController =
      TextEditingController(); // Changed from section

  // Firebase Instances
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign-up function
  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Register user with Firebase Authentication
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // Get the user's UID
        String uid = userCredential.user!.uid;

        // Store additional user details in Firestore
        await _firestore.collection("users").doc(uid).set({
          "fullName": _fullNameController.text.trim(),
          "email": _emailController.text.trim(),
          "idNumber": _idNumberController.text.trim(),
          "college": _collegeController.text.trim(),
          "yearAndSection": _yearSectionController.text.trim(),
          "createdAt": Timestamp.now(),
        });

        // Navigate to Home Screen after successful registration
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${e.toString()}")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign Up',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.pink.shade100,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Create an Account",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                // Full Name
                TextFormField(
                  controller: _fullNameController,
                  decoration: const InputDecoration(
                    labelText: "Full Name",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your full name";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),

                // Email
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains('@')) {
                      return "Please enter a valid email address";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),

                // ID Number (New)
                TextFormField(
                  controller: _idNumberController,
                  decoration: const InputDecoration(
                    labelText: "ID Number",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your ID number";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),

                // Password
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),

                // College Dropdown
                DropdownButtonFormField<String>(
                  value: _collegeController.text.isNotEmpty
                      ? _collegeController.text
                      : null,
                  decoration: const InputDecoration(
                    labelText: "College",
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    'College of Accounting and Business Education',
                    'College of Arts and Humanities',
                    'College of Computer Studies',
                    'College of Engineering and Architecture',
                    'College of Human Environmental Sciences and Food Studies',
                    'College of Music',
                    'College of Medical and Biological Science',
                    'College of Nursing',
                    'College of Pharmacy and Chemistry',
                    'College of Teacher Education',
                  ]
                      .map((college) => DropdownMenuItem(
                            value: college,
                            child: Text(college),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _collegeController.text = value!;
                    });
                  },
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please select your college'
                      : null,
                ),
                const SizedBox(height: 15),

                // Year Level & Section (Changed from Section)
                TextFormField(
                  controller: _yearSectionController,
                  decoration: const InputDecoration(
                    labelText: "Year Level & Section",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your year level and section";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Sign Up Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _signUp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink.shade700,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 16, color: Colors.white),
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
