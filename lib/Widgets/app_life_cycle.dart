import 'package:fitx_flutter_2/Providers/workout_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LifeCycle extends StatefulWidget {
  LifeCycle({required this.child});
  final Widget child;

  @override
  State<LifeCycle> createState() => _LifeCycleState();
}

class _LifeCycleState extends State<LifeCycle> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    final workoutProvider =
        Provider.of<WorkoutProvider>(context, listen: false);
    if (state == AppLifecycleState.inactive) {
      workoutProvider.setHiveExercises();
    }
    print(state);
  }
}
