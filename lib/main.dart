import 'package:abac_challenge/dependency_injection.dart';
import 'package:abac_challenge/src/bloc/session/session_cubit.dart';
import 'package:abac_challenge/src/navigation/session_navigator.dart';
import 'package:abac_challenge/src/repository/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constants.dart';

void main() {
  // This line is used to configure the dependency injection
  Injector.configure(Flavor.MOCK);
  // Injector.configure(Flavor.PROD);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: kPrimaryColor,
              primaryContainer: kPrimaryLightColor,
              secondary: kPrimaryColor)),
      home: Scaffold(
          body: SafeArea(
        child: MultiRepositoryProvider(
          providers: [
            RepositoryProvider<AuthRepo>(
              create: (context) => Injector().authRepo,
            ),
          ],
          child: BlocProvider(
              create: (context) =>
                  SessionCubit(authRepo: context.read<AuthRepo>()),
              child: const SessionNavigator()),
        ),
      )),
    );
  }
}
