library either;

import 'package:meta/meta.dart';

typedef RightFunc<S, R> = S Function(R data);
typedef LeftFunc<S, L> = S Function(L failure);

/// Represents the value of one of two possible types, [Left] or [Right].
///
/// [Either] is commonly used for error handling. Returns an instance of [Left] containing
/// a given failure object and instance of [Right] containing a given success
/// object.

@immutable
abstract class Either<L, R> {
  const Either();

  /// Return `true` when this [Either] is [Left].
  bool get isLeft;

  /// Return `true` when this [Either] is [Right].
  bool get isRight;

  S fold<S>(LeftFunc<S, L> l, RightFunc<S, R> r);
}

@immutable
class Right<L, R> implements Either<L, R> {
  const Right(this._r);
  final R _r;

  /// Extract the value of type `R` inside the [Right].
  R get value => _r;

  @override
  S fold<S>(LeftFunc<S, L> l, RightFunc<S, R> r) => r(_r);

  @override
  bool get isLeft => false;

  @override
  bool get isRight => true;

  @override
  bool operator ==(covariant Object other) {
    if (other is Right) {
      return other._r == _r;
    }
    return false;
  }

  @override
  int get hashCode => _r.hashCode;
}

@immutable
class Left<L, R> implements Either<L, R> {
  const Left(this._l);
  final L _l;

  /// Extract the value of type `L` inside the [Left].
  L get value => _l;

  @override
  S fold<S>(LeftFunc<S, L> l, RightFunc<S, R> r) => l(_l);

  @override
  bool get isLeft => true;

  @override
  bool get isRight => false;

  @override
  bool operator ==(covariant Object other) {
    if (other is Left) {
      return other._l == _l;
    }
    return false;
  }

  @override
  int get hashCode => _l.hashCode;
}
