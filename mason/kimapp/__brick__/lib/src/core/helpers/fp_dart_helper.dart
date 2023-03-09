import 'package:fpdart/fpdart.dart';

extension OptionX<T> on Option<T> {
  T getOrCrash() {
    return getOrElse(() => throw Error());
  }
}
