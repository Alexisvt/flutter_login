import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/user_repository.dart';

import '../../bloc/authentication_bloc.dart';
import '../../bloc/login_bloc.dart';
import '../widgets/login_form.dart';

class LoginPage extends StatefulWidget {
  final UserRepository userRepository;

  LoginPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc _loginBloc;
  AuthenticationBloc _authenticationBloc;

  UserRepository get _userRepository => widget.userRepository;

  @override
  void initState() {
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _loginBloc = LoginBloc(
      userRepository: _userRepository,
      authenticationBloc: _authenticationBloc,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      bloc: _loginBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: LoginForm(),
      ),
    );
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }
}
