import 'package:firebase_auth/firebase_auth.dart';

import 'package:fitx_flutter_2/Providers/user_provider.dart';
import 'package:fitx_flutter_2/Providers/workout_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../constants.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    // Gets called after initstate fires...
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<UserProvider>(context, listen: false)
          .setEmail(FirebaseAuth.instance.currentUser!.email);
      Provider.of<WorkoutProvider>(context, listen: false).getHiveExercises();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutProvider>(
      builder: (context, workoutProvider, child) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                backgroundColor: kYellow,
                icon: Icon(
                  Icons.home_outlined,
                  color: kYellow,
                ),
                label: 'Home',
                activeIcon: Icon(
                  Icons.home_filled,
                  color: kYellow,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.library_books_outlined,
                  color: kYellow,
                ),
                label: 'Logs',
                activeIcon: Icon(
                  Icons.library_books_rounded,
                  color: kYellow,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite_border_outlined,
                  color: kYellow,
                ),
                label: 'Favorites',
                activeIcon: Icon(
                  Icons.favorite,
                  color: kYellow,
                ),
              ),
            ],
            backgroundColor: kMoove,
            fixedColor: kYellow,
            currentIndex: workoutProvider.screenIndex,
            onTap: (index) => workoutProvider.toggleScreenIndex(index),
          ),
          body: workoutProvider.screens[workoutProvider.screenIndex],
        );
      },
    );
  }
}
