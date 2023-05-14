import 'package:abac_challenge/constants.dart';
import 'package:abac_challenge/src/models/appointmentcell_model.dart';
import 'package:flutter/material.dart';

/// Widget for displaying a day in the calendar
///
/// This widget is used to display a day in the calendar
class DayWidget extends StatefulWidget {
  final DateTime dateTime;
  final int maxHours;
  final int startHour;
  final List<AppointmentCell> appointmentCells;
  final Function(DateTime) onSelectDate;
  final DateTime? selectedDate;

  const DayWidget({
    Key? key,
    required this.dateTime,
    required this.startHour,
    required this.maxHours,
    required this.appointmentCells,
    required this.onSelectDate,
    this.selectedDate,
  }) : super(key: key);

  @override
  DayWidgetState createState() => DayWidgetState();
}

class DayWidgetState extends State<DayWidget> {
  @override
  Widget build(BuildContext context) {
    bool currentDay = (widget.dateTime.day == DateTime.now().day) &&
        (widget.dateTime.month == DateTime.now().month) &&
        (widget.dateTime.year == DateTime.now().year);
    return Container(
      decoration: currentDay
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: kPrimaryLightColor.withOpacity(0.1),
            )
          : null,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Text(_getDayName(widget.dateTime.weekday),
                style: TextStyle(fontSize: 16)),
            Text(widget.dateTime.day.toString(),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _getAppointments(widget.dateTime),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _getAppointments(DateTime day) {
    List<Widget> appointments = [];
    var startHour = DateTime(day.year, day.month, day.day, widget.startHour);
    for (var i = 0; i <= widget.maxHours; i++) {
      bool isTaken = widget.appointmentCells
              .where((element) =>
                  element.date.year == day.year &&
                  element.date.month == day.month &&
                  element.date.day == day.day &&
                  element.date.hour == startHour.add(Duration(hours: i)).hour)
              .isNotEmpty ||
          startHour.add(Duration(hours: i)).isBefore(DateTime.now());

      bool isSelected = widget.selectedDate != null &&
          widget.selectedDate?.compareTo(startHour.add(Duration(hours: i))) ==
              0;

      appointments.add(
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          width: isSelected ? 65 : 60,
          height: 35,
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: isTaken
                  ? Colors.black12
                  : isSelected
                      ? Colors.green.shade300
                      : Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
            ),
            onPressed: isTaken
                ? null
                : () {
                    widget.onSelectDate(startHour.add(Duration(hours: i)));
                  },
            child: Text('${startHour.add(Duration(hours: i)).hour}:00',
                style: TextStyle(
                  fontSize: 16,
                  color: isTaken ? Colors.black26 : Colors.black,
                )),
          ),
        ),
      );
    }

    return appointments;
  }

  String _getDayName(int day) {
    bool isSmallScreen = MediaQuery.of(context).size.width < 600;
    switch (day) {
      case 1:
        return isSmallScreen ? 'Lun' : 'Luni';
      case 2:
        return isSmallScreen ? 'Mar' : 'Marti';
      case 3:
        return isSmallScreen ? 'Mie' : 'Miercuri';
      case 4:
        return isSmallScreen ? 'Joi' : 'Joi';
      case 5:
        return isSmallScreen ? 'Vin' : 'Vineri';
      case 6:
        return isSmallScreen ? 'Sam' : 'Sambata';
      case 7:
        return isSmallScreen ? 'Dum' : 'Duminica';
      default:
        return 'Error';
    }
  }
}
