import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../../../../common/widgets/custom_shapes/containers/circular_container.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../Provider/CourseContentProvider.dart';
import 'LessonBoardScreen.dart';

class LessonListScreen extends StatefulWidget {
  final String courseTitle;
  final int courseCategoryId;

  const LessonListScreen(
      {super.key, required this.courseTitle, required this.courseCategoryId});

  @override
  State<LessonListScreen> createState() => _LessonListScreenState();
}

class _LessonListScreenState extends State<LessonListScreen> {
  final CourseContentProvider courseContentProvider = CourseContentProvider();

  @override
  Widget build(BuildContext context) {
    /*return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.courseTitle,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "12th Grade",
                    style: TextStyle(
                      color: TColors.darkGrey,
                    ),
                  ),
                  SizedBox(
                    height: TSizes.md,
                  ),
                  Container(
                    child: const Text("Lessons: "),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 10, // 10 items in the list
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LessonBoardScreen(
                                lessonTitle: "Lesson ${index + 1}",
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          padding: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 6,
                                offset: Offset(0, 1),
                                // blurStyle: BlurStyle.inner
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: TColors.primaryColor.withOpacity(0.25),
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                                child: Icon(
                                  Icons.chrome_reader_mode_outlined,
                                  // Replace with your desired icon
                                  color: TColors.primaryColor,
                                ),
                              ),
                              SizedBox(width: 16.0),
                              Text(
                                'Lesson ${index + 1}',
                                // Dynamically set the text
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );*/
    return Scaffold(
      appBar: AppBar(title: Text('Course Content')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<void>(
              future: courseContentProvider
                  .fetchCourseContent(widget.courseCategoryId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: SpinKitCircle(color: TColors.primaryColor));
                } else if (snapshot.hasError) {
                  return Center(child: Text("An error occurred!"));
                } else {
                  final courseContent = courseContentProvider.courses;
                  final lessons = courseContentProvider.lessons;
                  // final chapters = courseContentProvider.chapters;
                  // final regularLessons = courseContentProvider.regularLessons;
                  final chapterLessonsMap =
                      courseContentProvider.chapterLessonsMap;

                  if (lessons.isEmpty && courseContent.isEmpty) {
                    return Center(child: Text("No Lesson available."));
                  }
                  print(chapterLessonsMap.length);
                  return Padding(
                    padding: const EdgeInsets.all(TSizes.defaultSpace / 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            courseContent[0].courseName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            // border: Border.all(color: TColors.primaryColor),
                          ),
                          child: Text(
                            courseContent[0].courseDescription,
                            // textAlign: TextAlign.center,
                          ),
                        ),
                        Text(
                          "Chapters:",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Divider(
                          color: TColors.secondaryColor,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: lessons.length,
                          itemBuilder: (context, index) {
                            final lesson = lessons[index];
                            // final chapter = lessons[index];

                            return GestureDetector(
                              onTap: () async {
                                print("chapterid ${lesson.id}");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LessonBoardScreen(
                                          lessonTitle: lesson.lessonTitle,
                                          lessonId: lesson.id)),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: lesson.isFree == 'Y'
                                        ? TColors.success.withOpacity(0.1)
                                        : TColors.info.withOpacity(0.1)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(10.0),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(64),
                                              color: TColors.white,
                                            ),
                                            child: Icon(
                                              Iconsax.book,
                                              size: 20.0,
                                              color: lesson.isFree == 'Y'
                                                  ? TColors.success
                                                  : TColors.info,
                                            ),
                                          ),
                                          SizedBox(width: 10.0),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  lesson.lessonTitle,
                                                  textAlign: TextAlign.start,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5.0,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 5.0),
                                                  decoration: BoxDecoration(
                                                    color: lesson.isFree == 'Y'
                                                        ? TColors.success
                                                        : TColors.info,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      6.0,
                                                    ),
                                                  ),
                                                  child: Text(
                                                    lesson.isFree == 'Y'
                                                        ? "Free"
                                                        : "Member",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 10.0),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            color: lesson.isFree == 'Y'
                                                ? TColors.success
                                                : TColors.info,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: chapterLessonsMap.length,
                          itemBuilder: (context, index) {
                            final chapterIndex =
                                chapterLessonsMap.keys.elementAt(index);
                            final lessons = chapterLessonsMap[chapterIndex]!;

                            final chapterTitle = lessons.first.lessonTitle;

                            return ExpansionTile(
                              title: Text(
                                chapterTitle,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              children: lessons.map((lesson) {
                                return ListTile(
                                  title: Text(lesson.lessonTitle),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LessonBoardScreen(
                                          lessonTitle: lesson.lessonTitle,
                                          lessonId: lesson.id,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
