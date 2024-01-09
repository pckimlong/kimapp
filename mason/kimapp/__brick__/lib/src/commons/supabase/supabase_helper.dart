import 'package:supabase_flutter/supabase_flutter.dart';

import '../../features/auth/auth.dart';

extension SupabaseUserX on User {
  UserId get userId => UserId.fromValue(id);
}
