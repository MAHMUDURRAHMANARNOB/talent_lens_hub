class UserStatsDataModel {
  final int? availableComments;
  final int? availableTickets;
  final int? availableCourses;
  final int? enrolledCourses;

  UserStatsDataModel({
    required this.availableComments,
    required this.availableTickets,
    required this.availableCourses,
    required this.enrolledCourses,
  });

  // Factory constructor for creating an instance from a JSON map
  factory UserStatsDataModel.fromJson(Map<String, dynamic> json) {
    return UserStatsDataModel(
      availableComments: json['AvailableComments'],
      availableTickets: json['AvailableTickets'],
      availableCourses: json['AvailableCourses'],
      enrolledCourses: json['EnrolledCourses'],
    );
  }

  // Method for converting an instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'AvailableComments': availableComments,
      'AvailableTickets': availableTickets,
      'AvailableCourses': availableCourses,
      'EnrolledCourses': enrolledCourses,
    };
  }
}
