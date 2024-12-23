class LessonVideosDataModel {
  final int id;
  final int lessonId;
  final String videoId;
  final String videoUrl;
  final DateTime dateCreated;
  final int? likeCount;
  final int? dislikeCount;
  final int? reportedCount;
  final String isProcessed;
  final String videoTitle;
  final String videoDuration;

  LessonVideosDataModel({
    required this.id,
    required this.lessonId,
    required this.videoId,
    required this.videoUrl,
    required this.dateCreated,
    this.likeCount,
    this.dislikeCount,
    this.reportedCount,
    required this.isProcessed,
    required this.videoTitle,
    required this.videoDuration,
  });

  factory LessonVideosDataModel.fromJson(Map<String, dynamic> json) {
    return LessonVideosDataModel(
      id: json['id'] as int,
      lessonId: json['lessonid'] as int,
      videoId: json['videoid'] as String,
      videoUrl: json['videourl'] as String,
      dateCreated: DateTime.parse(json['datecreated'] as String),
      likeCount: json['likecount'] as int?,
      dislikeCount: json['dislikecount'] as int?,
      reportedCount: json['reportedcount'] as int?,
      isProcessed: json['isprocessed'] as String,
      videoTitle: json['videoTitle'] as String,
      videoDuration: json['videoduration'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lessonid': lessonId,
      'videoid': videoId,
      'videourl': videoUrl,
      'datecreated': dateCreated.toIso8601String(),
      'likecount': likeCount,
      'dislikecount': dislikeCount,
      'reportedcount': reportedCount,
      'isprocessed': isProcessed,
      'videoTitle': videoTitle,
      'videoduration': videoDuration,
    };
  }
}
