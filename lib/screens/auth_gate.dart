import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_pertemuanenam/screens/sign_up_screen.dart';
import 'package:firebase_pertemuanenam/screens/todo_screen.dart';
import 'package:flutter/material.dart';
import '../services/auth/auth_service.dart';


class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthService();

    return StreamBuilder<User?>(
      stream: auth.authStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return const Scaffold(
            body: Center(child: Text("Gagal memuat status Login")),
          );
        }

        // Jika user sudah login (ada data), arahkan ke Profile
        if (snapshot.hasData) {
          return TodoScreen();
        }

        // Jika user belum login, arahkan ke Sign In
        return const SignInScreen();
      },
    );
  }
}