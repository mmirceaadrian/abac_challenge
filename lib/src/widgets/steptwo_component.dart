import 'dart:html';

import 'package:abac_challenge/src/bloc/myspaceship/diagnosestepper/diagnosestepper_bloc.dart';
import 'package:abac_challenge/src/bloc/myspaceship/diagnosestepper/diagnosestepper_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

Step buildStepTwo() {
  return Step(
    label: Center(
      child: Text('Stabileste ora'),
    ),
    title: const Text(''),
    isActive: true,
    content: BlocBuilder<DiagnoseStepperBloc, DiagnoseStepperState>(
      builder: (context, state) {
        return Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: DateTime.now(),
              calendarFormat: CalendarFormat.week,
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              calendarStyle: CalendarStyle(
                weekendTextStyle: TextStyle(color: Colors.red),
              ),
              onDaySelected: (selectedDay, focusedDay) {},
              eventLoader: (day) => [],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text('8:00'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('8:00'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('8:00'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('8:00'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('8:00'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('8:00'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('8:00'),
                ),
              ],
            ),
          ],
        );
      },
    ),
  );
}
