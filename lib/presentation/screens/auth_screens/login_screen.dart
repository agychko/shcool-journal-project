import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journal/presentation/blocs/auth_screen/auth_screen_bloc.dart';
import 'package:journal/presentation/screens/auth_screens/signup_screen.dart';

import '../../blocs/journal_screen/journal_screen_bloc.dart';
import '../../widgets/custom_text_field_widget.dart';
import '../journal_screen/journal_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void signInUser() {
    context
        .read<AuthScreenBloc>()
        .add(Login(emailController.text, passwordController.text));
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider(
              create: (context) => JournalScreenBloc(),
              child: const JournalScreen()),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthScreenBloc, AuthScreenState>(
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: CustomTextFieldWidget(
                      controller: emailController,
                      hintText: 'Enter your email',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: CustomTextFieldWidget(
                      controller: passwordController,
                      hintText: 'Enter your password',
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: signInUser,
                    style: ButtonStyle(
                      // backgroundColor: MaterialStateProperty.all(Colors.blue),
                      textStyle: MaterialStateProperty.all(
                        const TextStyle(color: Colors.white),
                      ),
                      minimumSize: MaterialStateProperty.all(
                        Size(MediaQuery.of(context).size.width / 2.5, 50),
                      ),
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupScreen(),
                        ),
                      );
                    },
                    child: const Text('Not have Account?'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

}
