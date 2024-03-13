import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/lib/core/bloc/application_bloc.dart';

class FacebookLoginButton extends StatelessWidget {
  Future<void> _handleSignIn(BuildContext context) async {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      // The user is successfully logged in
      // You can now use the AccessToken to perform authenticated operations
      final AccessToken accessToken = result.accessToken!;
      // Send accessToken to your bloc or backend to complete the sign-in process
      // Example: BlocProvider.of<ApplicationBloc>(context).add(FacebookSignInEvent(accessToken));
      // Note: Implement your ApplicationBloc to handle FacebookSignInEvent with AccessToken data

      print('Facebook sign in successful: ${accessToken.token}');
    } else {
      // Handle error or cancellation
      print('Facebook sign in failed: ${result.status}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(Icons.facebook), // Use a relevant icon for Facebook login
      label: Text('Sign in with Facebook'),
      onPressed: () => _handleSignIn(context),
      style: ElevatedButton.styleFrom(
        primary: Color(0xFF3b5998), // Facebook's brand color
        onPrimary: Colors.white,
        minimumSize: Size(double.infinity, 50), // Make the button wide
      ),
    );
  }
}