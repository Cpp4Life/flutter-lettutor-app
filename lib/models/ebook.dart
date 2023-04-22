import '../helpers/index.dart';
import 'index.dart';

class Ebook {
  late String id;
  String? name;
  String? description;
  String? imageUrl;
  String? level;
  bool? visible;
  String? fileUrl;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? isPrivate;
  String? createdBy;
  List<CourseCategory>? categories;

  Ebook({
    required this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.level,
    this.visible,
    this.fileUrl,
    this.createdAt,
    this.updatedAt,
    this.isPrivate,
    this.createdBy,
    this.categories,
  });

  Ebook.fromJSON(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    level = json['level'];
    visible = json['visible'];
    fileUrl = json['fileUrl'];
    createdAt = strToDateTime(json['createdAt']);
    updatedAt = strToDateTime(json['updatedAt']);
    isPrivate = json['isPrivate'];
    createdBy = json['createdBy'];
    categories =
        Generic.fromJSON<List<CourseCategory>, CourseCategory>(json['categories']);
  }
}
