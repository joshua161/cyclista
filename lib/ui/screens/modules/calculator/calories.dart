class Calories implements Comparable<Calories> {
  /// this means there are [_equationFactor] watts in 1 cal/hour.
  /// In other words, 1 calorie per hour(cal/h) = 0.001163 watts (W)
  static const double _equationFactor = 0.001163;

  // the value of calories in watts
  final double _calories;

  static const Calories zero = Calories._watts(0);

  const Calories(
      {double watts = 0,
      double calPerHour = 0,
      double calPerSecond = 0,
      double calPerMinute = 0})
      : this._watts(watts +
            (_equationFactor * calPerHour) +
            (_equationFactor * calPerSecond * 3600) +
            (_equationFactor * calPerMinute * 60));

  const Calories._watts(this._calories);

  double get inWatts => _calories;

  double get inCalPerHour => _calories / _equationFactor;

  double get inCalPerMinute => (_calories / _equationFactor) * 60;

  double get inCalPerSecond => (_calories / _equationFactor) * 3600;

  double get inKCalPerHour => inCalPerHour / 1000;

  double get inKCalPerMinute => inCalPerMinute / 1000;

  double get inKCalPerSecond => inCalPerSecond / 1000;

  double get inKCalPerMile => inKCalPerHour / 1000;

  double toKcalPerMile(double miles) => inKCalPerHour / miles;

  @override
  int compareTo(Calories other) => _calories.compareTo(other._calories);

  Calories operator +(Calories other) =>
      Calories._watts(_calories + other._calories);

  Calories operator -(Calories other) =>
      Calories._watts(_calories - other._calories);

  Calories operator *(num factor) => Calories._watts((_calories * factor));

  Calories operator /(int quotient) {
    // By doing the check here instead of relying on '~/' below we get the
    // exception even with dart2js.
    if (quotient == 0) throw IntegerDivisionByZeroException();
    return Calories._watts(_calories / quotient);
  }

  bool operator <(Calories other) => _calories < other._calories;

  bool operator >(Calories other) => _calories > other._calories;

  bool operator <=(Calories other) => _calories <= other._calories;

  bool operator >=(Calories other) => _calories >= other._calories;

  @override
  bool operator ==(dynamic other) =>
      other is Calories && _calories == other._calories;

  @override
  int get hashCode => _calories.hashCode;

  @override
  String toString() =>
      'Calories(watts: $_calories, calPerHour: $inCalPerHour, calPerSecond: $inCalPerSecond, kcalPerHour: $inKCalPerHour, kcalPerSecond: $inKCalPerSecond, kcalPerMinute: $inKCalPerMinute)';
}
