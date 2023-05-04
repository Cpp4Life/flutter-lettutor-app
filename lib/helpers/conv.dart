DateTime? strToDateTime(String? date) {
  try {
    return date == null ? null : DateTime.parse(date);
  } on FormatException {
    return null;
  }
}
