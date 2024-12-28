import 'package:flutter/services.dart';

TextInputFormatter inputFormatterKhmerNumToDigit = TextInputFormatter.withFunction(
  (oldValue, newValue) {
    final replacement = newValue.text
        .replaceAll('០', "0")
        .replaceAll('១', '1')
        .replaceAll('២', '2')
        .replaceAll('៣', '3')
        .replaceAll('៤', '4')
        .replaceAll('៥', '5')
        .replaceAll('៦', '6')
        .replaceAll('៧', '7')
        .replaceAll('៨', '8')
        .replaceAll('៩', '9');
    return TextEditingValue(
      text: replacement,
      selection: TextSelection.collapsed(offset: replacement.length),
    );
  },
);
TextInputFormatter get inputFormatterKhmerNumToDigitWithDouble => TextInputFormatter.withFunction(
      (oldValue, newValue) {
        final replacement = newValue.text
            .replaceAll('០', "0")
            .replaceAll('១', '1')
            .replaceAll('២', '2')
            .replaceAll('៣', '3')
            .replaceAll('៤', '4')
            .replaceAll('៥', '5')
            .replaceAll('៦', '6')
            .replaceAll('៧', '7')
            .replaceAll('៨', '8')
            .replaceAll('។', '.')
            .replaceAll(',', '.')
            .replaceAll('៩', '9');
        return TextEditingValue(
          text: replacement,
          selection: TextSelection.collapsed(offset: replacement.length),
        );
      },
    );

List<TextInputFormatter> get inputFormatterNumeric => [
      FilteringTextInputFormatter.allow(RegExp(r"[0-9១២៣៤៥៦៧៨៩០។.,]")),
      inputFormatterKhmerNumToDigitWithDouble,
      TextInputFormatter.withFunction((oldValue, newValue) {
        final result = num.tryParse(newValue.text);
        if (result == null && newValue.text.isNotEmpty) return oldValue;
        return newValue;
      }),
    ];

List<TextInputFormatter> get inputFormatterInt => [
      FilteringTextInputFormatter.allow(RegExp(r"[0-9១២៣៤៥៦៧៨៩០]")),
      inputFormatterKhmerNumToDigit,
      TextInputFormatter.withFunction((oldValue, newValue) {
        final result = int.tryParse(newValue.text);
        if (result == null && newValue.text.isNotEmpty) return oldValue;
        return newValue;
      }),
    ];

List<TextInputFormatter> inputFormatterPhoneNumber([int maxLength = 12]) => [
      LengthLimitingTextInputFormatter(maxLength),
      FilteringTextInputFormatter.allow(RegExp(r"[0-9១២៣៤៥៦៧៨៩០/+]")),
      inputFormatterKhmerNumToDigit,
    ];



class ThousandsFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;
    final selection = newValue.selection;

    String newText = text.replaceAll(',', '');
    final matches = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))').allMatches(newText);
    int offset = 0;
    for (Match match in matches) {
      newText =
          newText.replaceRange(match.start + offset, match.end + offset, '${match.group(1)},');
      offset += 1;
    }

    final newSelection = selection.copyWith(
      baseOffset: selection.baseOffset + offset,
      extentOffset: selection.extentOffset + offset,
    );

    final start = newSelection.start;
    final end = newSelection.end;
    final length = newText.length;

    final newStart = start >= 0 && start <= length ? start : length;
    final newEnd = end >= 0 && end <= length ? end : length;

    return TextEditingValue(
      text: newText,
      selection: TextSelection(
        baseOffset: newStart,
        extentOffset: newEnd,
        affinity: newSelection.affinity,
        isDirectional: newSelection.isDirectional,
      ),
    );
  }
}

class NumericInputFormatter extends TextInputFormatter {
  static final _regExp = RegExp(r'[^\d\.]');

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final filteredText = newValue.text.replaceAll(_regExp, '');
    return TextEditingValue(
      text: filteredText,
      selection: newValue.selection.copyWith(
        baseOffset: filteredText.length,
        extentOffset: filteredText.length,
      ),
    );
  }
}

List<TextInputFormatter> inputFormatterMoney() => [
      NumericInputFormatter(),
      ThousandsFormatter(),
    ];
