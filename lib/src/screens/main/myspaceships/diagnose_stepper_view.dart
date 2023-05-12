import 'package:abac_challenge/src/bloc/main/main_cubit.dart';
import 'package:abac_challenge/src/bloc/myspaceship/diagnosestepper/diagnosestepper_bloc.dart';
import 'package:abac_challenge/src/bloc/myspaceship/diagnosestepper/diagnosestepper_event.dart';
import 'package:abac_challenge/src/bloc/myspaceship/diagnosestepper/diagnosestepper_state.dart';
import 'package:abac_challenge/src/models/spaceship_model.dart';
import 'package:abac_challenge/src/repository/diagnose_repo.dart';
import 'package:abac_challenge/src/widgets/stepper/stepone_component.dart';
import 'package:abac_challenge/src/widgets/stepper/stepthree_component.dart';
import 'package:abac_challenge/src/widgets/stepper/steptwo_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiagnoseStepperView extends StatelessWidget {
  final Spaceship spaceship;
  const DiagnoseStepperView({Key? key, required this.spaceship})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DiagnoseStepperBloc(
        diagnoseRepo: context.read<DiagnoseRepo>(),
        mainCubit: context.read<MainCubit>(),
      )
        ..add(
          DiagnoseStepperGetAppointmentCells(
            startDate: DateTime.now(),
            endDate: DateTime.now().add(Duration(days: 7)),
          ),
        )
        ..add(
          DiagnoseStepperInitialize(spaceship: spaceship),
        ),
      child: BlocListener<DiagnoseStepperBloc, DiagnoseStepperState>(
        listener: (context, state) {
          if (state.error != '') {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error!),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<DiagnoseStepperBloc, DiagnoseStepperState>(
          builder: (context, state) {
            return Stack(children: <Widget>[
              Stepper(
                currentStep: state.currentStepperIndex,
                type: StepperType.horizontal,
                steps: [
                  buildStepOne(context),
                  buildStepTwo(context),
                  buildStepThree(spaceship, context),
                ],
                controlsBuilder: (context, controlsDetails) {
                  return Container();
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: _bottomBar(state.returnButtonText, state.nextButtonText),
              ),
            ]);
          },
        ),
      ),
    );
  }

  Widget _bottomBar(String? returnButtonText, String? nextButtonText) {
    String returnText = returnButtonText ?? 'INAPOI';
    String nextText = nextButtonText ?? 'INAINTE';
    return BlocBuilder<DiagnoseStepperBloc, DiagnoseStepperState>(
      builder: (context, state) {
        return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TextButton(
                onPressed: () => {
                  context
                      .read<DiagnoseStepperBloc>()
                      .add(DiagnoseStepperPreviousStep())
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(returnText,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54)),
                ),
              ),
              TextButton(
                onPressed: () => {
                  context
                      .read<DiagnoseStepperBloc>()
                      .add(DiagnoseStepperNextStep())
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(nextText,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54)),
                ),
              ),
            ]);
      },
    );
  }
}
