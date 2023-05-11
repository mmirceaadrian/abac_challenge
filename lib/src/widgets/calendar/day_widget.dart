import 'package:flutter/material.dart';

class DayWidget extends StatefulWidget {
  final DateTime dateTime;

  const DayWidget({Key? key, required this.dateTime}) : super(key: key);

  @override
  DayWidgetState createState() => DayWidgetState();
}

class DayWidgetState extends State<DayWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(_getDayName(widget.dateTime.weekday)),
        Text(widget.dateTime.day.toString()),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _getAppointments(widget.dateTime),
        ),
      ],
    );
  }

  List<Widget> _getAppointments(DateTime day) {
    List<Widget> appointments = [];

    const startHour = 8;
    for (var i = 0; i < 9; i++) {
      appointments.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextButton(
          onPressed: () {},
          child: Text('${startHour + i}:00'),
        ),
      ));
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
