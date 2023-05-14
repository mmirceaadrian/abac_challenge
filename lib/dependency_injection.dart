import 'package:abac_challenge/src/repository/auth_repo.dart';
import 'package:abac_challenge/src/repository/diagnose_repo.dart';
import 'package:abac_challenge/src/repository/mock/auth_repo_mock.dart';
import 'package:abac_challenge/src/repository/mock/diagnose_repo_mock.dart';
import 'package:abac_challenge/src/repository/mock/spaceships_repo_mock.dart';
import 'package:abac_challenge/src/repository/production/auth_repo_prod.dart';
import 'package:abac_challenge/src/repository/production/diagnose_repo_prod.dart';
import 'package:abac_challenge/src/repository/production/spaceships_repo_prod.dart';
import 'package:abac_challenge/src/repository/spaceships_repo.dart';

enum Flavor { MOCK, PROD }

class Injector {
  static final Injector _singleton = Injector._internal();
  static Flavor _flavor = Flavor.PROD;

  static void configure(Flavor flavor) {
    _flavor = flavor;
  }

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  AuthRepo get authRepo {
    switch (_flavor) {
      case Flavor.MOCK:
        return AuthRepoMock();
      default:
        return AuthRepoProd();
    }
  }

  SpaceshipsRepo get spaceshipsRepo {
    switch (_flavor) {
      case Flavor.MOCK:
        return SpaceshipsRepoMock();
      default:
        return SpaceshipsRepoProd();
    }
  }

  DiagnoseRepo get diagnoseRepo {
    switch (_flavor) {
      case Flavor.MOCK:
        return DiagnoseRepoMock();
      default:
        return DiagnoseRepoProd();
    }
  }
}
