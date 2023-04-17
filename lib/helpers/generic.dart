import '../models/index.dart';

class Generic {
  // * If T is a List, K is the subtype of the list.
  static T fromJSON<T, K>(dynamic json) {
    try {
      if (json is Iterable) {
        return _fromJSONList<K>(json as List<dynamic>) as T;
      }
      if (T == Feedback) {
        return Feedback.fromJSON(json) as T;
      }
      if (T == Tutor) {
        return Tutor.fromJSON(json) as T;
      }
      if (T == User) {
        return User.fromJSON(json) as T;
      }
      if (T == Token) {
        return Token.fromJSON(json) as T;
      }
      if (T == LearnTopic) {
        return LearnTopic.fromJSON(json) as T;
      }
      if (T == TestPreparation) {
        return TestPreparation.fromJSON(json) as T;
      }
      if (T == UserCourse) {
        return UserCourse.fromJSON(json) as T;
      }
      if (T == TutorCourse) {
        return TutorCourse.fromJSON(json) as T;
      }
      return json;
    } catch (error, stackTrace) {
      rethrow;
    }
  }

  static List<K> _fromJSONList<K>(List<dynamic> jsonList) {
    return jsonList.map<K>((dynamic json) => fromJSON<K, void>(json)).toList();
  }
}
