import 'package:flutter/foundation.dart';

import '../../../exports.dart';

class OverrideFormBuilderLocalizationsEn extends FormBuilderLocalizationsImplEn {
  OverrideFormBuilderLocalizationsEn();

  static const LocalizationsDelegate<FormBuilderLocalizationsImpl> delegate =
      _LocalizationsDelegate();

  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('km'),
  ];

  @override
  String get requiredErrorText => 'ត្រូវតែបំពេញទីនេះ';
  @override
  String minLengthErrorText(Object minLength) {
    return 'ចំនួនតួអក្សរត្រូវតែច្រើនជា $minLength ខ្ទង់';
  }
}

class _LocalizationsDelegate extends LocalizationsDelegate<FormBuilderLocalizationsImpl> {
  const _LocalizationsDelegate();

  @override
  Future<FormBuilderLocalizationsImpl> load(Locale locale) {
    final instance = OverrideFormBuilderLocalizationsEn();
    // IMPORTANT!! must to invoke setCurrentInstance()
    FormBuilderLocalizations.setCurrentInstance(instance);
    return SynchronousFuture<FormBuilderLocalizationsImpl>(instance);
  }

  @override
  bool isSupported(Locale locale) =>
      OverrideFormBuilderLocalizationsEn.supportedLocales.contains(locale);

  @override
  bool shouldReload(_LocalizationsDelegate old) => false;
}
