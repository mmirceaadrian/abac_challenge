import 'package:abac_challenge/src/bloc/main/main_cubit.dart';
import 'package:abac_challenge/src/bloc/main/main_state.dart';
import 'package:abac_challenge/src/repository/spaceships_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainNavigator extends StatelessWidget {
  const MainNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(builder: (context, state) {
      return MultiRepositoryProvider(
          providers: [
            RepositoryProvider<SpaceshipsRepo>(
              create: (context) => SpaceshipsRepo(),
            ),
          ],
          child: Navigator(
            pages: [
              if (state is SpaceshipsState)
                MaterialPage(
                  child: Container(color: Colors.red),
                ),
              if (state is AppointmentsState)
                MaterialPage(
                  child: Container(color: Colors.blue),
                )
            ],
            onPopPage: (route, result) => route.didPop(result),
          ));
    });
  }
}
