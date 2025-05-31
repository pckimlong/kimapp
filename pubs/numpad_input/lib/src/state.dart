part of 'widget.dart';

extension StringExtension on String {
  String myRemoveLast() {
    return (isNotEmpty) ? substring(0, length - 1) : "";
  }
}

class EnterAmountNotifier {
  EnterAmountNotifier({required this.stateNotifier});

  final ValueNotifier<EnterAmountState> stateNotifier;

  void bindInitialValue(num initialValue) {
    final formattedValue = initialValue.toStringAsFixed(2).removeDecimalFromStringIfZero();
    _changeCalItemState([CalculatorItemNumber(formattedValue)]);
  }

  void mapStateToEvent(EnterAmountEvent event) {
    switch (event) {
      case EnterAmountEventNumberPress(number: final number):
        _addNumber(number);
      case EnterAmountEventEqualPress():
        _performCalculation();
      case EnterAmountEventOperatorPress(operator: final calOperator):
        _operatorPress(calOperator);
      case EnterAmountEventClearPress():
        _changeCalItemState([CalculatorItemNumber("0")]);
      case EnterAmountEventDotPress():
        _onDotPress();
      case EnterAmountEventBackspacePress():
        _backspacePress();
      case EnterAmountEventThreeZeroPress():
        _threeZeroPress();
    }
  }

  void _addCalItemToTheLastAndUpdateState(CalculatorItem item) {
    final addedList = [..._calItems, item];
    _changeCalItemState(addedList);
  }

  void _addNumber(int number) {
    final lastItem = _lastItem;
    switch (lastItem) {
      case CalculatorItemNumber(value: final value):
        // Maximum length of number
        if (_reachedMaxLength(value)) {
          return;
        }

        // Allow only 2 decimal
        if (value.contains('.') && value.indexOf('.') == value.length - 3) {
          return;
        }

        // If the last char is dot, no need to do anything just add another
        // number behind it
        if (value.isNotEmpty &&
            (value.substring(value.length - 1) == "." ||
                value.substring(value.length - 1) == "-")) {
          _updateLastCalItemAndUpdateState(CalculatorItemNumber("$value$number"));
          return;
        }

        // If First char is zero replace it with number
        final initial = double.parse(value);
        if (initial == 0 && !value.contains(".")) {
          _updateLastCalItemAndUpdateState(CalculatorItemNumber(number.toString()));
          return;
        }

        // Other wise just add to the end of it
        final newValue = CalculatorItemNumber("$value$number");
        _updateLastCalItemAndUpdateState(newValue);
      default:
        final currentState = stateNotifier.value;
        stateNotifier.value = currentState.copyWith(
          calItems: [...currentState.calItems, CalculatorItemNumber(number.toString())],
        );
    }
  }

  void _backspacePress() {
    final lastItem = _lastItem;
    switch (lastItem) {
      case CalculatorItemNumber(value: final value):
        String newValue = value.myRemoveLast();

        // When clear number to empty
        if (newValue.isEmpty) {
          // Check if list has only one item or not
          if (_calItems.length == 1) {
            // If one item left, just make it zero
            newValue = "0";
          } else {
            // Otherwise remove the last item
            _calItems.removeLast();
            _changeCalItemState(_calItems);
            return;
          }
        }
        _updateLastCalItemAndUpdateState(CalculatorItemNumber(newValue));
      default:
        if (_calItems.isNotEmpty) {
          _calItems.removeLast();
          _changeCalItemState(_calItems);
        }
    }
  }

  List<CalculatorItem> get _calItems => List.from(stateNotifier.value.calItems);

  void _calculate() {
    /// Mutable list which can reduce
    final List<CalculatorItem> calcs = _calItems;

    /// Temporary store number
    num result = 0;

    // Perform calculate on "*" or "/" first
    while (calcs.contains(CalculatorItemDivide()) || calcs.contains(CalculatorItemMultiply())) {
      // Find operator position
      final pos = calcs.indexWhere(
        (e) => switch (e) {
          CalculatorItemDivide() => true,
          CalculatorItemMultiply() => true,
          _ => false,
        },
      );
      if (pos <= 0 || pos >= calcs.length - 1) {
        // Invalid operator position, mark as error and stop
        final currentState = stateNotifier.value;
        stateNotifier.value = currentState.copyWith(incorrectFormat: true);
        return;
      }
      _reduceCalItems(calcs, pos, result);
    }

    //After clear "/" and "*". Perform simple calculation on "+" or "-"
    while (calcs.length > 1) {
      final pos = calcs.indexWhere(
        (e) => switch (e) {
          CalculatorItemAdd() => true,
          CalculatorItemSubtract() => true,
          _ => false,
        },
      );
      if (pos <= 0 || pos >= calcs.length - 1) {
        final currentState = stateNotifier.value;
        stateNotifier.value = currentState.copyWith(incorrectFormat: true);
        return;
      }
      _reduceCalItems(calcs, pos, result);
    }

    _changeCalItemState([calcs[0]]);
  }

  void _changeCalItemState(List<CalculatorItem> items) {
    final currentState = stateNotifier.value;
    stateNotifier.value = currentState.copyWith(calItems: items);
  }

  /// If list is in invalid state, restore it to normal, this should call
  /// when calItems list state changed
  void _clearValueError() {
    final currentState = stateNotifier.value;
    stateNotifier.value = currentState.copyWith(incorrectFormat: false, valueErrorMgs: null);
  }

  CalculatorItem get _lastItem => stateNotifier.value.calItems.last;

  void _onDotPress() {
    final lastItem = _lastItem;
    switch (lastItem) {
      case CalculatorItemNumber(value: final value):
        // Don't add if already existed
        if (value.contains(".")) {
          return;
        }

        final newValue = "$value.";
        _updateLastCalItemAndUpdateState(CalculatorItemNumber(newValue));
      default:
        _addCalItemToTheLastAndUpdateState(CalculatorItemNumber("0."));
    }
  }

  void _operatorPress(CalculatorItem calOperator) {
    final lastItem = _lastItem;
    switch (lastItem) {
      case CalculatorItemNumber(value: final value):
        // If there - sign don't add it again, this lead to error
        if (value.isNotEmpty && value.substring(value.length - 1) == "-") {
          return;
        }

        final number = double.parse(value);

        // If the number is zero we cannot use any operator, except it is a
        // subtraction we can insert
        if (number == 0) {
          switch (calOperator) {
            case CalculatorItemSubtract():
              _updateLastCalItemAndUpdateState(CalculatorItemNumber("-"));
              break;
            default:
              break;
          }
          return;
        }

        // Other from zero, just add normally
        _addCalItemToTheLastAndUpdateState(calOperator);
      default:
        _updateLastCalItemAndUpdateState(calOperator);
    }
  }

  void _performCalculation() {
    final lastItem = _lastItem;
    switch (lastItem) {
      case CalculatorItemNumber():
        _calculate();
      default:
        // make widget shaking
        final currentState = stateNotifier.value;
        stateNotifier.value = currentState.copyWith(incorrectFormat: false);
        stateNotifier.value = currentState.copyWith(incorrectFormat: true);
    }
  }

  bool _reachedMaxLength(String string) {
    if (string.length >= 13) {
      final currentState = stateNotifier.value;
      stateNotifier.value = currentState.copyWith(valueErrorMgs: 'Maximum characters');
      return true;
    }
    return false;
  }

  void _reduceCalItems(List<CalculatorItem> calcs, int pos, num result) {
    final leftOp = switch (calcs[pos - 1]) {
      CalculatorItemNumber(value: final value) => value,
      _ => throw ArgumentError('Expected a number at position ${pos - 1}'),
    };
    final rightOp = switch (calcs[pos + 1]) {
      CalculatorItemNumber(value: final value) => value,
      _ => throw ArgumentError('Expected a number at position ${pos + 1}'),
    };

    switch (calcs[pos]) {
      case CalculatorItemAdd():
        result = num.parse(leftOp) + num.parse(rightOp);
      case CalculatorItemSubtract():
        result = num.parse(leftOp) - num.parse(rightOp);
      case CalculatorItemDivide():
        result = num.parse(leftOp) / num.parse(rightOp);
      case CalculatorItemMultiply():
        result = num.parse(leftOp) * num.parse(rightOp);
      default:
        throw ArgumentError('Unexpected calculator item at position $pos');
    }
    calcs.removeAt(pos);
    calcs.removeAt(pos);
    final resultString = result.toStringAsFixed(2).removeDecimalFromStringIfZero();
    calcs[pos - 1] = CalculatorItemNumber(resultString);
  }

  void _threeZeroPress() {
    final lastItem = _lastItem;
    switch (lastItem) {
      case CalculatorItemNumber(value: final value):
        if (_reachedMaxLength(value)) {
          return;
        }

        final v = num.parse(value);
        if (v == 0) {
          return;
        }

        if (value.contains(".")) {
          var newValue = value;
          if (value.isNotEmpty && value.substring(value.length - 1) == ".") {
            newValue = "${newValue}00";
          } else if (newValue.split(".").last.length == 1) {
            newValue = "${newValue}0";
          }
          _updateLastCalItemAndUpdateState(CalculatorItemNumber(newValue));
        } else {
          var newValue = "${value}000";
          final newLength = newValue.length;
          if (newLength > 13) {
            final greaterLength = 13 - value.length;
            newValue = value + "0" * greaterLength;
          }
          _updateLastCalItemAndUpdateState(CalculatorItemNumber(newValue));
        }
      default:
        _addCalItemToTheLastAndUpdateState(CalculatorItemNumber("0"));
    }
  }

  void _updateLastCalItemAndUpdateState(CalculatorItem updated) {
    final removedList = _calItems.sublist(0, _calItems.length - 1);
    final updatedList = [...removedList, updated];
    _changeCalItemState(updatedList);
  }
}
