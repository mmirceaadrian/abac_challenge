import 'package:abac_challenge/constants.dart';
import 'package:abac_challenge/src/bloc/myspaceship/myspaceship_bloc.dart';
import 'package:abac_challenge/src/bloc/myspaceship/myspaceship_event.dart';
import 'package:abac_challenge/src/bloc/myspaceship/myspaceship_state.dart';
import 'package:abac_challenge/src/repository/spaceships_repo.dart';
import 'package:abac_challenge/src/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// This is the spaceships view that shows the list of spaceships.
///
/// It is a stateless widget that uses a [BlocProvider] to provide the [MyspaceshipBloc]
///
/// It uses a [BlocBuilder] to build the UI based on the [MyspaceshipState]
class SpaceshipView extends StatelessWidget {
  /// Constructor for the [SpaceshipView]
  const SpaceshipView({Key? key}) : super(key: key);

  /// This method builds the UI based on the [MyspaceshipState]
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyspaceshipBloc(
        spaceshipsRepo: context.read<SpaceshipsRepo>(),
      )..add(MyspaceshipEventLoading()),
      child: Scaffold(
        body: BlocBuilder<MyspaceshipBloc, MyspaceshipState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return MediaQuery.of(context).size.width > kWidth
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio:
                            aspectRatio(MediaQuery.of(context).size.width),
                      ),
                      itemCount: state.spaceships.length,
                      itemBuilder: (context, index) {
                        var spaceship = state.spaceships[index];
                        return buildCard("${spaceship.name}-${spaceship.model}",
                            "${spaceship.year}", spaceship.image);
                      },
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: state.spaceships.length,
                      itemBuilder: (context, index) {
                        var spaceship = state.spaceships[index];
                        return buildCard("${spaceship.name}-${spaceship.model}",
                            "${spaceship.year}", spaceship.image);
                      },
                    ),
                  );
          },
        ),
        backgroundColor: bgColor,
      ),
    );
  }

  /// This method is used to calculate the aspect ratio of the card
  /// based on the width of the screen
  ///
  /// [width] is the width of the screen
  double aspectRatio(double width) {
    double output = 2 / ((1900 - width) ~/ 200 * 0.15 + 0.87);
    return (width > kWidth) ? output : 1.5;
  }
}
