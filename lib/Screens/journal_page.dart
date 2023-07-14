import 'package:fitx_flutter_2/Providers/auth.dart';
import 'package:fitx_flutter_2/Providers/firebase_db.dart';
import 'package:fitx_flutter_2/Providers/hive_db.dart';
import 'package:fitx_flutter_2/Providers/user_provider.dart';
import 'package:fitx_flutter_2/Providers/workout_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:fitx_flutter_2/Models/exercise.dart';
import 'package:fitx_flutter_2/Widgets/timer_card.dart';

import 'package:fitx_flutter_2/Widgets/main_list_card.dart';
import 'package:fitx_flutter_2/constants.dart';

class JournalPage extends StatefulWidget {
  @override
  State<JournalPage> createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  // SliverToBoxAdapter converts regular widget to a sliver adaptable widget.
  Widget titleText() => SliverToBoxAdapter(
        child: SizedBox(
          height: 70.0,
          child: Center(
            child: Text(
              "YOUR JOURNAL",
              style: TextStyle(
                color: kYellow,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'big_noodle_titling',
              ),
            ),
          ),
        ),
      );

  Widget listViewCard() => SliverToBoxAdapter(
        child: MainListCard(),
      );

  Widget timerCard() => TimerCard();

  Widget sizedBox({double height = 0.0, double width = 0.0}) =>
      SliverToBoxAdapter(
        child: SizedBox(
          height: height,
          width: width,
        ),
      );

  @override
  void initState() {
    // context.read<WorkoutProvider>().getHiveExercises();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer4<WorkoutProvider, AuthProvider, FirebaseHandler,
        UserProvider>(
      builder: (context, workoutProvider, auth, db, user, child) {
        return Scaffold(
          body: SafeArea(
            //This safe area is to avoid anything in the column widget to interfere with the ui.
            child: CustomScrollView(
              shrinkWrap: true,
              primary: false,
              slivers: [
                SliverAppBar(
                    title: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        "Your journal",
                        style: TextStyle(
                            color: kYellow,
                            fontSize: 30.0,
                            fontFamily: 'big_noodle_titling',
                            shadows: [kBoxShadow]),
                      ),
                    ),
                    titleSpacing: 0.0,
                    surfaceTintColor: kYellow,
                    leadingWidth: 109.0,
                    backgroundColor: kMoove,
                    shadowColor: kYellow,
                    floating: true,
                    pinned: true,
                    actions: [
                      TextButton(
                          onPressed: () {
                            final box = HiveDb();
                            db.saveExercises(
                              context,
                              workoutProvider.getExercises,
                              user.getEmail,
                            );

                            //   box.setValue(
                            //       'Exercies', workoutProvider.getExercises);
                          },
                          child: Icon(
                            Icons.save_alt_outlined,
                            color: kYellow,
                          )),
                      TextButton(
                          onPressed: () => auth.logOut(),
                          child: Icon(
                            Icons.logout_outlined,
                            color: kYellow,
                          )),
                    ]),

                sizedBox(height: 10.0),

                timerCard(),

                sizedBox(height: 20.0),
                //Background card.

                listViewCard(),
              ],
            ),
          ),
          backgroundColor: kMoove,
          //This changes the location of the FAB.
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterTop,
          floatingActionButton: FloatingActionButton(
            mini: true,
            child: Icon(
              Icons.add_outlined,
              color: kMoove,
            ),
            backgroundColor: kYellow,
            onPressed: () {
              workoutProvider.addExercise(Exercise());
            },
          ),
        );
      },
    );
  }
}
