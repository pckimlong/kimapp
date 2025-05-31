import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:numpad_input/src/objects.dart';
import 'package:numpad_input/src/widget.dart';

void main() {
  group('_EnterAmountNotifier', () {
    late ValueNotifier<EnterAmountState> stateNotifier;
    late EnterAmountNotifier notifier;

    setUp(() {
      stateNotifier = ValueNotifier(EnterAmountState.initial());
      notifier = EnterAmountNotifier(stateNotifier: stateNotifier);
    });

    test('Initial state is zero', () {
      expect(stateNotifier.value.calItems.length, 1);
      expect(stateNotifier.value.calItems.first, isA<CalculatorItemNumber>());
      expect((stateNotifier.value.calItems.first as CalculatorItemNumber).value, '0');
    });

    test('Number entry appends correctly', () {
      notifier.mapStateToEvent(EnterAmountEventNumberPress(1));
      expect((stateNotifier.value.calItems.first as CalculatorItemNumber).value, '1');
      notifier.mapStateToEvent(EnterAmountEventNumberPress(2));
      expect((stateNotifier.value.calItems.first as CalculatorItemNumber).value, '12');
    });

    test('Operator entry and calculation', () {
      notifier.mapStateToEvent(EnterAmountEventNumberPress(2));
      notifier.mapStateToEvent(EnterAmountEventOperatorPress(CalculatorItemAdd()));
      notifier.mapStateToEvent(EnterAmountEventNumberPress(3));
      expect(stateNotifier.value.calItems.length, 3);
      notifier.mapStateToEvent(EnterAmountEventEqualPress());
      expect(stateNotifier.value.calItems.length, 1);
      expect((stateNotifier.value.calItems.first as CalculatorItemNumber).value, '5');
    });

    test('Handles subtraction and negative numbers', () {
      notifier.mapStateToEvent(EnterAmountEventNumberPress(5));
      notifier.mapStateToEvent(EnterAmountEventOperatorPress(CalculatorItemSubtract()));
      notifier.mapStateToEvent(EnterAmountEventNumberPress(8));
      notifier.mapStateToEvent(EnterAmountEventEqualPress());
      expect((stateNotifier.value.calItems.first as CalculatorItemNumber).value, '-3');
    });

    test('Handles decimals', () {
      notifier.mapStateToEvent(EnterAmountEventNumberPress(1));
      notifier.mapStateToEvent(EnterAmountEventDotPress());
      notifier.mapStateToEvent(EnterAmountEventNumberPress(5));
      notifier.mapStateToEvent(EnterAmountEventOperatorPress(CalculatorItemAdd()));
      notifier.mapStateToEvent(EnterAmountEventNumberPress(2));
      notifier.mapStateToEvent(EnterAmountEventDotPress());
      notifier.mapStateToEvent(EnterAmountEventNumberPress(5));
      notifier.mapStateToEvent(EnterAmountEventEqualPress());
      expect((stateNotifier.value.calItems.first as CalculatorItemNumber).value, '4');
    });

    test('Handles max length error', () {
      for (int i = 0; i < 14; i++) {
        notifier.mapStateToEvent(EnterAmountEventNumberPress(9));
      }
      expect(stateNotifier.value.valueErrorMgs, isNotNull);
    });

    test('Handles backspace', () {
      notifier.mapStateToEvent(EnterAmountEventNumberPress(1));
      notifier.mapStateToEvent(EnterAmountEventNumberPress(2));
      notifier.mapStateToEvent(EnterAmountEventBackspacePress());
      expect((stateNotifier.value.calItems.first as CalculatorItemNumber).value, '1');
      notifier.mapStateToEvent(EnterAmountEventBackspacePress());
      expect((stateNotifier.value.calItems.first as CalculatorItemNumber).value, '0');
    });

    test('Handles clear', () {
      notifier.mapStateToEvent(EnterAmountEventNumberPress(1));
      notifier.mapStateToEvent(EnterAmountEventClearPress());
      expect((stateNotifier.value.calItems.first as CalculatorItemNumber).value, '0');
    });

    test('Handles three zero press', () {
      notifier.mapStateToEvent(EnterAmountEventNumberPress(1));
      notifier.mapStateToEvent(EnterAmountEventThreeZeroPress());
      expect((stateNotifier.value.calItems.first as CalculatorItemNumber).value, '1000');
    });

    test('Handles invalid operator at end (shakes)', () {
      notifier.mapStateToEvent(EnterAmountEventNumberPress(1));
      notifier.mapStateToEvent(EnterAmountEventOperatorPress(CalculatorItemAdd()));
      notifier.mapStateToEvent(EnterAmountEventEqualPress());
      expect(stateNotifier.value.incorrectFormat, isTrue);
    });
  });
}
