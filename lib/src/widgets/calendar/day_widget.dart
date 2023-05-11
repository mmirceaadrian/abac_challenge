import 'package:flutter/material.dart';

class DayWidget extends StatefulWidget {
  final DateTime dateTime;
  final int maxHours;
  final int startHour;

  const DayWidget(
      {Key? key,
      required this.dateTime,
      required this.startHour,
      required this.maxHours})
      : super(key: key);

  @override
  DayWidgetState createState() => DayWidgetState();
}

class DayWidgetState extends State<DayWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }

  List<Widget> _getAppointments(DateTime day) {
    List<Widget> appointments = [];

    var startHour = DateTime(2021, 1, 1, widget.startHour);
    for (var i = 0; i <= widget.maxHours; i++) {
      appointments.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
          ),
          onPressed: () {},
          child: Text('${startHour.hour}:00',
              style: TextStyle(fontSize: 16, color: Colors.black)),
        ),
      ));
      startHour = startHour.add(Duration(hours: 1));
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
