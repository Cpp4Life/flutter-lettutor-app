class RegEx {
  static const _emailRegEx = r'^([a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6})*$';

  static bool isValidEmail(String email) {
    return RegExp(_emailRegEx).hasMatch(email);
  }
}
