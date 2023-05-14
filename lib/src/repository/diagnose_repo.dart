import 'package:abac_challenge/src/models/appointmentcell_model.dart';
import 'package:abac_challenge/src/models/service_model.dart';
import 'package:abac_challenge/src/models/spaceship_component_model.dart';

abstract class DiagnoseRepo {
  Future<List<SpaceshipComponent>> searchComponent(String searchString);
  Future<List<AppointmentCell>> getAppointmentCells(
      DateTime startDate, DateTime endDate);
  Future<String> addAppointment(AppointmentCell appointmentCell);
  Future<List<ServiceModel>> getServices(String searchString);
}
