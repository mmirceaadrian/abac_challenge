import 'package:flutter/material.dart';

class DiagnoseStepperView extends StatelessWidget {
  const DiagnoseStepperView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stepper(
      currentStep: 0,
      onStepContinue: () {},
      onStepCancel: () {},
      steps: const [
        Step(
          title: Text('Step 1 title'),
          content: Text('Content for Step 1'),
          isActive: true,
        ),
        Step(
          title: Text('Step 2 title'),
          content: Text('Content for Step 2'),
          isActive: true,
        ),
      ],
    );
  }
}
