import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:iconsax/iconsax.dart';
import 'package:talent_lens_hub/features/courses/Screens/widgets/course_container.dart';
import 'package:talent_lens_hub/utils/constants/colors.dart';
import 'package:talent_lens_hub/utils/constants/sizes.dart';

import '../../../common/widgets/custom_shapes/containers/searchContainer.dart';
import '../../../common/widgets/texts/section_heading.dart';
import '../../../utils/helpers/helper_function.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  String selectedCourse = "All Courses";
  final List<String> courses = [
    "All Courses",
    "Programming",
    "Database",
    "Digital Marketing",
    "Machine Learning",
    "Web Development",
    "Mobile Development",
    "English Learning",
  ];

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunction.isDarkMode(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TSearchContainer(
                text: 'Search',
                icon: Iconsax.search_normal,
                showBackground: true,
                showBorder: true,
              ),
              /*Courses Category Chip Row*/
              Padding(
                padding: EdgeInsets.fromLTRB(TSizes.defaultSpace / 2, 0, 0, 0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: courses
                        .map((course) => _buildCourseButton(course))
                        .toList(),
                  ),
                ),
              ),
              /*In Progress Text*/
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                child: const TSectionHeading(
                  title: "In Progress",
                  showActionButton: true,
                  buttonTitle: "View All",
                  // onPressed: () {},
                  textColor: TColors.primaryColor,
                ),
              ),

              /*In Progress Items Row*/
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CourseContainer(
                      courseCategory: 'Programming',
                      courseTitle: 'Python for Beginners\n',
                      totalEnrolled: '758',
                      isEnrolled: true,
                      progress: 0.2,
                      enrolledBackgroundColor: TColors.primaryColor,
                    ),
                    CourseContainer(
                      courseCategory: 'Mobile Development',
                      courseTitle: 'Android App Development with Kotlin',
                      totalEnrolled: '698',
                      isEnrolled: true,
                      progress: 0.5,
                      enrolledBackgroundColor: TColors.primaryColor,
                    ),
                    CourseContainer(
                      courseCategory: 'Digital Marketing',
                      courseTitle: 'Social Media Marketing Strategies',
                      totalEnrolled: '145',
                      isEnrolled: true,
                      progress: 0.2,
                      enrolledBackgroundColor: TColors.primaryColor,
                    ),
                  ],
                ),
              ),
              SizedBox(height: TSizes.spaceBtwSections / 2),
              /*Category Wise Name*/
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                child: TSectionHeading(
                  title: selectedCourse,
                  showActionButton: true,
                  buttonTitle: "View All",
                  // onPressed: () {},
                  textColor: TColors.primaryColor,
                ),
              ),
              /*Category Wise Courses Load in onSelect*/
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CourseContainer(
                      courseCategory: 'Programming',
                      courseTitle: 'Python for Beginners\n',
                      totalEnrolled: '758',
                      isEnrolled: false,
                      unEnrolledCoursesColor: Colors.green,
                      // progress: 0.2,
                    ),
                    CourseContainer(
                      courseCategory: 'Mobile Development',
                      courseTitle: 'Android App Development with Kotlin',
                      totalEnrolled: '698',
                      isEnrolled: false,
                      unEnrolledCoursesColor: Colors.pink,
                      // progress: 0.5,
                    ),
                    CourseContainer(
                      courseCategory: 'Digital Marketing',
                      courseTitle: 'Social Media Marketing Strategies',
                      totalEnrolled: '145',
                      isEnrolled: false,
                      unEnrolledCoursesColor: Colors.orange,
                      // progress: 0.2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCourseButton(String course) {
    return Container(
      padding: EdgeInsets.all(TSizes.spaceBtwItems / 2),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor:
              selectedCourse == course ? TColors.primaryColor : TColors.grey,
          foregroundColor:
              selectedCourse == course ? Colors.white : TColors.black,
        ),
        onPressed: () {
          setState(() {
            selectedCourse = course;
          });
        },
        child: Text(course),
      ),
    );
  }
}
