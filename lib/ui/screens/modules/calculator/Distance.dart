class Distance implements Comparable<Distance> {
  /// 1 km = 0.62137 miles
  static const double _milesFactor = 0.62137;

  /// 1 km = 1093.613298 Yards
  static const double _yardFactor = 1093.613298;

  /// 1 km = 39370.07874 Inches
  static const double _inchFactor = 39370.07874;

  /// 1 km = 3280.839895 Ft
  static const double _feetFactor = 3280.839895;

  // the value of speed in km
  final double _distance;

  static const Distance zero = Distance._km(0);

  const Distance(
      {double km = 0,
      double miles = 0,
      double yards = 0,
      double inches = 0,
      double metres = 0,
      double ft = 0})
      : this._km(km +
            (miles / _milesFactor) +
            (yards / _yardFactor) +
            (inches / _inchFactor) +
            (metres / 1000) +
            (ft / _feetFactor));

  const Distance._km(this._distance);

  double get inKM => _distance;

  double get inMeters => _distance * 1000;

  double get inYards => _distance * _yardFactor;

  double get inInches => _distance * _inchFactor;

  double get inFt => _distance * _feetFactor;

  double get inMiles => _milesFactor * _distance;

  @override
  int compareTo(Distance other) => _distance.compareTo(other._distance);

  Distance operator +(Distance other) =>
      Distance._km(_distance + other._distance);

  Distance operator -(Distance other) =>
      Distance._km(_distance - other._distance);

  Distance operator *(num factor) => Distance._km((_distance * factor));

  Distance operator /(int quotient) {
    // By doing the check here instead of relying on '~/' below we get the
    // exception even with dart2js.
    if (quotient == 0) throw IntegerDivisionByZeroException();
    return Distance._km(_distance / quotient);
  }

  bool operator <(Distance other) => _distance < other._distance;

  bool operator >(Distance other) => _distance > other._distance;

  bool operator <=(Distance other) => _distance <= other._distance;

  bool operator >=(Distance other) => _distance >= other._distance;

  @override
  bool operator ==(dynamic other) =>
      other is Distance && _distance == other._distance;

  @override
  int get hashCode => _distance.hashCode;

  @override
  String toString() =>
      'Distance(km: $inKM, miles: $inMiles, meters: $inMeters, yards: $inYards, inches: $inInches, ft: $inFt)';
}
