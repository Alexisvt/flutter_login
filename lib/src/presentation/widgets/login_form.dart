import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/events/login_events.dart';
import '../../bloc/states/login_states.dart';
import '../../bloc/login_bloc.dart';

class LoginForm extends StatelessWidget {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final LoginBloc loginBloc = BlocProvider.of(context);
    return BlocBuilder<LoginEvent, LoginState>(
      bloc: loginBloc,
      builder: (
        BuildContext context,
        LoginState state,
      ) {
        if (state is LoginFailure) {
          _onWidgetDidBuild(() {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ));
          });
        }

        return Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'username'),
                controller: _usernameController,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'password'),
                controller: _passwordController,
                obscureText: true,
              ),
              RaisedButton(
                onPressed: state is! LoginLoading
                    ? () => _onLoginButtonPressed(loginBloc)
                    : null,
                child: Text('Login'),
              ),
              Container(
                child:
                    state is LoginLoading ? CircularProgressIndicator() : null,
              )
            ],
          ),
        );
      },
    );
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  _onLoginButtonPressed(LoginBloc loginBloc) {
    loginBloc.dispatch(
      LoginButtonPressed(
        username: _usernameController.text,
        password: _passwordController.text,
      ),
    );
  }
}
