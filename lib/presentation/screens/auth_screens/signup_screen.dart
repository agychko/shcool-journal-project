import 'package:flutter/material.dart';
import 'package:journal/presentation/screens/auth_screens/login_screen.dart';
import 'package:journal/presentation/widgets/custom_text_field_widget.dart';

import '../../../data/sources/remote/user_api_source.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final UserApiSource authService = UserApiSource();

  void signupUser() {
    if (_formKey.currentState!.validate()) {
      // authService.signUpUser(
      //   // context: context,
      //   firstName: firstNameController.text,
      //   lastName: lastNameController.text,
      //   email: emailController.text,
      //   password: passwordController.text,
      // );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Signup",
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                Container(
                  width: MediaQuery.of(context).size.width / 1.3,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextFieldWidget(
                    controller: firstNameController,
                    hintText: 'Enter your first name',
                    validator: (firstName) {
                      if (firstName == null || firstName.isEmpty) {
                        return 'Can\'t be empty';
                      }
                      if (firstName.length < 3) {
                        return 'Too short';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width / 1.3,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextFieldWidget(
                    controller: lastNameController,
                    hintText: 'Enter your last name',
                    validator: (lastName) {
                      if (lastName == null || lastName.isEmpty) {
                        return 'Can\'t be empty';
                      }
                      if (lastName.length < 3) {
                        return 'Too short';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width / 1.3,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextFieldWidget(
                    controller: emailController,
                    hintText: 'Enter your email',
                    keyboardType: TextInputType.emailAddress,
                    validator: (email) {
                      if (email == null ||
                          email.isEmpty ||
                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(email)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width / 1.3,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextFieldWidget(
                    controller: passwordController,
                    hintText: 'Enter your password',
                    validator: (password) {
                      if (password == null || password.isEmpty) {
                        return 'Can\'t be empty';
                      }
                      if (password.length < 8) {
                        return 'Too short';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: signupUser,
                  style: ButtonStyle(
                    // backgroundColor: MaterialStateProperty.all(Colors.blue),
                    textStyle: MaterialStateProperty.all(
                      const TextStyle(color: Colors.white),
                    ),
                    minimumSize: MaterialStateProperty.all(
                      Size(MediaQuery.of(context).size.width / 4, 50),
                    ),
                  ),
                  child: const Text(
                    "Sign up",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: const Text('Login User?'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
