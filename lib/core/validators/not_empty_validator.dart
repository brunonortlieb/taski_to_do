class NotEmptyValidator {
  String? validate(String? text) {
    if (text == null || text.isEmpty) return 'Mandatory field.';
    return null;
  }
}
