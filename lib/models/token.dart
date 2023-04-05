class Token {
  late String? token;
  late DateTime? expires;

  Token({
    required this.token,
    required this.expires,
  });

  Token.fromJSON(Map<String, dynamic> json) {
    token = json['token'];
    expires = json['expires'] != null ? DateTime.parse(json['expires']) : null;
  }
}
