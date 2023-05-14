import 'package:abac_challenge/src/models/spaceship_model.dart';
import 'package:abac_challenge/src/repository/spaceships_repo.dart';

class SpaceshipsRepoMock implements SpaceshipsRepo {
  @override
  Future<List<Spaceship>> getSpaceships() {
    return Future.value(spaceships);
  }
}

var spaceships = <Spaceship>[
  Spaceship.fromJson({
    "year": 2018,
    "name": "SEAT",
    "spaceship_id": 4,
    "user_id": 0,
    "image":
        "https://th.bing.com/th/id/OIP.tQ0RNDuNYhgoEb8qFXO4_wHaEK?pid=ImgDet&rs=1",
    "model": "Ibiza"
  }),
  Spaceship.fromJson({
    "year": 2022,
    "name": "OPEL",
    "spaceship_id": 5,
    "user_id": 0,
    "image":
        "https://th.bing.com/th/id/R.cd943c89ea7a477ce1b90cdbcf549869?rik=RY9Wg5IZHlz%2fzw&pid=ImgRaw&r=0",
    "model": "Corsa"
  }),
  Spaceship.fromJson({
    "year": 2023,
    "name": "Space",
    "spaceship_id": 6,
    "user_id": 0,
    "image":
        "https://th.bing.com/th/id/OIP.Z5rXvS2yM_fvgrepE3bP2wHaE8?pid=ImgDet&rs=1",
    "model": "X"
  }),
  Spaceship.fromJson({
    "year": 2021,
    "name": "Space",
    "spaceship_id": 7,
    "user_id": 0,
    "image":
        "https://i.pinimg.com/originals/47/eb/99/47eb9974cdf828ecbb2dd6c1df73cc61.jpg",
    "model": "Infinity"
  }),
];
