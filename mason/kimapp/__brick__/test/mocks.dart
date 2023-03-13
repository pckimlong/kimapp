import 'package:mocktail/mocktail.dart';
import 'package:sok_chea_sihanouk_clinic/exports.dart';
import 'package:sok_chea_sihanouk_clinic/src/features/auth/auth.dart';

class MockAuthRepo extends Mock implements IAuthRepo {}

class MockLocalStorage extends Mock implements LocalStorage {}
