/// Util class used to encapsulate two values
class Pair<M, N> {
  M first;
  N second;

  Pair(this.first, this.second);

  @override
  bool operator ==(Object other) {
    return (other == null && this == null ||
        other != null &&
            other is Pair &&
            first == other.first &&
            second == other.second);
  }

  @override
  int get hashCode => toString().hashCode;

  String toString() => "[First: $first\nSecond: $second]";
}

/// Util class used to encapsulate three values
class Triple<M, N, O> {
  M first;
  N second;
  O third;

  Triple(this.first, this.second, this.third);

  @override
  bool operator ==(Object other) {
    return (other == null && this == null ||
        other != null &&
            other is Quintuple &&
            first == other.first &&
            second == other.second &&
            third == other.third);
  }

  @override
  int get hashCode => toString().hashCode;

  String toString() => "[First: $first\nSecond: $second\nThird: $third]";
}

/// Util class used to encapsulate four values
class Quadruple<M, N, O, P> {
  M first;
  N second;
  O third;
  P fourth;

  Quadruple(this.first, this.second, this.third, this.fourth);

  @override
  bool operator ==(Object other) {
    return (other == null && this == null ||
        other != null &&
            other is Quintuple &&
            first == other.first &&
            second == other.second &&
            third == other.third &&
            fourth == other.fourth);
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() =>
      "[First: $first\nSecond: $second\nThird: $third\nFourth: $fourth]";
}

/// Util class used to encapsulate five values
class Quintuple<M, N, O, P, Q> {
  M first;
  N second;
  O third;
  P fourth;
  Q fifth;

  Quintuple(this.first, this.second, this.third, this.fourth, this.fifth);

  @override
  bool operator ==(Object other) {
    return (other == null && this == null ||
        other != null &&
            other is Quintuple &&
            first == other.first &&
            second == other.second &&
            third == other.third &&
            fourth == other.fourth &&
            fifth == other.fifth);
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() =>
      "[First: $first\nSecond: $second\nThird: $third\nFourth: $fourth\nFifth:$fifth]";
}
