import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/lib/core/bloc/application_bloc.dart';

class GoogleLoginButton extends StatelessWidget {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _handleSignIn(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        // Here, you can send googleUser data to your bloc or directly to your backend to complete the sign-in process
        // For example, using bloc: BlocProvider.of<ApplicationBloc>(context).add(GoogleSignInEvent(googleUser));
        // Note: Implement your ApplicationBloc to handle GoogleSignInEvent with GoogleSignInAccount data

        print('Google sign in successful: ${googleUser.email}');
      }
    } catch (error) {
      print('Google sign in failed: $error');
      // Handle sign in error
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(Icons.login), // Use a relevant icon for Google login
      label: Text('Sign in with Google'),
      onPressed: () => _handleSignIn(context),
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        onPrimary: Colors.black,
        minimumSize: Size(double.infinity, 50), // Make the button wide
      ),
    );
  }
}