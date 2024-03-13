import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/lib/core/bloc/application_bloc.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApplicationBloc, ApplicationState>(
      builder: (context, state) {
        if (state is ApplicationLoadingState) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Dashboard'),
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is ApplicationLoadedState) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Dashboard'),
            ),
            body: Center(
              child: Text('Welcome, ${state.data}'),
            ),
          );
        } else if (state is ApplicationErrorState) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Dashboard'),
            ),
            body: Center(
              child: Text('Error: ${state.message}'),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text('Dashboard'),
            ),
            body: Center(
              child: Text('Please log in to see the dashboard.'),
            ),
          );
        }
      },
    );
  }
}