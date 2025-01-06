import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconsax/iconsax.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:talent_lens_hub/features/authentication/providers/auth_provider.dart';
import 'package:talent_lens_hub/features/courses/CourseContent/screens/LessonListScreen.dart';
import 'package:talent_lens_hub/features/courses/DataModel/CourseListDataModel.dart';
import 'package:talent_lens_hub/features/courses/DataModel/EnrolledCoursesDataModel.dart';
import 'package:talent_lens_hub/features/courses/Provider/CourseListProvider.dart';
import 'package:talent_lens_hub/features/courses/Provider/EnrolledCoursesProvider.dart';
import 'package:talent_lens_hub/features/courses/Screens/widgets/RandomNumberGenerator.dart';
import 'package:talent_lens_hub/features/courses/Screens/widgets/course_container.dart';
import 'package:talent_lens_hub/utils/constants/colors.dart';
import 'package:talent_lens_hub/utils/constants/sizes.dart';

import '../../../common/widgets/custom_shapes/containers/searchContainer.dart';
import '../../../common/widgets/texts/section_heading.dart';
import '../../../utils/helpers/helper_function.dart';
import '../DataModel/CourseContentDataModel.dart';
import '../DataModel/TrainingCategoryDataModel.dart';
import '../Provider/CourseContentProvider.dart';
import '../Provider/TrainingCategoryProvider.dart';
import 'enrolledCourses.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  String? selectedCategory;
  int? selectedCategoryID;
  late TrainingCategoryProvider trainingCategoryProvider =
      TrainingCategoryProvider();
  late CourseListProvider courseListProvider = CourseListProvider();
  late EnrolledCoursesProvider enrolledCoursesProvider =
      EnrolledCoursesProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    trainingCategoryProvider =
        Provider.of<TrainingCategoryProvider>(context, listen: false);
  }

  late int userId;

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunction.isDarkMode(context);
    userId = Provider.of<AuthProvider>(context, listen: false).user!.id;

    courseListProvider = Provider.of<CourseListProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Search Bar
            /*Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: SearchBar(
                backgroundColor: darkMode
                    ? WidgetStatePropertyAll<Color?>((TColors.dark))
                    : WidgetStatePropertyAll<Color?>((TColors.light)),
                hintText: "Search Course",
                hintStyle: WidgetStatePropertyAll<TextStyle?>(
                    Theme.of(context).textTheme.bodySmall),
                padding: const WidgetStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: TSizes.md)),
                onTap: () {},
                onChanged: (_) {},
                leading: const Icon(Iconsax.search_normal),
                trailing: [
                  Tooltip(
                    message: 'Filter your search',
                    child: IconButton(
                      isSelected: darkMode,
                      onPressed: () {},
                      icon: const Icon(Iconsax.filter),
                    ),
                  ),
                ],
              ),
            ),*/

            // Courses Category Chip Row
            _courseCategoryList(),

            // In Progress Text
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
              child: TSectionHeading(
                title: "In Progress",
                showActionButton: true,
                buttonTitle: "View All",
                textColor: TColors.primaryColor,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EnrolledCourses(),
                    ),
                  );
                },
              ),
            ),

            // In Progress Items Row
            _enrolledCourseList(),

            SizedBox(height: TSizes.spaceBtwSections / 2),

            // Category Wise Name
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
              child: selectedCategory == null
                  ? Center(
                      child: Text(
                        "Select a category to see all courses",
                      ),
                    )
                  : TSectionHeading(
                      title: selectedCategory ?? "All Courses",
                      showActionButton: true,
                      buttonTitle: "View All",
                      textColor: TColors.primaryColor,
                    ),
            ),

            // Render course list
            ...courseListProvider.courses.map((course) {
              return Container(
                // color: Colors.white,
                decoration: BoxDecoration(
                  color: course.id.isEven
                      ? TColors.accent.withOpacity(0.1)
                      : TColors.secondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
                margin: const EdgeInsets.symmetric(
                  horizontal: TSizes.defaultSpace / 2,
                  vertical: TSizes.spaceBtwItems / 2,
                ),
                child: ListTile(
                  title: Text(
                    course.courseName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    children: [
                      Text(
                        course.courseDescription,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Total Enrolled: ",
                                style: TextStyle(),
                              ),
                              Text(
                                // RandomNumberGenerator.generateRandomNumber(),
                                course.totalStudents.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: course.id.isEven
                                      ? TColors.info
                                      : TColors.secondaryColor,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                color: course.id.isEven
                                    ? TColors.info
                                    : TColors.secondaryColor,
                                borderRadius: BorderRadius.circular(6.0)),
                            child: Text(
                              "Enroll Now",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  /*leading: course.imgPath != null
                      ? Image.network(course.imgPath!)
                      : const Icon(Iconsax.book, color: TColors.primaryColor),*/
                  /*trailing: const Icon(Iconsax.arrow_circle_right,
                      size: 24, color: TColors.primaryColor),*/
                  onTap: () {
                    // Handle course item click
                    if (kDebugMode) {
                      print(course.id);
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LessonListScreen(
                          courseTitle: course.courseName,
                          courseCategoryId: course.id,
                        ),
                      ),
                    );
                  },
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _courseCategoryList() {
    return FutureBuilder<void>(
      future: trainingCategoryProvider.fetchTrainingCategories(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: SpinKitWave(
            color: TColors.primaryColor,
            size: 20,
          ));
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.done) {
          final provider = Provider.of<TrainingCategoryProvider>(context);

          // If there's an error message in the provider, display it
          if (provider.errorMessage != null) {
            return Center(child: Text(provider.errorMessage!));
          }

          // If no categories are fetched, display a message
          if (provider.categories.isEmpty) {
            return Center(child: Text('No categories available.'));
          }

          // Return a horizontal list of chips in 2 rows
          int halfLength = (provider.categories.length / 2).ceil();
          List<dynamic> firstRowCategories =
              provider.categories.sublist(0, halfLength);
          List<dynamic> secondRowCategories =
              provider.categories.sublist(halfLength);

          return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: firstRowCategories
                        .map((category) => _buildCategoryChip(category))
                        .toList(),
                  ),
                  Row(
                    children: secondRowCategories
                        .map((category) => _buildCategoryChip(category))
                        .toList(),
                  ),
                ],
              ));
        }

        return Container(); // Empty container for other states
      },
    );
  }

  Widget _enrolledCourseList() {
    return FutureBuilder(
      future: enrolledCoursesProvider.getEnrolledCourses(userId.toString()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: SpinKitWave(
            color: TColors.primaryColor,
            size: 20,
          ));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (enrolledCoursesProvider.enrolledCourses.isEmpty) {
          return Center(child: Text('No Courses Available at this moment'));
        } else {
          return Container(
            width: double.infinity,
            height: 150,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                final EnrolledCoursesDataModel course =
                    enrolledCoursesProvider.enrolledCourses[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LessonListScreen(
                          courseTitle: course.courseName,
                          courseCategoryId: course.id,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      // color: TColors.success.withOpacity(0.2),
                      border: Border.all(color: TColors.primaryColor),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            course.courseName,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            decoration: BoxDecoration(
                              color: TColors.primaryColor,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(8.0),
                                bottomRight: Radius.circular(8.0),
                              ),
                            ),
                            child: Text(
                              "Continue",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }

  Widget _buildCategoryChip(TrainingCategoryDataModel category) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          TSizes.spaceBtwItems / 2, 0, TSizes.spaceBtwItems / 2, 0),
      child: TextButton(
        style: ElevatedButton.styleFrom(
          side: BorderSide(color: TColors.primaryColor),
          backgroundColor: selectedCategory == category.name
              ? TColors.primaryColor
              : Colors.white,
          foregroundColor: selectedCategory == category.name
              ? Colors.white
              : TColors.primaryColor,
        ),
        onPressed: () {
          if (selectedCategory != category.name) {
            setState(() {
              selectedCategory = category.name;
              selectedCategoryID = category.id;
            });
            print("$selectedCategory -- $selectedCategoryID");

            /*isFetching = true;
            _courseList(selectedCategoryID!).then((_) {
              setState(() {
                isFetching = false;
              });
            });*/
            // Fetch the courses for the selected category
            context.read<CourseListProvider>().fetchCoursesById(category.id);
          }
        },
        child: Text(
          category.name,
          style: TextStyle(
            fontWeight: selectedCategory == category.name
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
