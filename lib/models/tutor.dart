import 'package:uuid/uuid.dart';

import '../helpers/index.dart';
import 'index.dart';

class Tutor {
  late String id;
  String? level;
  String? email;
  String? google;
  String? facebook;
  String? apple;
  String? avatar;
  String? name;
  String? country;
  String? phone;
  String? language;
  String? birthday;
  bool? requestPassword;
  bool? isActivated;
  bool? isPhoneActivated;
  String? requireNote;
  int? timezone;
  String? phoneAuth;
  bool? isPhoneAuthActivated;
  String? studySchedule;
  bool? canSendMessage;
  bool? isPublicRecord;
  String? caredByStaffId;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  String? studentGroupId;
  List<Feedback>? feedbacks;
  String? userId;
  String? video;
  String? bio;
  String? education;
  String? experience;
  String? profession;
  String? accent;
  String? targetStudent;
  String? interests;
  String? languages;
  String? specialties;
  String? resume;
  double? rating;
  bool? isNative;
  int? price;
  bool? isOnline;
  User? user;
  bool? isFavorite;
  num? avgRating;
  int? totalFeedback;

  Tutor({
    required this.id,
    this.level,
    this.email,
    this.google,
    this.facebook,
    this.apple,
    this.avatar,
    this.name,
    this.country,
    this.phone,
    this.language,
    this.birthday,
    this.requestPassword = false,
    this.isActivated = false,
    this.isPhoneActivated = false,
    this.requireNote,
    this.timezone,
    this.phoneAuth,
    this.isPhoneAuthActivated = false,
    this.studySchedule,
    this.canSendMessage = false,
    this.isPublicRecord = false,
    this.caredByStaffId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.studentGroupId,
    this.feedbacks,
    this.userId,
    this.video,
    this.bio,
    this.education,
    this.experience,
    this.profession,
    this.accent,
    this.targetStudent,
    this.interests,
    this.languages,
    this.specialties,
    this.resume,
    this.rating,
    this.isNative = false,
    this.price,
    this.isOnline = false,
    this.user,
    this.isFavorite = false,
    this.avgRating,
    this.totalFeedback,
  });

  Tutor.fromJSON(Map<String, dynamic> json) {
    id = json['id'] ?? const Uuid().v4();
    level = json['level'];
    email = json['email'];
    google = json['google'];
    facebook = json['facebook'];
    apple = json['apple'];
    avatar = json['avatar'];
    name = json['name'];
    country = json['country'];
    phone = json['phone'];
    language = json['language'];
    birthday = json['birthday'];
    requestPassword = json['requestPassword'];
    isActivated = json['isActivated'];
    isPhoneActivated = json['isPhoneActivated'];
    requireNote = json['requireNote'];
    timezone = json['timezone'];
    phoneAuth = json['phoneAuth'];
    isPhoneAuthActivated = json['isPhoneAuthActivated'];
    studySchedule = json['studySchedule'];
    canSendMessage = json['canSendMessage'];
    isPublicRecord = json['isPublicRecord'];
    caredByStaffId = json['caredByStaffId'];
    createdAt = strToDateTime(json['createdAt']);
    updatedAt = strToDateTime(json['updatedAt']);
    deletedAt = strToDateTime(json['deletedAt']);
    studentGroupId = json['studentGroupId'];
    feedbacks = json['feedbacks'] == null
        ? []
        : Generic.fromJSON<List<Feedback>, Feedback>(json['feedbacks']);
    userId = json['userId'];
    video = json['video'];
    bio = json['bio'];
    education = json['education'];
    experience = json['experience'];
    profession = json['profession'];
    accent = json['accent'];
    targetStudent = json['targetStudent'];
    interests = json['interests'];
    languages = json['languages'];
    specialties = json['specialties'];
    resume = json['resume'];
    rating = json['rating'];
    isNative = json['isNative'];
    price = json['price'];
    isOnline = json['isOnline'];
    user = json['User'] == null ? null : Generic.fromJSON<User, void>(json['User']);
    isFavorite = json['isFavorite'] ?? false;
    avgRating = json['avgRating'];
    totalFeedback = json['totalFeedback'];
  }

  @override
  bool operator ==(other) {
    return (other is Tutor) && (other.id == id);
  }

  @override
  int get hashCode => id.hashCode;
}

// Only use for home screen to show favorite tutors
class FavoriteTutor {
  late String id;
  String? firstId;
  String? secondId;
  DateTime? createdAt;
  DateTime? updatedAt;
  Tutor? secondInfo;
  Tutor? tutorInfo;

  FavoriteTutor.fromJSON(Map<String, dynamic> json) {
    id = json['id'];
    firstId = json['firstId'];
    secondId = json['secondId'];
    createdAt = strToDateTime(json['createdAt']);
    updatedAt = strToDateTime(json['updatedAt']);
    secondInfo = json['secondInfo'] == null
        ? null
        : Generic.fromJSON<Tutor, void>(json['secondInfo']);
    tutorInfo = json['secondInfo'] == null || json['secondInfo']['tutorInfo'] == null
        ? null
        : Generic.fromJSON<Tutor, void>(json['secondInfo']['tutorInfo']);
  }
}
