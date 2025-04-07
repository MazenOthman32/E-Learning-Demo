import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Resources/color_resources.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  String _role = 'Student'; // Default role
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _agreedToTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                // First Name & Last Name
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        label: 'First Name',
                        controller: _firstNameController,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildTextField(
                        label: 'Last Name',
                        controller: _lastNameController,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Email
                _buildTextField(
                  label: 'Email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) {
                    if (val == null || val.isEmpty) return 'Email is required';
                    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                    if (!regex.hasMatch(val)) return 'Enter a valid email';
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Password
                _buildTextField(
                  label: 'Password',
                  obscureText: _obscurePassword,
                  suffix: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                  controller: _passwordController,
                  validator: (val) {
                    if (val == null || val.isEmpty)
                      return 'Password is required';
                    if (val.length < 6) return 'Minimum 6 characters';
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Confirm Password
                _buildTextField(
                  label: 'Confirm Password',
                  obscureText: _obscureConfirm,
                  suffix: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureConfirm = !_obscureConfirm;
                      });
                    },
                    icon: Icon(
                      _obscureConfirm ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                  validator: (val) {
                    if (val != _passwordController.text)
                      return 'Passwords don\'t match';
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Role Selector (Student or Teacher)
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        activeColor: ColorResources.secondry,
                        title: const Text('Student'),
                        value: 'Student',
                        groupValue: _role,
                        onChanged: (String? value) {
                          setState(() {
                            _role = value!;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        activeColor: ColorResources.secondry,
                        title: const Text('Teacher'),
                        value: 'Teacher',
                        groupValue: _role,
                        onChanged: (String? value) {
                          setState(() {
                            _role = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Terms Checkbox
                Row(
                  children: [
                    Checkbox(
                      activeColor: Colors.red,
                      value: _agreedToTerms,
                      onChanged: (val) {
                        setState(() => _agreedToTerms = val ?? false);
                      },
                    ),
                    const Expanded(
                      child: Text.rich(
                        TextSpan(
                          text: "I agree to the ",
                          style: TextStyle(color: Colors.black54),
                          children: [
                            TextSpan(
                              text: "Terms & Conditions",
                              style: TextStyle(color: ColorResources.secondry),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // Sign Up Button
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (!_agreedToTerms) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please accept terms & conditions"),
                          ),
                        );
                      } else {
                        try {
                          final credential = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );
                          FirebaseAuth.instance.currentUser!
                              .sendEmailVerification();

                          // Save the role to Firestore
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .set({
                                'firstName': _firstNameController.text,
                                'lastName': _lastNameController.text,
                                'email': _emailController.text,
                                'role': _role, // Save selected role
                              });

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please Verify Your Mail"),
                            ),
                          );
                          Navigator.pushReplacementNamed(context, '/login');
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            print('The password provided is too weak.');
                          } else if (e.code == 'email-already-in-use') {
                            print('The account already exists for that email.');
                          }
                        } catch (e) {
                          print(e);
                        }
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorResources.secondry,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 80,
                      vertical: 15,
                    ),
                  ),
                  child: Text(
                    "Sign Up",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.white,
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

  Widget _buildTextField({
    required String label,
    TextEditingController? controller,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? suffix,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.black54),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black54),
        filled: true,
        fillColor: Colors.transparent,
        suffixIcon: suffix,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black45),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorResources.secondry),
          borderRadius: BorderRadius.circular(20),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
      validator: validator,
    );
  }
}
