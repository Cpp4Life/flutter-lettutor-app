class User {
  late String id;
  String? email;
  String? name;
  String? avatar;
  String? country;
  String? phone;
  List<String>? roles;
  String? language;
  DateTime? birthday;
  late bool isActivated;
  List<Map<String, dynamic>>? walletInfo;
  List<String>? courses;
  String? requireNote;
  String? level;
  List<String>? learnTopics;
  List<String>? testPreparations;
  bool? isPhoneActivated;
  int? timezone;
  String? studySchedule;
  late bool canSendMessage;

  User({
    required this.id,
    this.email,
    this.name,
    this.avatar,
    this.country,
    this.phone,
    this.language,
    this.birthday,
    this.isActivated = false,
    this.requireNote,
    this.level,
    this.isPhoneActivated,
    this.timezone,
    this.studySchedule,
    this.canSendMessage = false,
  });

  User.fromJSON(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    avatar = json['avatar'];
    country = json['country'];
    phone = json['phone'];
    language = json['language'];
    birthday =
        json['birthday'] != null ? DateTime.parse(json['birthday']) : DateTime.now();
    isActivated = json['isActivated'];
    requireNote = json['requireNote'];
    level = json['level'];
    isPhoneActivated = json['isPhoneActivated'];
    timezone = json['timezone'];
    studySchedule = json['studySchedule'];
    canSendMessage = json['canSendMessage'];
  }
}
