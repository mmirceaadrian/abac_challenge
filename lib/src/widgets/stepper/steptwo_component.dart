import 'package:abac_challenge/src/bloc/myspaceship/diagnosestepper/diagnosestepper_bloc.dart';
import 'package:abac_challenge/src/bloc/myspaceship/diagnosestepper/diagnosestepper_event.dart';
import 'package:abac_challenge/src/bloc/myspaceship/diagnosestepper/diagnosestepper_state.dart';
import 'package:abac_challenge/src/widgets/calendar/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            CalendarView(
              startHour: 8,
              endHour: 16,
              appointmentCells: state.appointmentCells,
              onWeekChange: (DateTime startDate, DateTime endDate) => {
                context.read<DiagnoseStepperBloc>().add(
                      DiagnoseStepperGetAppointmentCells(
                        startDate: startDate,
                        endDate: endDate,
                      ),
                    ),
              },
              onSelectDate: (DateTime date) => {
                context.read<DiagnoseStepperBloc>().add(
                      DiagnoseStepperSelectDate(
                        date: date,
                      ),
                    ),
              },
              selectedDate: state.selectedDate,
            ),
            SizedBox(height: 32),
          ],
        );
      },
    ),
  );
}
