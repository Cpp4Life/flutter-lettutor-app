import '../helpers/index.dart';

class LearnTopic {
  late int id;
  String? key;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;

  LearnTopic({
    required this.id,
    this.key,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  LearnTopic.fromJSON(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    name = json['name'];
    createdAt = strToDateTime(json['createdAt']);
    updatedAt = strToDateTime(json['updatedAt']);
  }
}
