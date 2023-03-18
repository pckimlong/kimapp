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
