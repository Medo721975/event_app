import 'package:evently_c17_fri/core/firebase_functions.dart';
import 'package:evently_c17_fri/providers/auth_provider.dart';
import 'package:evently_c17_fri/screens/auth/register.dart';
import 'package:evently_c17_fri/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "loginScreen";

  LoginScreen({super.key});

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  static const Color _scaffoldBg  = Color(0xFFEEF0FF);
  static const Color _primaryNavy = Color(0xFF1A237E);
  static const Color _cardWhite   = Color(0xFFFFFFFF);
  static const Color _borderColor = Color(0xFFD6DAF0);
  static const Color _hintColor   = Color(0xFFB0B8D8);
  static const Color _bodyText    = Color(0xFF4A4A6A);
  static const Color _dividerColor= Color(0xFFCDD0E8);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: _scaffoldBg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 40),
                  Image.asset('assets/images/logo.png', height: 40),

                  const SizedBox(height: 40),
                  Text(
                    'Login to your account',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: _primaryNavy,
                    ),
                    textAlign: TextAlign.start,
                  ),

                  const SizedBox(height: 30),
                  TextFormField(
                    controller: emailController,
                    style: TextStyle(color: _primaryNavy),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your email";
                      }
                      final bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                      ).hasMatch(value);
                      if (!emailValid) {
                        return "Please enter a valid email";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      hintStyle: TextStyle(color: _hintColor),
                      filled: true,
                      fillColor: _cardWhite,
                      prefixIcon: ImageIcon(
                        AssetImage("assets/images/sms.png"),
                        color: _hintColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: _borderColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: _borderColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: _primaryNavy, width: 1.6),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    style: TextStyle(color: _primaryNavy),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password";
                      }
                      if (value.length < 6) {
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
                      hintStyle: TextStyle(color: _hintColor),
                      filled: true,
                      fillColor: _cardWhite,
                      prefixIcon: ImageIcon(
                        AssetImage("assets/images/lock.png"),
                        color: _hintColor,
                      ),
                      suffixIcon: ImageIcon(
                        AssetImage("assets/images/eye-slash.png"),
                        color: _hintColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: _borderColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: _borderColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: _primaryNavy, width: 1.6),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        foregroundColor: _primaryNavy,
                      ),
                      child: const Text(
                        'Forget Password?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        FirebaseFunctions.login(
                          emailController.text,
                          passwordController.text,
                              () async {
                            provider.initUser();
                            await Future.delayed(Duration(seconds: 5));
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              HomeScreen.routeName,
                                  (route) => false,
                            );
                          },
                              (message) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(message)));
                            Navigator.pop(context);
                          },
                              () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return Center(
                                    child: CircularProgressIndicator());
                              },
                            );
                          },
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primaryNavy,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),

                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(color: _bodyText),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, RegisterScreen.routeName);
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: _primaryNavy,
                        ),
                        child: const Text(
                          'Signup',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                          child: Divider(color: _dividerColor, thickness: 1)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Or',
                          style: TextStyle(color: _primaryNavy),
                        ),
                      ),
                      Expanded(
                          child: Divider(color: _dividerColor, thickness: 1)),
                    ],
                  ),

                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      FirebaseFunctions.signInWithGoogle(
                        onSuccess: () {
                          provider.initUser();
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            HomeScreen.routeName,
                                (route) => false,
                          );
                        },
                        onError: (message) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(message)));
                        },
                      );
                    },
                    icon: Image.asset('assets/images/google.png', height: 24),
                    label: const Text('Login with Google'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: _primaryNavy,
                      backgroundColor: _cardWhite,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: _borderColor),
                      ),
                    ),
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