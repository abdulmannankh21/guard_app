class JobModel {
  String hirerId;
  String guardId;
  String duration;
  String date;
  String description;
  bool pending;
  String guardName;
  String hirerName;
  double hours;
  double fee;
  String profileUrl;
  String weekDay;

  JobModel(
      {required this.weekDay,
        required this.profileUrl,
      required this.fee,
      required this.hours,
      required this.guardName,
      required this.hirerName,
      required this.hirerId,
      required this.guardId,
      required this.duration,
      required this.date,
      required this.description,
      required this.pending});

  static Map<String, dynamic> toMap(JobModel? job) {
    return {
      'fee':job?.fee,
      'weekDay' :job?.weekDay,
      'hirerName': job?.hirerName,
      'guardName': job?.guardName,
      'hours': job?.hours,
      'pending': job?.pending,
      'guardId': job?.guardId,
      'hirerId': job?.hirerId,
      'duration': job?.duration,
      'date': job?.date,
      'description': job?.description,
      'guardProfileUrl': job?.profileUrl
    };
  }

  factory JobModel.fromMap(Map<String, dynamic> map) {
    return JobModel(
      weekDay: map['weekDay']??'',
      profileUrl: map['profileUrl'] ?? "",
      fee: map['fee'] ?? 0.0,
      hours: map['hours'] ?? 0.0,
      hirerName: map['hirerName'] ?? '',
      guardName: map['guardName'] ?? "",
      pending: map['pending'] ?? true,
      hirerId: map['hirerId'] ?? '',
      guardId: map['guardID'] ?? '',
      duration: map['duration'] ?? '',
      date: map['date'] ?? '',
      description: map['description'] ?? "",
    );
  }
}
