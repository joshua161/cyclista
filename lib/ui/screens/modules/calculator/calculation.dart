import 'package:meta/meta.dart';

import 'calories.dart';
import 'speed.dart';
import 'terrain_factors.dart';
import 'weight.dart';

class Calculation {
  final Weight hikerWeight;
  final Weight packWeight;
  final Speed hikingSpeed;
  final Terrain terrain;
  final int inclination;
  final Calories calories;
  final double kcalPerMile;
  final double kcalPerHour;

  Calculation(
      {@required this.hikerWeight,
      @required this.calories,
      @required this.kcalPerMile,
      @required this.kcalPerHour,
      @required this.packWeight,
      @required this.hikingSpeed,
      @required this.terrain,
      @required this.inclination});

  @override
  String toString() =>
      'Calculation(hikerWeight: $hikerWeight, calories: $calories, packWeight: $packWeight, hikingSpeed: $hikingSpeed, terrain: $terrain, inclination: $inclination, kcal/mile: $kcalPerMile, kcal/hour: $kcalPerHour)';
}
