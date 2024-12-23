class LessonContentDataModel {
  final int id;
  final int courseId;
  final String lessonTitle;
  final String isChapter;
  final int ansCount;
  final int seqNo;
  final String isActive;
  final int chapterIndex;
  final String isProcessed;
  final String isAssignment;
  final String isFree;
  final int lessonId;
  final int courseID;
  final String ansType;
  final String? textAns;
  final String? videoSource;
  final String? linkText;
  final int? likeCount;
  final int? dislikeCount;
  final int inappropriate;
  final int audioSegments;
  final String? audioLink;
  final String isQuestionGen;

  LessonContentDataModel({
    required this.id,
    required this.courseId,
    required this.lessonTitle,
    required this.isChapter,
    required this.ansCount,
    required this.seqNo,
    required this.isActive,
    required this.chapterIndex,
    required this.isProcessed,
    required this.isAssignment,
    required this.isFree,
    required this.lessonId,
    required this.courseID,
    required this.ansType,
    required this.textAns,
    this.videoSource,
    this.linkText,
    this.likeCount,
    this.dislikeCount,
    required this.inappropriate,
    required this.audioSegments,
    this.audioLink,
    required this.isQuestionGen,
  });

  factory LessonContentDataModel.fromJson(Map<String, dynamic> json) {
    return LessonContentDataModel(
      id: json['id'],
      courseId: json['Courseid'],
      lessonTitle: json['Lessontitle'],
      isChapter: json['isChapter'],
      ansCount: json['Anscount'],
      seqNo: json['SeqNo'],
      isActive: json['isactive'],
      chapterIndex: json['chapterIndex'],
      isProcessed: json['isProcessed'],
      isAssignment: json['isassigment'],
      isFree: json['isFree'],
      lessonId: json['lessonid'],
      courseID: json['courseID'],
      ansType: json['Anstype'],
      textAns: json['TextAns'],
      videoSource: json['VideoSource'],
      linkText: json['linktext'],
      likeCount: json['likecount'],
      dislikeCount: json['dislikecount'],
      inappropriate: json['Inappropriate'],
      audioSegments: json['Audio_segments'],
      audioLink: json['audio_link'],
      isQuestionGen: json['isQuestionGen'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'Courseid': courseId,
      'Lessontitle': lessonTitle,
      'isChapter': isChapter,
      'Anscount': ansCount,
      'SeqNo': seqNo,
      'isactive': isActive,
      'chapterIndex': chapterIndex,
      'isProcessed': isProcessed,
      'isassigment': isAssignment,
      'isFree': isFree,
      'lessonid': lessonId,
      'courseID': courseID,
      'Anstype': ansType,
      'TextAns': textAns,
      'VideoSource': videoSource,
      'linktext': linkText,
      'likecount': likeCount,
      'dislikecount': dislikeCount,
      'Inappropriate': inappropriate,
      'Audio_segments': audioSegments,
      'audio_link': audioLink,
      'isQuestionGen': isQuestionGen,
    };
  }
}
