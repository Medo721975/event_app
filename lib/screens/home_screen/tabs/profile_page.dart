import 'package:evently_c17_fri/providers/auth_provider.dart';
import 'package:evently_c17_fri/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/firebase_functions.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          FirebaseFunctions.signOut();
          Navigator.pushNamedAndRemoveUntil(
              context, LoginScreen.routeName, (route) => false);
        },
        child: const Text("Sign Out"),
      ),
    );
  }
}
