class Speed implements Comparable<Speed> {
  static const double _equationFactor = 0.62137;
  static const double _knotsFactor = 0.54;

  // the value of speed in km/h
  final double _speed;

  static const Speed zero = Speed._kmh(0);

  const Speed({double kmh = 0, double mph = 0, double knots = 0})
      : this._kmh(kmh + (mph / _equationFactor) + (knots / _knotsFactor));

  const Speed._kmh(this._speed);

  double get inKMH => _speed;

  double get inKnots => _speed * _knotsFactor;

  double get inMPH => _speed * _equationFactor;

  double get inMetrePerSecond => (_speed * 1000) / 3600;

  @override
  int compareTo(Speed other) => _speed.compareTo(other._speed);

  Speed operator +(Speed other) => Speed._kmh(_speed + other._speed);

  Speed operator -(Speed other) => Speed._kmh(_speed - other._speed);

  Speed operator *(num factor) => Speed._kmh((_speed * factor));

  Speed operator /(int quotient) {
    // By doing the check here instead of relying on '~/' below we get the
    // exception even with dart2js.
    if (quotient == 0) throw IntegerDivisionByZeroException();
    return Speed._kmh(_speed / quotient);
  }

  bool operator <(Speed other) => _speed < other._speed;

  bool operator >(Speed other) => _speed > other._speed;

  bool operator <=(Speed other) => _speed <= other._speed;

  bool operator >=(Speed other) => _speed >= other._speed;

  @override
  bool operator ==(dynamic other) => other is Speed && _speed == other._speed;

  @override
  int get hashCode => _speed.hashCode;

  @override
  String toString() => 'Speed(km/h: $inKMH, miles/hour: $inMPH)';
}
