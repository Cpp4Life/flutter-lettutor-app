import '../helpers/index.dart';

class TestPreparation {
  late int id;
  String? key;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;

  TestPreparation({
    required this.id,
    this.key,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  TestPreparation.fromJSON(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    name = json['name'];
    createdAt = strToDateTime(json['createdAt']);
    updatedAt = strToDateTime(json['updatedAt']);
  }
}
