import 'package:abac_challenge/src/models/spaceship_model.dart';
import 'package:abac_challenge/src/widgets/cards/mini_card.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

Step buildStepThree(Spaceship? spaceship, DateTime? date) {
  String formattedDate = '';
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
        _gap(),
        SpaceshipMiniCard(
          title: '${spaceship!.name} ${spaceship.model}',
          subtitle: spaceship.year.toString(),
          image: spaceship.image,
        ),
        _gap(),
        Text(
          'Ofertanti',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black.withOpacity(0.6),
          ),
        ),
      ],
    ),
    isActive: true,
  );
}

SizedBox _gap() {
  return SizedBox(
    height: 16,
  );
}
