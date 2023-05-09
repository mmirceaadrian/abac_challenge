import 'package:abac_challenge/src/bloc/myspaceship/diagnosestepper/diagnosestepper_bloc.dart';
import 'package:abac_challenge/src/repository/diagnose_repo.dart';
import 'package:abac_challenge/src/widgets/stepOne_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiagnoseStepperView extends StatelessWidget {
  const DiagnoseStepperView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DiagnoseStepperBloc(
        diagnoseRepo: context.read<DiagnoseRepo>(),
      ),
      child: Stepper(
        currentStep: 0,
        onStepContinue: () {},
        onStepCancel: () {},
        type: StepperType.horizontal,
        steps: [
          stepOne(),
          stepTwo(),
        ],
      ),
    );
  }

  Step stepTwo() {
    return Step(
      title: Text('Step 2 title'),
      content: Text('Content for Step 2'),
      isActive: true,
    );
  }
}
