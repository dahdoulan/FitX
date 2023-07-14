import 'package:fitx_flutter_2/Models/exercise.dart';
import 'package:fitx_flutter_2/Models/favorites.dart';
import 'package:fitx_flutter_2/Models/round.dart';
import 'package:fitx_flutter_2/Providers/hive_db.dart';
import 'package:fitx_flutter_2/Providers/user_provider.dart';
import 'package:fitx_flutter_2/Providers/workout_provider.dart';
import 'package:fitx_flutter_2/Providers/exercise_names.dart';
import 'package:fitx_flutter_2/Screens/auth_screen.dart';
import 'package:fitx_flutter_2/Utils/Util.dart';
import 'package:fitx_flutter_2/Widgets/app_life_cycle.dart';
import 'package:fitx_flutter_2/Widgets/input_widget.dart';
import 'package:fitx_flutter_2/constants.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Providers/auth.dart';
import 'Providers/chart_provider.dart';
import 'Providers/firebase_db.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();
  Hive.registerAdapter(ExerciseAdapter());
  Hive.registerAdapter(RoundAdapter());
  Hive.registerAdapter(InputWidgetAdapter());
  Hive.registerAdapter(FavoriteAdapter());
  await Hive.openBox(kPrefKey);
  await Hive.openBox(kFavouritesPrefKey);

  runApp(
    MultiProvider(
      //Providers for passing data through the widget tree.
      providers: [
        ChangeNotifierProvider(
          create: (_) => WorkoutProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ExerciseNames(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => FirebaseHandler(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChartProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => HiveDb(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    super.dispose();
    Hive.close();
  }

  @override
  Widget build(BuildContext context) {
    return LifeCycle(
      child: MaterialApp(
        scaffoldMessengerKey: Util.messangerKey,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AuthScreen(),
      ),
    );
  }
}
