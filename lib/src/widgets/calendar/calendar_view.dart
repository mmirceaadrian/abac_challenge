import 'package:abac_challenge/src/widgets/calendar/day_widget.dart';
import 'package:flutter/material.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

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
      child: Column(children: [
        // 1 row with the next, previeus buttons and curent month
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  icon: const Icon(Icons.arrow_back),
                  tooltip: 'Previous week',
                  onPressed: () => _previousWeek()),
              // curent month in letters
              Text(_getMonthName(), style: TextStyle(fontSize: 20)),
              IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  tooltip: 'Next week',
                  onPressed: () => _nextWeek()),
            ],
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
    });
  }

  void _previousWeek() {
    // if first day is curent day do nothing
    if (firstDay == curentDay) return;

    setState(() {
      firstDay = firstDay.subtract(Duration(days: dayCount));
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
    List<Widget> week = [];
    for (var i = 0; i < dayCount; i++) {
      week.add(_getDay(firstDay.add(Duration(days: i))));
    }
    return week;
  }

  // return a collum for each day of the week
  Widget _getDay(DateTime day) {
    return DayWidget(dateTime: day);
  }
}