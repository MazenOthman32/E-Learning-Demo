import 'package:Growing_Minds/View/StudentAccount/studentMainView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Resources/color_resources.dart';

import '../testView.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var formKey = GlobalKey<FormState>();
  bool _passwordVisible = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // late SharedPreferences loginState;
  // bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    //    checkIsLoggedIn();
    _passwordVisible = false;
  }

  void showLoginErrorBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.red.shade400,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error, color: Colors.white, size: 40),
              SizedBox(height: 10),
              Text(
                "Login Failed",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Invalid email or password. Please try again.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  ),
                  child: Text(
                    "OK",
                    style: TextStyle(color: Colors.red.shade400, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // void checkIsLoggedIn() async {
  //      loginState = await SharedPreferences.getInstance();
  //     isLoggedIn = loginState.getBool('isLoggedIn') ?? false;
  //
  //   if (isLoggedIn == true) {
  //     Navigator.pushAndRemoveUntil(
  //       context,
  //       MaterialPageRoute(builder: (context) => StudentMainView()),
  //       (route) => false,
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.primary,
      // appBar: AppBar(
      //   title: Text('Reda'),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const buildLoginTextHeader(),
              Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Email'),
                    buildEmailField(emailController: emailController),
                    const SizedBox(height: 14),
                    const Text('Password'),
                    TextFormField(
                      controller: passwordController,
                      obscureText: !_passwordVisible,
                      validator: (val) {
                        if (val != null && val.length < 4) {
                          return 'Enter Minimum 4 Characters';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        hintText: 'Enter your password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed:
                        () => Navigator.pushNamed(context, '/forgetPassword'),
                    child: const Text(
                      'Forget password?',
                      style: TextStyle(color: ColorResources.secondry),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      child: ElevatedButton(
                        // onPressed: () {
                        //   if (emailController.text == "Student@Demo" &&
                        //       passwordController.text == "123456") {
                        //     Navigator.pushReplacementNamed(
                        //       context,
                        //       '/studentMainView',
                        //     );
                        //   } else if (emailController.text == "Teacher@Demo" &&
                        //       passwordController.text == "123456") {
                        //     Navigator.pushReplacementNamed(
                        //       context,
                        //       '/teacherMainView',
                        //     );
                        //   } else {
                        //     showLoginErrorBottomSheet(context);
                        //   }
                        // },
                        onPressed: () async {
                          try {
                            final credential = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );

                            if (FirebaseAuth
                                .instance
                                .currentUser!
                                .emailVerified) {
                              // Fetch the user role from Firestore
                              final docSnapshot =
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(
                                        FirebaseAuth.instance.currentUser!.uid,
                                      )
                                      .get();

                              if (docSnapshot.exists) {
                                String role = docSnapshot['role'];

                                // Navigate based on role
                                if (role == 'Student') {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    '/studentMainView',
                                  );
                                } else if (role == 'Teacher') {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    '/teacherMainView',
                                  );
                                }
                              }
                            } else {
                              showLoginErrorBottomSheet(context);
                            }
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found' ||
                                e.code == 'wrong-password') {
                              showLoginErrorBottomSheet(context);
                            } else {
                              showLoginErrorBottomSheet(context);
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
                          "Log In",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/signUp'),
                    child: Row(
                      children: [
                        const Text(
                          'Dont have an account? ',
                          style: TextStyle(color: Colors.black54),
                        ),
                        const Text(
                          'Create one',
                          style: TextStyle(color: ColorResources.secondry),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class buildLoginTextHeader extends StatelessWidget {
  const buildLoginTextHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 32),
      height: 350,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/login.png', width: 250, height: 250),
          Text('Welcome Back', style: GoogleFonts.poppins(fontSize: 28)),
          Text(
            'Please login with your account to continue',
            style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class buildEmailField extends StatelessWidget {
  const buildEmailField({Key? key, required this.emailController})
    : super(key: key);

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: emailController,
      validator: (email) {},
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        hintText: 'Enter your email',
      ),
    );
  }
}
