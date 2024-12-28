class AppStrings {
  const AppStrings._();

  static const List<String> dayOfWeeks = [
    'ច័ន្ទ',
    'អង្គារ',
    'ពុធ',
    'ព្រហស្បតិ៍',
    'សុក្រ',
    'សៅរ៍',
    'អាទិត្យ',
  ];

  static const String create = "បង្កើត";
  static const String update = "កែប្រែ";
  static const String delete = "លុប";
  static const String list = "បញ្ជី";
  static const String createNew = "$createថ្មី";
  static const String save = "រក្សាទុក";
  static const String cancel = "បោះបង់";

  static verifyDelete(String verifyText) {
    return "សូមបំពេញ [$verifyText] ក្នុងប្រអប់ដើម្បីបញ្ជាក់ថាលុប";
  }
}
