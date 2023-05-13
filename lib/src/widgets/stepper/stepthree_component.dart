import 'package:abac_challenge/src/bloc/myspaceship/diagnosestepper/diagnosestepper_bloc.dart';
import 'package:abac_challenge/src/bloc/myspaceship/diagnosestepper/diagnosestepper_event.dart';
import 'package:abac_challenge/src/models/spaceship_model.dart';
import 'package:abac_challenge/src/widgets/cards/mini_card.dart';
import 'package:abac_challenge/src/widgets/checkbox/checkbox_widget.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Step buildStepThree(Spaceship? spaceship, BuildContext context) {
  String formattedDate = '';
  DateTime? date = context.read<DiagnoseStepperBloc>().state.selectedDate;
  if (date != null) {
    formattedDate =
        formatDate(date, [dd, '.', mm, '.', yyyy, ' ', HH, ':', nn]);
  } else {
    formattedDate =
        formatDate(DateTime.now(), [dd, '.', mm, '.', yyyy, ' ', HH, ':', nn]);
  }
  return Step(
    label: Text('Confirma'),
    title: const Text(''),
    content: Column(
      children: [
        Text(
          'Programare pentru: ',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          formattedDate,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black.withOpacity(0.6)),
        ),
        _gap(16),
        SpaceshipMiniCard(
          title: '${spaceship!.name} ${spaceship.model}',
          subtitle: spaceship.year.toString(),
          image: spaceship.image,
        ),
        _gap(16),
        Text(
          'Ofertanti',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black.withOpacity(0.6),
          ),
        ),
        Container(
          constraints: BoxConstraints(maxWidth: 300),
          child: TextFormField(
            decoration: InputDecoration(
              //labelText: 'Cauta ofertant',
              suffixIcon: Icon(Icons.search),
              hintText: "Cauta ofertant",
              hintStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.4),
              ),
            ),
            onChanged: (value) {
              print(value);
            },
          ),
        ),
        _gap(8),
        // center the row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'sortare dupa:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.4),
              ),
            ),
            CheckBoxWidget(
              onChanged: (value) {
                context
                    .read<DiagnoseStepperBloc>()
                    .add(DiagnoseStepperSortByRating(value: value!));
              },
              title: 'rating',
              value: context.read<DiagnoseStepperBloc>().state.sortByRating,
            ),
            CheckBoxWidget(
              onChanged: (value) {
                context
                    .read<DiagnoseStepperBloc>()
                    .add(DiagnoseStepperSortByPrice(value: value!));
              },
              title: 'pret',
              value: context.read<DiagnoseStepperBloc>().state.sortByPrice,
            ),
            CheckBoxWidget(
              onChanged: (value) {
                context
                    .read<DiagnoseStepperBloc>()
                    .add(DiagnoseStepperSortByTime(value: value!));
              },
              title: 'time',
              value: context.read<DiagnoseStepperBloc>().state.sortByTime,
            )
          ],
        ),
        _gap(8),
      ],
    ),
    isActive:
        context.read<DiagnoseStepperBloc>().state.currentStepperIndex >= 2,
    state: context.read<DiagnoseStepperBloc>().state.currentStepperIndex == 2
        ? StepState.editing
        : StepState.disabled,
  );
}

SizedBox _gap(double height) {
  return SizedBox(
    height: height,
  );
}
