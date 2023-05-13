class AppointmentCell {
  int appointmentId;
  DateTime date;

  AppointmentCell({
    required this.appointmentId,
    required this.date,
  });

  factory AppointmentCell.fromJson(Map<String, dynamic> json) {
    DateTime parsedDate = DateTime.parse(json['date']);
    return AppointmentCell(
      appointmentId: json['appointment_id'],
      date: parsedDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'appointment_id': appointmentId,
      'date': date.toString(),
    };
  }
}
