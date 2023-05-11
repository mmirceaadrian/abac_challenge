class AppointmentCell {
  int appointmentId;
  DateTime date;

  AppointmentCell({
    required this.appointmentId,
    required this.date,
  });

  factory AppointmentCell.fromJson(Map<String, dynamic> json) {
    return AppointmentCell(
      appointmentId: json['appointment_id'],
      date: json['date'],
    );
  }
}
