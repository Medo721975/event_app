import 'package:evently_c17_fri/core/firebase_functions.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "registerScreen";

  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var emailController    = TextEditingController();
  var passwordController = TextEditingController();
  var nameController     = TextEditingController();
  var formKey            = GlobalKey<FormState>();
  static const Color _scaffoldBg   = Color(0xFFEEF0FF);
  static const Color _primaryNavy  = Color(0xFF1A237E);
  static const Color _cardWhite    = Color(0xFFFFFFFF);
  static const Color _borderColor  = Color(0xFFD6DAF0);
  static const Color _hintColor    = Color(0xFFB0B8D8);
  static const Color _bodyText     = Color(0xFF4A4A6A);
  static const Color _dividerColor = Color(0xFFCDD0E8);

  InputDecoration _fieldDecoration({
    required String hint,
    required Widget prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: _hintColor),
      filled: true,
      fillColor: _cardWhite,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
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
    );
  }

  @override
  Widget build(BuildContext context) {
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
                    'Create your account',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: _primaryNavy,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 30),
                  TextFormField(
                    controller: nameController,
                    style: TextStyle(color: _primaryNavy),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your name";
                      }
                      return null;
                    },
                    decoration: _fieldDecoration(
                      hint: 'Enter your name',
                      prefixIcon: Icon(Icons.person_outline, color: _hintColor),
                    ),
                  ),

                  const SizedBox(height: 20),
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
                    decoration: _fieldDecoration(
                      hint: 'Enter your email',
                      prefixIcon: Icon(Icons.email_outlined, color: _hintColor),
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
                      if (value != passwordController.text) {
                        return "Passwords do not match";
                      }
                      return null;
                    },
                    decoration: _fieldDecoration(
                      hint: 'Enter your password',
                      prefixIcon: Icon(Icons.lock_outline, color: _hintColor),
                      suffixIcon: Icon(Icons.visibility_off_outlined, color: _hintColor),
                    ),
                  ),

                  const SizedBox(height: 20),
                  TextFormField(
                    obscureText: true,
                    style: TextStyle(color: _primaryNavy),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your name";
                      }
                      if (value != passwordController.text) {
                        return "Passwords do not match";
                      }
                      return null;
                    },
                    decoration: _fieldDecoration(
                      hint: 'Confirm your password',
                      prefixIcon: Icon(Icons.lock_outline, color: _hintColor),
                      suffixIcon: Icon(Icons.visibility_off_outlined, color: _hintColor),
                    ),
                  ),

                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        FirebaseFunctions.createUser(
                          emailController.text,
                          passwordController.text,
                          nameController.text,
                              () {
                            Navigator.pop(context);
                          },
                              (message) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(message)));
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
                      'Sign up',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),

                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(color: _bodyText),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: _primaryNavy,
                        ),
                        child: const Text(
                          'Login',
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
                      Expanded(child: Divider(color: _dividerColor, thickness: 1)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Or',
                          style: TextStyle(color: _primaryNavy),
                        ),
                      ),
                      Expanded(child: Divider(color: _dividerColor, thickness: 1)),
                    ],
                  ),

                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Image.asset('assets/images/google.png', height: 24),
                    label: const Text(
                      'Sign up with Google',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
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