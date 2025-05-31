import 'package:collection/collection.dart';
import 'package:intl/intl.dart';
import 'package:numpad_input/src/helpers.dart';

abstract class EnterAmountEvent {
  const EnterAmountEvent();
}

class EnterAmountEventBackspacePress extends EnterAmountEvent {
  const EnterAmountEventBackspacePress();
}

class EnterAmountEventClearPress extends EnterAmountEvent {
  const EnterAmountEventClearPress();
}

class EnterAmountEventDotPress extends EnterAmountEvent {
  const EnterAmountEventDotPress();
}

class EnterAmountEventEqualPress extends EnterAmountEvent {
  const EnterAmountEventEqualPress();
}

class EnterAmountEventNumberPress extends EnterAmountEvent {
  const EnterAmountEventNumberPress(this.number);
  final int number;
}

class EnterAmountEventOperatorPress extends EnterAmountEvent {
  const EnterAmountEventOperatorPress(this.operator);
  final CalculatorItem operator;
}

class EnterAmountEventThreeZeroPress extends EnterAmountEvent {
  const EnterAmountEventThreeZeroPress();
}

class EnterAmountState {
  EnterAmountState({
    required this.calItems,
    required this.incorrectFormat,
    required this.valueErrorMgs,
  });

  final List<CalculatorItem> calItems;
  final bool incorrectFormat;
  final String? valueErrorMgs;

  EnterAmountState copyWith({
    List<CalculatorItem>? calItems,
    bool? incorrectFormat,
    String? valueErrorMgs,
  }) {
    return EnterAmountState(
      calItems: calItems ?? this.calItems,
      incorrectFormat: incorrectFormat ?? this.incorrectFormat,
      valueErrorMgs: valueErrorMgs ?? this.valueErrorMgs,
    );
  }

  static EnterAmountState initial() {
    return EnterAmountState(
      incorrectFormat: false,
      valueErrorMgs: null,
      calItems: [CalculatorItemNumber("0")],
    );
  }

  bool get showEqualButton => calItems.length > 1;
  num? get result {
    if (calItems.isNotEmpty && calItems.last is CalculatorItemNumber) {
      return num.tryParse((calItems.last as CalculatorItemNumber).value);
    }
    return null;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EnterAmountState &&
          runtimeType == other.runtimeType &&
          ListEquality().equals(calItems, other.calItems) &&
          incorrectFormat == other.incorrectFormat &&
          valueErrorMgs == other.valueErrorMgs;

  @override
  int get hashCode => calItems.hashCode ^ incorrectFormat.hashCode ^ valueErrorMgs.hashCode;
}

sealed class CalculatorItem {
  const CalculatorItem._();

  String get displayText {
    return switch (this) {
      CalculatorItemAdd() => "+",
      CalculatorItemDivide() => "/",
      CalculatorItemMultiply() => "*",
      CalculatorItemNumber(value: final n) => () {
        if (n == "-") return n;

        final a = NumberFormat.decimalPattern();
        final s = a.format(double.parse(n));
        if (n.getLastChar() == ".") {
          return "$s.";
        }

        if (n.length >= 3 && n.contains(".")) {
          final decimal = n.split(".").last;
          if (decimal == "0") {
            return "$s.0";
          } else if (decimal == "00") {
            return "$s.00";
          } else if (decimal.length == 2 && decimal.getLastChar() == "0") {
            return "${s}0";
          }
        }

        return s;
      }(),
      CalculatorItemSubtract() => "-",
    };
  }
}

class CalculatorItemAdd extends CalculatorItem {
  CalculatorItemAdd() : super._();
}

class CalculatorItemDivide extends CalculatorItem {
  CalculatorItemDivide() : super._();
}

class CalculatorItemMultiply extends CalculatorItem {
  CalculatorItemMultiply() : super._();
}

class CalculatorItemNumber extends CalculatorItem {
  CalculatorItemNumber(this.value) : super._();
  final String value;
}

class CalculatorItemSubtract extends CalculatorItem {
  CalculatorItemSubtract() : super._();
}
