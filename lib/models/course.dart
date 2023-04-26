import '../helpers/index.dart';
import 'index.dart';

class Course {
  late String id;
  String? name;
  String? description;
  String? imageUrl;
  String? level;
  String? reason;
  String? purpose;
  String? otherDetails;
  int? defaultPrice;
  int? coursePrice;
  String? courseType;
  String? sectionType;
  bool? visible;
  String? displayOrder;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Topic>? topics;
  List<CourseCategory>? categories;
  List<Tutor>? users;

  Course({
    required this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.level,
    this.reason,
    this.purpose,
    this.otherDetails,
    this.defaultPrice,
    this.coursePrice,
    this.courseType,
    this.sectionType,
    this.visible,
    this.displayOrder,
    this.createdAt,
    this.updatedAt,
    this.topics,
    this.categories,
    this.users,
  });

  Course.fromJSON(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    level = json['level'];
    reason = json['reason'];
    purpose = json['purpose'];
    otherDetails = json['other_details'];
    defaultPrice = json['default_price'];
    coursePrice = json['course_price'];
    courseType = json['courseType'];
    sectionType = json['sectionType'];
    visible = json['visible'];
    displayOrder = json['displayOrder'];
    createdAt = strToDateTime(json['createdAt']);
    updatedAt = strToDateTime(json['updatedAt']);
    topics = json['topics'] == null
        ? []
        : Generic.fromJSON<List<Topic>, Topic>(json['topics']);
    categories = json['categories'] == null
        ? []
        : Generic.fromJSON<List<CourseCategory>, CourseCategory>(json['categories']);
    users =
        json['users'] == null ? [] : Generic.fromJSON<List<Tutor>, Tutor>(json['users']);
  }
}

class Topic {
  late String id;
  String? courseId;
  int? orderCourse;
  String? name;
  String? nameFile;
  int? numberOfPages;
  String? description;
  String? videoUrl;
  String? type;
  DateTime? createdAt;
  DateTime? updatedAt;

  Topic({
    required this.id,
    this.courseId,
    this.orderCourse,
    this.name,
    this.nameFile,
    this.numberOfPages,
    this.description,
    this.videoUrl,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  Topic.fromJSON(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['courseId'];
    orderCourse = json['orderCourse'];
    name = json['name'];
    nameFile = json['nameFile'];
    numberOfPages = json['numberOfPages'];
    description = json['description'];
    videoUrl = json['videoUrl'];
    type = json['type'];
    createdAt = strToDateTime(json['createdAt']);
    updatedAt = strToDateTime(json['updatedAt']);
  }
}

class CourseCategory {
  late String id;
  String? title;
  String? description;
  String? key;
  String? displayOrder;
  DateTime? createdAt;
  DateTime? updatedAt;

  CourseCategory({
    required this.id,
    this.title,
    this.description,
    this.key,
    this.displayOrder,
    this.createdAt,
    this.updatedAt,
  });

  CourseCategory.fromJSON(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    key = json['key'];
    displayOrder = json['displayOrder'];
    createdAt = strToDateTime(json['createdAt']);
    updatedAt = strToDateTime(json['updatedAt']);
  }
}
