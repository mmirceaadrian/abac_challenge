class AppointmentCell {
  int appointmentId;
  DateTime date;
  String time;
  bool isFree;

  AppointmentCell({
    required this.appointmentId,
    required this.date,
    required this.time,
    required this.isFree,
  });

  factory AppointmentCell.fromJson(Map<String, dynamic> json) {
    return AppointmentCell(
      appointmentId: json['appointment_id'],
      date: json['date'],
      time: json['time'],
      isFree: json['is_free'],
    );
  }
}
