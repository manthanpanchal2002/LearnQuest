class CoursesModel {
  final String courseCreator;
  final String courseImage;
  final bool isPublished;
  final DateTime updatedAt;
  final String courseName;
  final String courseDescription;
  final String courseUid;
  final double coursePrice;
  final DateTime createdAt;

  CoursesModel({
    required this.courseCreator,
    required this.courseImage,
    required this.isPublished,
    required this.updatedAt,
    required this.courseName,
    required this.courseDescription,
    required this.courseUid,
    required this.coursePrice,
    required this.createdAt,
  });

  factory CoursesModel.fromJson(Map<String, dynamic> json) {
    return CoursesModel(
      courseCreator: json['course_creator'],
      courseImage: json['course_image'],
      isPublished: json['is_published'],
      updatedAt: DateTime.parse(json['updated_at']),
      courseName: json['course_name'],
      courseDescription: json['course_description'],
      courseUid: json['course_uid'],
      coursePrice: json['course_price'].toDouble(),
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
