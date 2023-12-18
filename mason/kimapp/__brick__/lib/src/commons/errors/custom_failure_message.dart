import 'package:kimapp/kimapp.dart';

class CustomFailureMessage extends FailureMessage {
  @override
  String get networkFailure => "មិនអាចភ្ជាប់ទៅបណ្ដាញបានទេ! សូមប្រាកដថាអ្នកបានភ្ជាប់ទៅកាន់អ៊ីនធឺណិត";

  @override
  String get serverError => "មានបញ្ហាទាក់ទងនិងម៉ាសុីនមេ!";

  @override
  String get databaseError => "មានភាពមិនប្រក្រតីនៃទិន្នន័យដែលអ្នកបានបញ្ជូល!";

  @override
  String get uniqueConstraintError => "អ្នកបានបញ្ជូលទិន្នន័យស្ទួន!";

  @override
  String get notFoundError => "រកមិនឃើញទិន្នន័យដែលអ្នកចង់ស្វែងរក!";

  @override
  String get authError => "មានបញ្ហាក្នុងការផ្ទៀងផ្ទាត់អត្តសញ្ញាណចូលប្រើប្រាស់គណនីរបស់អ្នក!";

  @override
  String get incorrectLoginCredential => "ឈ្នោះឬពាក្យសម្ងាត់មិនត្រឹមត្រូវទេ!";

  @override
  String get forbidden => "ប្រតិបត្តិការត្រូវបានហាមឃាត!";

  @override
  String get alreadyRegistered => "ឈ្មោះគណនីត្រូវបានប្រើប្រាស់រួចហើយ!";
}
