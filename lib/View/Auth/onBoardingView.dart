import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../Resources/color_resources.dart';
import '../../Resources/image_Resources.dart';

class OnBoardingView extends StatefulWidget {
  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  @override
  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    Navigator.of(
      context,
    ).pushNamedAndRemoveUntil('/studentMainView', (route) => false);
  }

  // Future<UserCredential> signInWithFacebook() async {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.primary,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Growing Minds Education Game",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),

                  Image.asset(ImageResources.loginPng, height: 200),
                  const SizedBox(height: 20),
                  Text(
                    "This is BrainByte. Your pocket-sized tutor. Unlock learning.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
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
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.black26, // Light grey color
                          thickness: 1, // Line thickness
                          indent: 20, // Spacing from the left
                          endIndent: 20, // Spacing before "or"
                        ),
                      ),
                      Text(
                        "or",
                        style: GoogleFonts.poppins(
                          fontSize: 14,

                          color: Colors.black87,
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.black26,
                          thickness: 1,
                          indent: 20, // Spacing after "or"
                          endIndent: 20, // Spacing from the right
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Image.asset(ImageResources.googlePng, scale: 1.5),
                        onPressed: () async {
                          signInWithGoogle();
                        },
                      ),
                      SizedBox(width: 25),
                      IconButton(
                        icon: Image.asset(
                          ImageResources.facebookPng,
                          scale: 1.5,
                        ),
                        onPressed: () async {
                          //    signInWithFacebook();
                          signInWithGoogle();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an Account?",
                        style: GoogleFonts.poppins(color: Colors.black),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/signUp');
                        },
                        child: Text(
                          "Create Account",
                          style: GoogleFonts.poppins(
                            color: ColorResources.secondry,
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
      ),
    );
  }
}
