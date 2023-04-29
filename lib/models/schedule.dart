import '../helpers/index.dart';

class Schedule {
  late String id;
  String? tutorId;
  String? startTime;
  String? endTime;
  int? startTimestamp;
  int? endTimestamp;
  DateTime? createdAt;
  bool? isBooked;
  List<ScheduleDetails>? scheduleDetails;

  Schedule({
    required this.id,
    this.tutorId,
    this.startTime,
    this.endTime,
    this.startTimestamp,
    this.endTimestamp,
    this.createdAt,
    this.isBooked,
    this.scheduleDetails,
  });

  Schedule.fromJSON(Map<String, dynamic> json) {
    id = json['id'];
    tutorId = json['tutorId'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    startTimestamp = json['startTimestamp'];
    endTimestamp = json['endTimestamp'];
    createdAt = strToDateTime(json['createdAt']);
    isBooked = json['isBooked'];
    scheduleDetails = json['scheduleDetails'] == null
        ? []
        : Generic.fromJSON<List<ScheduleDetails>, ScheduleDetails>(
            json['scheduleDetails'],
          );
  }
}

class ScheduleDetails {
  int? startPeriodTimestamp;
  int? endPeriodTimestamp;
  late String id;
  String? scheduleId;
  String? startPeriod;
  String? endPeriod;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<BookingInfo>? bookingInfo;
  bool? isBooked;

  ScheduleDetails.fromJSON(Map<String, dynamic> json) {
    startPeriodTimestamp = json['startPeriodTimestamp'];
    endPeriodTimestamp = json['endPeriodTimestamp'];
    id = json['id'];
    scheduleId = json['scheduleId'];
    startPeriod = json['startPeriod'];
    endPeriod = json['endPeriod'];
    createdAt = strToDateTime(json['createdAt']);
    updatedAt = strToDateTime(json['updatedAt']);
    bookingInfo = json['bookingInfo'] == null
        ? []
        : Generic.fromJSON<List<BookingInfo>, BookingInfo>(json['bookingInfo']);
    isBooked = json['isBooked'];
  }
}

class BookingInfo {
  int? createdAtTimeStamp;
  int? updatedAtTimeStamp;
  late String id;
  String? userId;
  String? scheduleDetailId;
  String? tutorMeetingLink;
  String? studentMeetingLink;
  String? studentRequest;
  String? tutorReview;
  int? scoreByTutor;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? recordUrl;
  int? cancelReasonId;
  int? lessonPlanId;
  String? cancelNote;
  String? calendarId;
  bool? isDeleted;

  BookingInfo.fromJSON(Map<String, dynamic> json) {
    createdAtTimeStamp = json['createdAtTimeStamp'];
    updatedAtTimeStamp = json['updatedAtTimeStamp'];
    id = json['id'];
    userId = json['userId'];
    scheduleDetailId = json['scheduleDetailId'];
    tutorMeetingLink = json['tutorMeetingLink'];
    studentMeetingLink = json['studentMeetingLink'];
    studentRequest = json['studentRequest'];
    tutorReview = json['tutorReview'];
    scoreByTutor = json['scoreByTutor'];
    createdAt = strToDateTime(json['createdAt']);
    updatedAt = strToDateTime(json['updatedAt']);
    recordUrl = json['recordUrl'];
    cancelReasonId = json['cancelReasonId'];
    lessonPlanId = json['lessonPlanId'];
    cancelNote = json['cancelNote'];
    calendarId = json['calendarId'];
    isDeleted = json['isDeleted'];
  }
}
