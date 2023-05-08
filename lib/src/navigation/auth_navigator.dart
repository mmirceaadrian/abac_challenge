import 'package:abac_challenge/src/bloc/auth/cubit/auth_cubit.dart';
import 'package:abac_challenge/src/screens/auth/login_view.dart';
import 'package:abac_challenge/src/screens/auth/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthNavigator extends StatelessWidget {
  const AuthNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      return Navigator(
        pages: [
          if (state == AuthState.login) MaterialPage(child: LoginView()),
          if (state == AuthState.register) MaterialPage(child: RegisterView()),
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }
}

