import 'dart:math';

import 'package:flutter/material.dart';
import 'package:numpad_input/src/helpers.dart';
import 'package:numpad_input/src/objects.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

part 'state.dart';

enum NumpadInputType { numeric, integer }

class NumpadInput extends StatefulWidget {
  const NumpadInput({
    super.key,
    required this.initialNumber,
    this.type = NumpadInputType.numeric,
    this.isPreselected = true,
    this.additionalButton = '00',
  });

  final num? initialNumber;

  /// Type of number input. if [NumpadInputType.integer] button / and . will be disable
  final NumpadInputType type;

  /// When [isPreselected] is true, the initial value is considered "selected" (as if highlighted).
  /// The next user input (number or operator) will override the current value instead of appending to it.
  /// This is useful for cases where you want the first user action to immediately replace the default or pre-filled value,
  /// providing a more intuitive experience for quick data entry.
  final bool isPreselected;

  /// Additional button, default is '00'. Make sure this are number
  final String additionalButton;

  @override
  State<NumpadInput> createState() => _NumpadInputState();
}

class _NumpadInputState extends State<NumpadInput> {
  late final ValueNotifier<EnterAmountState> _enterAmountStateNotifier;
  late final GlobalKey<_ShakerState> _shakeKey;

  @override
  void initState() {
    super.initState();
    _enterAmountStateNotifier = ValueNotifier(EnterAmountState.initial());
    _shakeKey = GlobalKey<_ShakerState>();

    if (widget.initialNumber != null) {
      Future.microtask(() {
        bindInitialValue(widget.initialNumber!);
      });
    }
  }

  @override
  void dispose() {
    _enterAmountStateNotifier.dispose();
    super.dispose();
  }

  void bindInitialValue(num initialNumber) {
    final formattedValue = initialNumber.toStringAsFixed(2).removeDecimalFromStringIfZero();
    _enterAmountStateNotifier.value = _enterAmountStateNotifier.value.copyWith(
      calItems: [CalculatorItemNumber(formattedValue)],
    );
  }

  void mapStateToEvent(EnterAmountEvent event) {
    final currentState = _enterAmountStateNotifier.value;
    final notifier = EnterAmountNotifier(stateNotifier: _enterAmountStateNotifier);
    notifier.mapStateToEvent(event);
  }

  void _clearValueError() {
    _enterAmountStateNotifier.value = _enterAmountStateNotifier.value.copyWith(
      incorrectFormat: false,
      valueErrorMgs: null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<EnterAmountState>(
      valueListenable: _enterAmountStateNotifier,
      builder: (context, state, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: _Result(enterAmountState: state),
              ),
            ),
            _Shaker(
              key: _shakeKey,
              child: Card(
                color: Theme.of(context).colorScheme.primary,
                child: Stack(
                  children: [
                    GridView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 1.8,
                      ),
                      children: [
                        _Button(
                          greyColor: true,
                          onTap: () => mapStateToEvent(EnterAmountEventClearPress()),
                          child: const Text('C'),
                        ),
                        _Button(
                          greyColor: true,
                          enabled: widget.type == NumpadInputType.numeric,
                          onTap:
                              () => mapStateToEvent(
                                EnterAmountEventOperatorPress(CalculatorItemDivide()),
                              ),
                          child: const Text('/'),
                        ),
                        _Button(
                          greyColor: true,
                          onTap:
                              () => mapStateToEvent(
                                EnterAmountEventOperatorPress(CalculatorItemMultiply()),
                              ),
                          child: const Text('*'),
                        ),
                        _Button(
                          greyColor: true,
                          onTap: () => mapStateToEvent(EnterAmountEventBackspacePress()),
                          child: const Icon(Icons.backspace_outlined),
                        ),
                        _Button(
                          number: 7,
                          onTap: () => mapStateToEvent(EnterAmountEventNumberPress(7)),
                        ),
                        _Button(
                          number: 8,
                          onTap: () => mapStateToEvent(EnterAmountEventNumberPress(8)),
                        ),
                        _Button(
                          number: 9,
                          onTap: () => mapStateToEvent(EnterAmountEventNumberPress(9)),
                        ),
                        _Button(
                          greyColor: true,
                          onTap:
                              () => mapStateToEvent(
                                EnterAmountEventOperatorPress(CalculatorItemSubtract()),
                              ),
                          child: const Text('-'),
                        ),
                        _Button(
                          number: 4,
                          onTap: () => mapStateToEvent(EnterAmountEventNumberPress(4)),
                        ),
                        _Button(
                          number: 5,
                          onTap: () => mapStateToEvent(EnterAmountEventNumberPress(5)),
                        ),
                        _Button(
                          number: 6,
                          onTap: () => mapStateToEvent(EnterAmountEventNumberPress(6)),
                        ),
                        _Button(
                          greyColor: true,
                          onTap:
                              () => mapStateToEvent(
                                EnterAmountEventOperatorPress(CalculatorItemAdd()),
                              ),
                          child: const Text('+'),
                        ),
                        _Button(
                          number: 1,
                          onTap: () => mapStateToEvent(EnterAmountEventNumberPress(1)),
                        ),
                        _Button(
                          number: 2,
                          onTap: () => mapStateToEvent(EnterAmountEventNumberPress(2)),
                        ),
                        _Button(
                          number: 3,
                          onTap: () => mapStateToEvent(EnterAmountEventNumberPress(3)),
                        ),
                        Container(),
                        _Button(
                          enabled: widget.type == NumpadInputType.numeric,
                          onTap: () => mapStateToEvent(EnterAmountEventDotPress()),
                          child: const Text('.'),
                        ),
                        _Button(
                          number: 0,
                          onTap: () => mapStateToEvent(EnterAmountEventNumberPress(0)),
                        ),
                        _Button(
                          onTap: () => mapStateToEvent(EnterAmountEventThreeZeroPress()),
                          child: const Text('00'),
                        ),
                        Container(),
                      ],
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
                          width: MediaQuery.of(context).size.width / 4 - 2,
                          height: MediaQuery.of(context).size.width / 4 + 8,
                          child: Material(
                            color: Colors.transparent,
                            child: _SubmitButton(enterAmountState: state),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({required this.enterAmountState});

  final EnterAmountState enterAmountState;

  @override
  Widget build(BuildContext context) {
    final showEqualButton = enterAmountState.showEqualButton;

    return InkWell(
      onTap:
          showEqualButton
              ? () {
                // Find the nearest _NumpadInputState and call mapStateToEvent
                final state = context.findAncestorStateOfType<_NumpadInputState>();
                state?.mapStateToEvent(EnterAmountEventEqualPress());
              }
              : () {
                Navigator.of(context).pop(enterAmountState);
              },
      child: Center(
        child:
            showEqualButton
                ? const Text(
                  '=',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 48),
                )
                : const Icon(Icons.check, color: Colors.white, size: 32),
      ),
    );
  }
}

class _Result extends StatelessWidget {
  const _Result({required this.enterAmountState});

  final EnterAmountState enterAmountState;

  @override
  Widget build(BuildContext context) {
    final result = enterAmountState.calItems;
    final invalid = enterAmountState.incorrectFormat;
    String displayText = "";
    for (var item in result) {
      if (item is CalculatorItemNumber) {
        displayText += item.value;
      } else {
        displayText += item.displayText;
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      width: double.infinity,
      child: Text(
        displayText,
        textAlign: TextAlign.end,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 42,
          overflow: TextOverflow.fade,
          color: invalid ? Theme.of(context).colorScheme.error : null,
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({this.onTap, this.child, this.number, this.greyColor = false, this.enabled = true});

  final VoidCallback? onTap;
  final Widget? child;
  final int? number;
  final bool greyColor;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: greyColor ? Theme.of(context).scaffoldBackgroundColor : Colors.white,
        border: Border.all(color: Theme.of(context).hintColor.withValues(alpha: 0.1), width: 0.6),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: number != null ? () => onTap?.call() : onTap,
          child: DefaultTextStyle(
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Center(child: child ?? Text("$number")),
          ),
        ),
      ),
    );
  }
}

class _Shaker extends StatefulWidget {
  const _Shaker({super.key, required this.child});

  final Widget child;

  @override
  State<_Shaker> createState() => _ShakerState();
}

class _ShakerState extends State<_Shaker> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 550), // how long the shake happens
    )..addListener(() => setState(() {}));

    animation = Tween<double>(begin: 00.0, end: 120.0).animate(animationController);
  }

  Vector3 _shake() {
    final double progress = animationController.value;
    final double offset = sin(progress * pi * 80.0);
    return Vector3(offset * 2, 0.0, 0.0);
  }

  shake() {
    animationController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Transform(transform: Matrix4.translation(_shake()), child: widget.child);
  }
}
