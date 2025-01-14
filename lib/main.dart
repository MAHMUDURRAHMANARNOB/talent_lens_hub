import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shurjopay/utilities/functions.dart';
import 'package:talent_lens_hub/features/courses/CourseExam/Providers/CourseExamProvider.dart';
import 'package:talent_lens_hub/features/courses/Provider/CheckCourseEnrollmentProvider.dart';
import 'package:talent_lens_hub/features/courses/Provider/EnrolledCoursesProvider.dart';
import 'package:talent_lens_hub/features/courses/Provider/LessonContentProvider.dart';
import 'package:talent_lens_hub/features/courses/Provider/LessonQuestionAnswerProvider.dart';
import 'package:talent_lens_hub/features/courses/Provider/LessonVideosProvider.dart';
import 'package:talent_lens_hub/utils/theme/theme.dart';

import 'app.dart';
import 'features/ToolsContent/providers/toolsResponseProvider.dart';
import 'features/authentication/providers/UserStatesProvider.dart';
import 'features/authentication/providers/auth_provider.dart';
import 'features/courses/Provider/CourseContentProvider.dart';
import 'features/courses/Provider/CourseEnrollmentProvider.dart';
import 'features/courses/Provider/CourseListProvider.dart';
import 'features/courses/Provider/TrainingCategoryProvider.dart';
import 'features/courses/Provider/VideoQuestionResponseProvider.dart';
import 'features/courses/RecommandedCoursesForUser/recommendedCoursebyIdProvider.dart';
import 'features/subscriptions/providers/subscriptionPlanProvider.dart';

// ---- Entry Point of Flutter App ----
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // TODO: Add Widget Binding / Multi-Providers
  // TODO: init Local Storage
  // TODO: Await Native Splash
  // TODO: Initialize FireBase
  // TODO: Initialize Authentication
  initializeShurjopay(environment: "live");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TrainingCategoryProvider(),
        ),
        ChangeNotifierProvider(create: (_) => CourseContentProvider()),
        ChangeNotifierProvider(create: (_) => CourseListProvider()),
        ChangeNotifierProvider(create: (_) => LessonContentProvider()),
        ChangeNotifierProvider(create: (_) => LessonVideosProvider()),
        ChangeNotifierProvider(create: (_) => VideoQuestionResponseProvider()),
        ChangeNotifierProvider(create: (_) => EnrolledCoursesProvider()),
        ChangeNotifierProvider(create: (_) => SubscriptionProvider()),
        ChangeNotifierProvider(create: (_) => CheckCourseEnrollmentProvider()),
        ChangeNotifierProvider(create: (_) => CourseEnrollmentProvider()),
        ChangeNotifierProvider(create: (_) => LessonQuestionAnswerProvider()),
        ChangeNotifierProvider(create: (_) => CourseExamProvider()),
        ChangeNotifierProvider(create: (_) => RecommendedCourseByIdProvider()),

        // ChangeNotifierProvider(create: (_) => LessonProvider()),

        ChangeNotifierProvider(
          create: (context) => ToolsResponseProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserStatesProvider(),
        ),
      ],
      child: TalentLensHub(),
    ),
  );
}
