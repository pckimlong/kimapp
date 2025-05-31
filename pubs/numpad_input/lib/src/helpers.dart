extension NumpadInputStringHelper on String {
  String getLastChar() {
    if (trim().isEmpty) return this;
    return this[length - 1];
  }

  String removeDecimalFromStringIfZero() {
    if (contains(".")) {
      final result = num.tryParse(this);
      if (result == null) {
        return this;
      }

      final decimal = split(".").last;
      final decimalValue = num.parse(decimal);
      if (decimalValue == 0) {
        return split(".").first;
      }
    }
    return this;
  }

  String removeLast() {
    if (trim().isEmpty) return this;
    final List<String> chars = split("");
    chars.removeLast();
    return chars.join();
  }
}
