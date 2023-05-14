import 'package:abac_challenge/src/models/appointmentcell_model.dart';
import 'package:abac_challenge/src/widgets/calendar/day_widget.dart';
import 'package:flutter/material.dart';

/// Widget for the calendar view
///
/// This widget is used to display a calendar
class CalendarView extends StatefulWidget {
  final int startHour;
  final int endHour;
  final List<AppointmentCell> appointmentCells;
  final Function(DateTime, DateTime) onWeekChange;
  final Function(DateTime) onSelectDate;
  final DateTime? selectedDate;

  const CalendarView({
    super.key,
    required this.startHour,
    required this.endHour,
    required this.appointmentCells,
    required this.onWeekChange,
    required this.onSelectDate,
    this.selectedDate,
  });

  @override
  CalendarViewState createState() => CalendarViewState();
}

class CalendarViewState extends State<CalendarView> {
  final curentDay = DateTime.now();
  var firstDay = DateTime.now();
  var dayCount = 7;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
      child: Column(children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white70,
            border: Border.all(color: Colors.grey, width: 2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    splashRadius: 20,
                    icon: const Icon(Icons.arrow_back),
                    tooltip: 'Previous week',
                    onPressed: () => _previousWeek()),
                // curent month in letters
                Text(_getMonthName(),
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(
                    splashRadius: 20,
                    icon: const Icon(Icons.arrow_forward),
                    tooltip: 'Next week',
                    onPressed: () => _nextWeek()),
              ],
            ),
          ),
        ),

        // 1 row with the days of the week, first day is curent day
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _getWeek(firstDay),
          ),
        ),
      ]),
    );
  }

  void _nextWeek() {
    setState(() {
      firstDay = firstDay.add(Duration(days: dayCount));
      widget.onWeekChange(firstDay, firstDay.add(Duration(days: dayCount)));
    });
  }

  void _previousWeek() {
    // if first day is curent day do nothing
    if (firstDay == curentDay) return;

    setState(() {
      firstDay = firstDay.subtract(Duration(days: dayCount));
      widget.onWeekChange(firstDay, firstDay.add(Duration(days: dayCount)));
    });
  }

  String _getMonthName() {
    if (firstDay.day + dayCount >
        DateTime(firstDay.year, firstDay.month + 1, 0).day + 1) {
      if (firstDay.month == 12) {
        return '${_getMonthNameByNumer(firstDay.month)} ${firstDay.year}  - ${_getMonthNameByNumer(1)} ${firstDay.year + 1}';
      }
      return '${_getMonthNameByNumer(firstDay.month)} - ${_getMonthNameByNumer(firstDay.month + 1)} ${firstDay.year}';
    }
    return '${_getMonthNameByNumer(firstDay.month)} ${firstDay.year}';
  }

  String _getMonthNameByNumer(int month) {
    switch (month) {
      case 1:
        return 'Ianuarie';
      case 2:
        return 'Februarie';
      case 3:
        return 'Martie';
      case 4:
        return 'Aprilie';
      case 5:
        return 'Mai';
      case 6:
        return 'Iunie';
      case 7:
        return 'Iulie';
      case 8:
        return 'August';
      case 9:
        return 'Septembrie';
      case 10:
        return 'Octombrie';
      case 11:
        return 'Noiembrie';
      case 12:
        return 'Decembrie';
      default:
        return 'Error';
    }
  }

  // return a collum for each day of the week
  List<Widget> _getWeek(DateTime firstDay) {
    if (MediaQuery.of(context).size.width < 600) {
      setState(() {
        dayCount = 5;
      });
    } else {
      setState(() {
        dayCount = 7;
      });
    }

    List<Widget> week = [];
    for (var i = 0; i < dayCount; i++) {
      week.add(_getDay(firstDay.add(Duration(days: i))));
    }
    return week;
  }

  // return a collum for each day of the week
  Widget _getDay(DateTime day) {
    return DayWidget(
      dateTime: day,
      startHour: widget.startHour,
      maxHours: widget.endHour - widget.startHour,
      appointmentCells: widget.appointmentCells,
      onSelectDate: widget.onSelectDate,
      selectedDate: widget.selectedDate,
    );
  }
}
