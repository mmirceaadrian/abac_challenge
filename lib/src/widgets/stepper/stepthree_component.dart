import 'package:abac_challenge/src/bloc/myspaceship/diagnosestepper/diagnosestepper_bloc.dart';
import 'package:abac_challenge/src/bloc/myspaceship/diagnosestepper/diagnosestepper_event.dart';
import 'package:abac_challenge/src/models/spaceship_model.dart';
import 'package:abac_challenge/src/widgets/cards/medium_card.dart';
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
              context
                  .read<DiagnoseStepperBloc>()
                  .add(DiagnoseStepperSearchService(query: value));
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
                context
                    .read<DiagnoseStepperBloc>()
                    .add(DiagnoseStepperFilter());
              },
              title: 'rating',
              value: context.read<DiagnoseStepperBloc>().state.sortByRating,
            ),
            CheckBoxWidget(
              onChanged: (value) {
                context
                    .read<DiagnoseStepperBloc>()
                    .add(DiagnoseStepperSortByPrice(value: value!));
                context
                    .read<DiagnoseStepperBloc>()
                    .add(DiagnoseStepperFilter());
              },
              title: 'pret',
              value: context.read<DiagnoseStepperBloc>().state.sortByPrice,
            ),
            CheckBoxWidget(
              onChanged: (value) {
                context
                    .read<DiagnoseStepperBloc>()
                    .add(DiagnoseStepperSortByTime(value: value!));
                context
                    .read<DiagnoseStepperBloc>()
                    .add(DiagnoseStepperFilter());
              },
              title: 'time',
              value: context.read<DiagnoseStepperBloc>().state.sortByTime,
            )
          ],
        ),
        _gap(8),
        Padding(
          padding: const EdgeInsets.only(bottom: 32),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              int cardPerRow = 1;
              double screenWidth = constraints.maxWidth;

              // adjust the number of cards to display per row based on screen width
              if (screenWidth >= 1000) {
                cardPerRow = 3;
              } else if (screenWidth >= 800) {
                cardPerRow = 2;
              }

              return SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    (context
                                .read<DiagnoseStepperBloc>()
                                .state
                                .sortedServices
                                .length /
                            cardPerRow)
                        .ceil(), // calculate number of rows needed
                    (rowIndex) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: context
                            .read<DiagnoseStepperBloc>()
                            .state
                            .sortedServices
                            .skip(rowIndex *
                                cardPerRow) // skip cards that are already displayed in previous rows
                            .take(
                                cardPerRow) // display the next batch of cards in a row
                            .map((service) => Expanded(
                                  child: MediumCard(
                                    title: service.name,
                                    subtitle:
                                        '${service.location} - ${service.distance.round()} km',
                                    image: service.image,
                                    bottomText:
                                        'Cost estimate ${service.cost.toString()} RON',
                                    rating:
                                        '${service.rating.toString()} (${service.reviews.toString()})',
                                    onTap: () {
                                      context.read<DiagnoseStepperBloc>().add(
                                            DiagnoseStepperSelectService(
                                                service: service),
                                          );
                                    },
                                    isSelected: context
                                            .read<DiagnoseStepperBloc>()
                                            .state
                                            .selectedService
                                            ?.serviceId ==
                                        service.serviceId,
                                  ),
                                ))
                            .toList(),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        )
      ],
    ),
    isActive:
        context.read<DiagnoseStepperBloc>().state.currentStepperIndex >= 2,
    state: context.read<DiagnoseStepperBloc>().state.currentStepperIndex == 2
        ? StepState.editing
        : StepState.disabled,
  );
}

double _buildAspectRatio(BuildContext context) {
  // function depends on the screen size for grid view
  if (MediaQuery.of(context).size.width > 1800) {
    return 1.5;
  } else if (MediaQuery.of(context).size.width > 1500) {
    return 1.3;
  } else if (MediaQuery.of(context).size.width > 1200) {
    return 1.2;
  } else {
    return 1.1;
  }
}

SizedBox _gap(double height) {
  return SizedBox(
    height: height,
  );
}
