class TextFieldValidator {
  static String? Function(String?) emptyValidator() {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return 'Introdueix el teu valor';
      }
      return null;
    };
  }
}
