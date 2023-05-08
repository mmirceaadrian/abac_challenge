import 'package:abac_challenge/src/bloc/myspaceship/myspaceship_bloc.dart';
import 'package:abac_challenge/src/bloc/myspaceship/myspaceship_event.dart';
import 'package:abac_challenge/src/bloc/myspaceship/myspaceship_state.dart';
import 'package:abac_challenge/src/repository/spaceships_repo.dart';
import 'package:abac_challenge/src/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_card/image_card.dart';

class SpaceshipView extends StatelessWidget {
  const SpaceshipView({Key? key}) : super(key: key);

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
            return MediaQuery.of(context).size.width > 1600
                ? GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 2 / 1,
                    ),
                    itemCount: state.spaceships.length,
                    itemBuilder: (context, index) {
                      var spaceship = state.spaceships[index];
                      return buildCard("${spaceship.name}-${spaceship.model}",
                          "${spaceship.year}", spaceship.image);
                    },
                  )
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: state.spaceships.length,
                    itemBuilder: (context, index) {
                      var spaceship = state.spaceships[index];
                      return buildCard("${spaceship.name}-${spaceship.model}",
                          "${spaceship.year}", spaceship.image);
                    },
                  );
          },
        ),
      ),
    );
  }
}
