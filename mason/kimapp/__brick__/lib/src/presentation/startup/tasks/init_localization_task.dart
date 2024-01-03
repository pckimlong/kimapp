import 'package:intl/date_symbol_data_local.dart';

import '../startup.dart';

class InitLocalizationTask extends StartUpTask {
  const InitLocalizationTask();

  @override
  Future<void> initialize(LaunchContext context) async {
    // To support Khmer language
    await initializeDateFormatting('km');

    await EasyLocalization.ensureInitialized();
  }
}
