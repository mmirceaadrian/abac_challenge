import 'package:abac_challenge/src/bloc/main/main_cubit.dart';
import 'package:abac_challenge/src/bloc/myspaceship/diagnosestepper/diagnosestepper_bloc.dart';
import 'package:abac_challenge/src/bloc/myspaceship/diagnosestepper/diagnosestepper_event.dart';
import 'package:abac_challenge/src/bloc/myspaceship/diagnosestepper/diagnosestepper_state.dart';
import 'package:abac_challenge/src/repository/diagnose_repo.dart';
import 'package:abac_challenge/src/widgets/stepone_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiagnoseStepperView extends StatelessWidget {
  const DiagnoseStepperView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DiagnoseStepperBloc(
        diagnoseRepo: context.read<DiagnoseRepo>(),
        mainCubit: context.read<MainCubit>(),
      ),
      child: BlocBuilder<DiagnoseStepperBloc, DiagnoseStepperState>(
        builder: (context, state) {
          return Stack(children: <Widget>[
            Stepper(
              currentStep: state.currentStepperIndex,
              type: StepperType.horizontal,
              steps: [
                stepOne(),
                stepTwo(),
                stepThree(),
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
    );
  }

  Step stepTwo() {
    return Step(
      title: Center(child: Text('Step 2 title')),
      content: Text('Content for Step 2'),
      isActive: true,
    );
  }

  Step stepThree() {
    return Step(
      title: Text('Step 3 title'),
      content: Text('Content for Step 3'),
      isActive: false,
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
