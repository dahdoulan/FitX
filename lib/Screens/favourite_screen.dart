import 'package:fitx_flutter_2/Models/favorites.dart';

import 'package:fitx_flutter_2/Providers/workout_provider.dart';
import 'package:fitx_flutter_2/Widgets/custom_text_field.dart';
import 'package:fitx_flutter_2/Widgets/custom_tiles.dart';
import 'package:fitx_flutter_2/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:provider/provider.dart';

class FavouriteScreen extends StatefulWidget {
  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    context.read<WorkoutProvider>().getFavourites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutProvider>(
      builder: (context, workoutProvider, child) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                shape: kRoundedRectangle,
                context: context,
                builder: (context) {
                  return Container(
                    //height: 300.0,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20.0),
                        Text(
                          'New favorite folder.',
                          style: kInputTextStyle,
                        ),
                        SizedBox(height: 20.0),
                        CustomTextField(
                          label: 'Name',
                          controller: _controller,
                        ),
                        SizedBox(height: 20.0),
                        TextButton(
                          onPressed: () {
                            workoutProvider.setHiveFavourites(_controller.text,
                                Favorite(name: _controller.text));

                            Navigator.pop(context);
                          },
                          child: Text(
                            'Save',
                            style: kInputTextStyle,
                          ),
                        ),
                      ],
                    ),
                    decoration: kModalSheetDecoration,
                  );
                },
              );
            },
            backgroundColor: kYellow,
            child: Icon(
              Icons.add,
              color: kMoove,
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
              color: kMoove,
            ),
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  Text(
                    'Favorites',
                    style: TextStyle(
                      color: kYellow,
                      fontFamily: 'big_noodle_titling',
                      fontSize: 30.0,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                      itemCount: workoutProvider.getFavoriteLength,
                      itemBuilder: ((context, supIndex) {
                        return Slidable(
                          startActionPane: ActionPane(
                            motion: ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  workoutProvider.deleteFavouriteFolder(
                                      workoutProvider
                                          .getFavoriteName(supIndex));
                                },
                                icon: Icons.delete,
                                backgroundColor: kMoove,
                                foregroundColor: kYellow,
                              ),
                              SlidableAction(
                                onPressed: (context) {
                                  final fav =
                                      workoutProvider.getFavoriteAt(supIndex);

                                  showModalBottomSheet(
                                    shape: kRoundedRectangle,
                                    backgroundColor: kMoove,
                                    context: context,
                                    builder: (context) => ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      padding: EdgeInsets.only(
                                          top: 20.0, bottom: 10.0),
                                      itemCount: fav.getLength,
                                      itemBuilder: (context, subIndex) =>
                                          CustomListTiles(
                                        leading:
                                            fav.getExerciseAt(subIndex).getName,
                                        trailing: TextButton(
                                          onPressed: () {
                                            fav.deleteExercise(
                                                fav.getExerciseAt(subIndex));
                                            Navigator.pop(context);
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color: kMoove,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                icon: Icons.edit,
                                backgroundColor: kMoove,
                                foregroundColor: kYellow,
                              )
                            ],
                          ),
                          child: CustomListTiles(
                            leading:
                                '${workoutProvider.getFavoriteName(supIndex)}',
                            trailing: TextButton(
                              onPressed: () => context
                                  .read<WorkoutProvider>()
                                  .getHiveFavourites(workoutProvider
                                      .getFavoriteAt(supIndex)
                                      .getName),
                              child: Icon(
                                Icons.add,
                                color: kMoove,
                              ),
                            ),
                            fav: workoutProvider.getFavoriteAt(supIndex),
                          ),
                        );
                      }),
                    ),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          //Gives the background of the card a shadow effect.
                          color: kBlack,
                          blurRadius: 5.0,
                          spreadRadius: 2.0,
                        )
                      ],
                      color: kMoove,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
