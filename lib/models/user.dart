import 'package:lettutor_app/models/index.dart';

import '../helpers/index.dart';

class User {
  late String id;
  String? email;
  String? name;
  String? avatar;
  String? country;
  String? phone;
  List<String>? roles;
  String? language;
  String? birthday;
  bool? isActivated;
  List<Map<String, dynamic>>? walletInfo;
  String? requireNote;
  String? level;
  List<LearnTopic>? learnTopics;
  List<TestPreparation>? testPreparations;
  bool? isPhoneActivated;
  int? timezone;
  String? studySchedule;
  bool? canSendMessage;
  bool? isPublicRecord;
  bool? caredByStaffId;
  String? studentGroupId;
  List<UserCourse>? courses;

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
    this.learnTopics,
    this.testPreparations,
    this.isPhoneActivated,
    this.timezone,
    this.studySchedule,
    this.canSendMessage = false,
    this.isPublicRecord = false,
    this.caredByStaffId,
    this.studentGroupId,
    this.courses,
  });

  User.fromJSON(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    avatar = json['avatar'];
    country = json['country'];
    phone = json['phone'];
    language = json['language'];
    birthday = json['birthday'];
    isActivated = json['isActivated'];
    requireNote = json['requireNote'];
    level = json['level'];
    learnTopics = json['learnTopics'] == null
        ? []
        : Generic.fromJSON<List<LearnTopic>, LearnTopic>(
            json['learnTopics'],
          );
    testPreparations = json['testPreparations'] == null
        ? []
        : Generic.fromJSON<List<TestPreparation>, TestPreparation>(
            json['testPreparations'],
          );
    isPhoneActivated = json['isPhoneActivated'];
    timezone = json['timezone'];
    studySchedule = json['studySchedule'];
    canSendMessage = json['canSendMessage'];
    isPublicRecord = json['isPublicRecord'];
    caredByStaffId = json['caredByStaffId'];
    studentGroupId = json['studentGroupId'];
    courses = json['courses'] == null
        ? []
        : Generic.fromJSON<List<UserCourse>, UserCourse>(json['courses']);
  }
}

class UserCourse {
  late String id;
  String? name;
  TutorCourse? tutorCourse;

  UserCourse.fromJSON(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    tutorCourse = Generic.fromJSON<TutorCourse, void>(json['TutorCourse']);
  }
}

class TutorCourse {
  String? userId;
  String? courseId;
  DateTime? createdAt;
  DateTime? updatedAt;

  TutorCourse.fromJSON(Map<String, dynamic> json) {
    userId = json['UserId'];
    courseId = json['CourseId'];
    createdAt = strToDateTime(json['createdAt']);
    updatedAt = strToDateTime(json['updatedAt']);
  }
}
