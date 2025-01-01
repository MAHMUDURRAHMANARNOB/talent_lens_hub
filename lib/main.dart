import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talent_lens_hub/features/courses/Provider/EnrolledCoursesProvider.dart';
import 'package:talent_lens_hub/features/courses/Provider/LessonContentProvider.dart';
import 'package:talent_lens_hub/features/courses/Provider/LessonVideosProvider.dart';
import 'package:talent_lens_hub/utils/theme/theme.dart';

import 'app.dart';
import 'features/ToolsContent/providers/toolsResponseProvider.dart';
import 'features/courses/Provider/CourseContentProvider.dart';
import 'features/courses/Provider/CourseListProvider.dart';
import 'features/courses/Provider/TrainingCategoryProvider.dart';
import 'features/courses/Provider/VideoQuestionResponseProvider.dart';

// ---- Entry Point of Flutter App ----
void main() {
  // TODO: Add Widget Binding / Multi-Providers
  // TODO: init Local Storage
  // TODO: Await Native Splash
  // TODO: Initialize FireBase
  // TODO: Initialize Authentication

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TrainingCategoryProvider(),
        ),
        ChangeNotifierProvider(create: (_) => CourseContentProvider()),
        ChangeNotifierProvider(create: (_) => CourseListProvider()),
        ChangeNotifierProvider(create: (_) => LessonContentProvider()),
        ChangeNotifierProvider(create: (_) => LessonVideosProvider()),
        ChangeNotifierProvider(create: (_) => VideoQuestionResponseProvider()),
        ChangeNotifierProvider(create: (_) => EnrolledCoursesProvider()),
        // ChangeNotifierProvider(create: (_) => LessonProvider()),

        ChangeNotifierProvider(
          create: (context) => ToolsResponseProvider(),
        ),
      ],
      child: TalentLensHub(),
    ),
  );
}
