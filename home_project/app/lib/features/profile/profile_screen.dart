import 'package:flutter/material.dart';
import 'package:app/lib/core/repository/user_repository.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserRepository _userRepository = UserRepository();
  Future<User>? _userFuture;

  @override
  void initState() {
    super.initState();
    // This should ideally be triggered by some user action or state change
    _userFuture = _userRepository.getUserById("user_id");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: FutureBuilder<User>(
        future: _userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return ListTile(
              leading: Icon(Icons.person),
              title: Text(snapshot.data!.name),
              subtitle: Text(snapshot.data!.email),
            );
          } else {
            return Center(child: Text('User not found'));
          }
        },
      ),
    );
  }
}