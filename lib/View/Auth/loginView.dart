import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Resources/color_resources.dart';
import '../home/homeView.dart';
import '../home/testView.dart';


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
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkIsLoggedIn();
    _passwordVisible = false;
  }

  void checkIsLoggedIn() async {
 //   loginState = await SharedPreferences.getInstance();
  //  isLoggedIn = loginState.getBool('isLoggedIn') ?? false;

    if (isLoggedIn == true) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => HomeView(),
        ),
            (route) => false,
      );
    }
  }

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
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        hintText: 'Enter your password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                          icon: Icon(_passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
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
                    onPressed: () =>
                        Navigator.pushNamed(context, '/forgetPassword'),
                    child: const Text(
                      'Forget password?',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child:    SizedBox(

                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => HomeView(),),);
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
                          style: GoogleFonts.poppins(fontSize: 16, color: Colors.white ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // TextButton(
              //   onPressed: () {
              //     Navigator.push(context, MaterialPageRoute(builder: (context) => test(),));
              //     // String? encodeQueryParameters(Map<String, String> params) {
              //     //   return params.entries
              //     //       .map((e) =>
              //     //   '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
              //     //       .join('&');
              //     // }
              //     //
              //     // final Uri emailLaunchUri = Uri(
              //     //   scheme: 'mailto',
              //     //   path: 'online@edutiv.com',
              //     //   query: encodeQueryParameters(
              //     //       <String, String>{'subject': 'Request an Account'}),
              //     // );
              //
              //   },
              //   child:
              //    Text('Already have an account?' ,
              //       style: GoogleFonts.poppins(fontSize: 13, color: ColorResources.secondry ),),
              //   ),

            ],
          ),
        ),
      ),
    );
  }
}

class buildLoginTextHeader extends StatelessWidget {
  const buildLoginTextHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 32),
height: 350,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/login.png',
            width: 250,
            height: 250,
          ),
           Text(
            'Welcome Back',
            style: GoogleFonts.poppins(fontSize: 28,  ),
          ),
           Text(
            'Please login with your account to continue',
            style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey ),
          ),
        ],
      ),
    );
  }
}

class buildEmailField extends StatelessWidget {
  const buildEmailField({
    Key? key,
    required this.emailController,
  }) : super(key: key);

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: emailController,
      validator: (email) {

      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        hintText: 'Enter your email',
      ),
    );
  }
}