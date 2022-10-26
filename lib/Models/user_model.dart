class UserModel {
  final String firstName;
  final String profilePicUrl;
  final String summary;
  final String workExperience;
  dynamic job;
  final String lastName;
  final String cvUrl;

  UserModel(
      {required this.cvUrl,
        required this.firstName,
      required this.profilePicUrl,
      required this.summary,
      required this.job,
      required this.lastName,
      required this.workExperience});

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'profilePicUrl': profilePicUrl,
      'secondName': lastName,
      'summary': summary,
      'workExperience': workExperience,
      'job': job
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        cvUrl: map['cvUrl'],
        firstName: map['firstName'] ?? '',
        lastName: map['secondName'] ?? '',
        profilePicUrl: map['profilePicUrl'] ?? '',
        summary: map['summary'] ?? '',
        workExperience: map['workExperience'] ?? '',
        job: map['job'] ?? '');
  }
}
