import '../helpers/index.dart';

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
