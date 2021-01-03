import 'package:cyclista/ui/screens/sign_in.dart';
import 'package:cyclista/util/state_widget.dart';
import 'package:flutter/material.dart';
import 'package:cyclista/models/state.dart';
import 'package:hiking_calories_calculator/calculator/calculation.dart';
import 'package:hiking_calories_calculator/calculator/calories_calculator.dart';
import 'package:hiking_calories_calculator/calculator/speed.dart';
import 'package:hiking_calories_calculator/calculator/terrain_factors.dart';
import 'package:hiking_calories_calculator/calculator/weight.dart';

class CalculatorScreen extends StatefulWidget {
  CalculatorScreenState createState() => CalculatorScreenState();
}

class CalculatorScreenState extends State<CalculatorScreen> {
  StateModel appState;
  bool _loadingVisible = false;

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
    }
  }
}
