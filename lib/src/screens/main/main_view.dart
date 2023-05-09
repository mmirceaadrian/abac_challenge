import 'package:abac_challenge/src/bloc/main/main_cubit.dart';
import 'package:abac_challenge/src/bloc/main/main_state.dart';
import 'package:abac_challenge/src/navigation/main_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../constants.dart';

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit(),
      child: Scaffold(
          body: MainNavigator(),
          bottomNavigationBar: BlocBuilder<MainCubit, MainState>(
            builder: (context, state) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(3),
                      topRight: Radius.circular(3)),
                ),
                child: Container(
                  color: kSecondaryColor,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: GNav(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    backgroundColor: kSecondaryColor,
                    tabBackgroundColor: Colors.white.withOpacity(0.1),
                    color: Colors.white,
                    activeColor: Colors.white,
                    padding: EdgeInsets.all(16),
                    onTabChange: (index) => _onTap(index, context),
                    gap: 8,
                    tabs: const [
                      GButton(
                        icon: Icons.car_rental,
                        text: "Nave spatiale",
                      ),
                      GButton(
                        icon: Icons.assignment,
                        text: "Programari",
                      )
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }

  void _onTap(int index, BuildContext context) {
    context.read<MainCubit>().showByIndex(index);
  }
}
