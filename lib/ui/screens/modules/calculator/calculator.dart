import 'package:cyclista/ui/screens/sign_in.dart';
import 'package:cyclista/util/state_widget.dart';
import 'package:flutter/material.dart';
import 'package:cyclista/models/state.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:hiking_calories_calculator/calculator/calculation.dart';
import 'package:hiking_calories_calculator/calculator/calories_calculator.dart';
import 'package:hiking_calories_calculator/calculator/speed.dart';
import 'package:hiking_calories_calculator/calculator/terrain_factors.dart';
import 'package:hiking_calories_calculator/calculator/weight.dart';
import 'package:cyclista/ui/widgets/loading.dart';

class CalculatorScreen extends StatefulWidget {
  CalculatorScreenState createState() => CalculatorScreenState();
}

class CalculatorScreenState extends State<CalculatorScreen> {
  StateModel appState;
  bool _loadingVisible = false;
  var calcu = CaloriesCalculator.calculateCalories;

  final caloriesperhour = CaloriesCalculator.calculateCalories;

  final caloriesperhourLabel = Text('Calories per Hour: ');
  final caloriespermileLabel = Text('Calories per Mile: ');

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    appState = StateWidget.of(context).state;

    if (!appState.isLoading &&
        (appState.firebaseUserAuth == null ||
            appState.user == null ||
            appState.settings == null)) {
      return SignInScreen();
    } else {
      if (appState.isLoading) {
        _loadingVisible = true;
      } else {
        _loadingVisible = false;
      }

      Hero(
        tag: 'hero',
        child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 60.0,
            child: ClipOval(
              child: Image.asset(
                'assets/images/default.png',
                fit: BoxFit.cover,
                width: 120.0,
                height: 120.0,
              ),
            )),
      );

      Calculation calculation = CaloriesCalculator.calculateCalories(
          weight: Weight(lbs: 120),
          bagWeight: Weight(lbs: 20),
          speed: Speed(mph: 4),
          terrain: Terrains.WET_CLAY_OR_ICE,
          inclination: 0);
      print("\nCalories per Hour:");
      print(calculation.kcalPerHour.ceil().toString());
      print("\nCalories per Mile:");
      print(calculation.kcalPerMile.ceil().toString());

      return Scaffold(
        appBar: new AppBar(
          title: new Text("Profile"),
        ),
        backgroundColor: Colors.white,
        body: LoadingScreen(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      caloriesperhourLabel,
                      Text(calculation.kcalPerHour.ceil().toString(),
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 12.0),
                      caloriespermileLabel,
                      Text(calculation.kcalPerMile.ceil().toString(),
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 12.0),
                    ],
                  ),
                ),
              ),
            ),
            inAsyncCall: _loadingVisible),
      );
    }
  }
}
