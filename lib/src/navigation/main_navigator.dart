import 'package:abac_challenge/src/bloc/main/main_cubit.dart';
import 'package:abac_challenge/src/bloc/main/main_state.dart';
import 'package:abac_challenge/src/repository/spaceships_repo.dart';
import 'package:abac_challenge/src/screens/main/myspaceships/diagnose_stepper_view.dart';
import 'package:abac_challenge/src/screens/main/myspaceships/myspaceship_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screens/main/myappointments/myappointments_view.dart';

/// Navigator for the main screen
///
/// This navigator is used to navigate between the myspaceship and myappointments screens
class MainNavigator extends StatelessWidget {
  const MainNavigator({Key? key}) : super(key: key);

  /// This method is used to navigate to the myspaceship or myappointments screen
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
              if (state is SpaceshipsState ||
                  state is DiagnoseStepperState) ...[
                MaterialPage(
                  child: SpaceshipView(),
                ),
                if (state is DiagnoseStepperState)
                  MaterialPage(
                    child: DiagnoseStepperView(),
                  )
              ],
              if (state is AppointmentsState)
                MaterialPage(
                  child: AppointmentsView(),
                )
            ],
            onPopPage: (route, result) => route.didPop(result),
          ));
    });
  }
}
