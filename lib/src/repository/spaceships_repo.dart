import 'package:abac_challenge/src/models/spaceship_model.dart';

abstract class SpaceshipsRepo {
  Future<List<Spaceship>> getSpaceships();
}
