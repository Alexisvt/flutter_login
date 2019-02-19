import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/authentication_bloc.dart';
import '../../bloc/events/authentication_events.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        child: Center(
          child: RaisedButton(
            child: Text('Logout'),
            onPressed: () {
              authenticationBloc.dispatch(LoggedOut());
            },
          ),
        ),
      ),
    );
  }
}
