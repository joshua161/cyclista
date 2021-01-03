import 'dart:math';

import 'package:meta/meta.dart';

import 'calculation.dart';
import 'calories.dart';
import 'speed.dart';
import 'terrain_factors.dart';
import 'weight.dart';

/// A Calories calculator that can be used to calculate amount of burnt
/// calories by Rucking.
/// The formula is based on Pandolf Equation which gives metabolic rate of the
/// hiking event. Metabolic Rate indicates how quickly the energy is burned.
///
/// The formula used to calculate metabolic rate is as following:
///
/// ----------------------------------------------------------------------------
/// Formula: M = 1.5 W + 2.0 (W + L)(L/W)² + n(W + L)(1.5V² + 0.35VG)
/// ----------------------------------------------------------------------------
///
/// Where,  M = Metabolic Rate                    [Unit: Watts]
///         W = Weight of the person              [Unit: KG]
///         L = Weight of the bag pack            [Unit: KG]
///         V = Hiking speed of the person        [Unit: Metre/second => m/s]
///         G = The Grade of inclination          [Unit: %]
///         N = Terrain Factor
///
/// Here, terrain factor(N) is the equation constant that depends of the type of
/// the terrain on which the hiking activity is performed. It varies terrain to
/// terrain. Here's the available terrain factor list used for this equation
///
/// [Terrains.PAVED_ROAD]           => 1.0
/// [Terrains.GRAVEL_ROAD]          => 1.2
/// [Terrains.WET_CLAY_OR_ICE]      => 1.7
/// [Terrains.SAND]                 => 2.0
/// [Terrains.SWAMP]                => 3.5
///
/// The equation is divided into 3 parts:
///
/// ----------------------------------------------------------------------------
/// Part - 1
/// ----------------------------------------------------------------------------
///
/// Formula: 1.5 * W
///
/// Indicates the energy cost of standing still supporting the own weight
/// of the person.
///
/// ----------------------------------------------------------------------------
/// Part - 2
/// ----------------------------------------------------------------------------
///
/// Formula: 2.0 (W + L)(L/W)²
///
/// Indicates the energy cost of standing still with the bag pack on.
///
/// ----------------------------------------------------------------------------
/// Part - 3
/// ----------------------------------------------------------------------------
///
/// Formula: n(W + L)(1.5V² + 0.35VG)
///
/// Indicates the energy needed to walk at the given speed including the
/// gradient(inclination) & terrain factor.
///
/// This formula and theory is referenced from the following link:
/// https://www.outsideonline.com/2315751/ultimate-backpacking-calorie-estimator
class CaloriesCalculator {
  /// Calculates Metabolic Rate of Rucking in Watts
  static double getMetabolicRate(
      {@required Weight weight,
      @required Weight bagWeight,
      @required Speed speed,
      @required Terrain terrain,
      @required int inclination}) {
    final W = weight.inKG;
    final L = bagWeight.inKG;
    final V = speed.inMetrePerSecond;
    final G = inclination.toDouble();
    final N = terrain.factor;

    print('(W = $W, L = $L, V = $V, G = $G, N = $N)');

    final rate = (1.5 * W) +
        (2.0 * (W + L) * pow(L / W, 2)) +
        (N * (W + L) * (1.5 * pow(V, 2) + 0.35 * V * G));

    return rate;
  }

  static Calculation calculateCalories(
      {@required Weight weight,
      @required Weight bagWeight,
      @required Speed speed,
      @required Terrain terrain,
      @required int inclination}) {
    final calories = Calories(
        watts: getMetabolicRate(
            weight: weight,
            bagWeight: bagWeight,
            speed: speed,
            terrain: terrain,
            inclination: inclination));
    return Calculation(
      hikerWeight: weight,
      packWeight: bagWeight,
      hikingSpeed: speed,
      terrain: terrain,
      inclination: inclination,
      calories: calories,
      kcalPerHour: calories.inKCalPerHour,
      kcalPerMile: calories.toKcalPerMile(speed.inMPH),
    );
  }
}
