import 'package:abac_challenge/src/bloc/auth/cubit/auth_cubit.dart';
import 'package:abac_challenge/src/bloc/session/session_cubit.dart';
import 'package:abac_challenge/src/bloc/session/session_state.dart';
import 'package:abac_challenge/src/navigation/auth_navigator.dart';
import 'package:abac_challenge/src/screens/main/main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SessionNavigator extends StatelessWidget {
  const SessionNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(builder: (context, state) {
      return Navigator(
        pages: [
          if (state is UnkownSessionState) MaterialPage(child: Container()),
          if (state is AuthenticatedSessionState)
            MaterialPage(child: MainView()),
          if (state is UnauthenticatedSessionState)
            MaterialPage(
                child: BlocProvider(
                    create: (context) =>
                        AuthCubit(sessionCubit: context.read<SessionCubit>()),
                    child: const AuthNavigator())),
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }
}
