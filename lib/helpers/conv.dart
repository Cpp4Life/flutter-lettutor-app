DateTime? strToDateTime(String? date) {
  if (date == null) {
    return null;
  }

  try {
    return DateTime.parse(date);
  } on FormatException {
    return null;
  }
}
