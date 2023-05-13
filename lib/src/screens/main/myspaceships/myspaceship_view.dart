import 'package:abac_challenge/constants.dart';
import 'package:abac_challenge/src/bloc/myspaceship/myspaceship_bloc.dart';
import 'package:abac_challenge/src/bloc/myspaceship/myspaceship_event.dart';
import 'package:abac_challenge/src/bloc/myspaceship/myspaceship_state.dart';
import 'package:abac_challenge/src/repository/spaceships_repo.dart';
import 'package:abac_challenge/src/widgets/cards/spaceship_big_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// This is the spaceships view that shows the list of spaceships.
///
/// It is a stateless widget that uses a [BlocProvider] to provide the [MyspaceshipBloc]
///
/// It uses a [BlocBuilder] to build the UI based on the [MyspaceshipState]
class SpaceshipView extends StatelessWidget {
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

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: LayoutBuilder(
                  builder: (BuildContext content, BoxConstraints constraints) {
                int cardPerRow = 1;
                double screenWidth = constraints.maxWidth;

                // adjust the number of cards to display per row based on screen width
                if (screenWidth >= kWidth) {
                  cardPerRow = 2;
                }

                return SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                      (state.spaceships.length / cardPerRow).ceil(),
                      (rowIndex) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: state.spaceships
                            .skip(rowIndex * cardPerRow)
                            .take(cardPerRow)
                            .map((spaceship) {
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: SpaceshipBigCard(
                                spaceship: spaceship,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                );
              }),
            );
          },
        ),
        backgroundColor: kBackgroundColor,
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
