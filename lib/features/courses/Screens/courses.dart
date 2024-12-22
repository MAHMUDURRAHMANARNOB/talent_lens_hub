import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconsax/iconsax.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:talent_lens_hub/features/courses/CourseContent/screens/LessonListScreen.dart';
import 'package:talent_lens_hub/features/courses/DataModel/CourseListDataModel.dart';
import 'package:talent_lens_hub/features/courses/Provider/CourseListProvider.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    trainingCategoryProvider =
        Provider.of<TrainingCategoryProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunction.isDarkMode(context);

    courseListProvider = Provider.of<CourseListProvider>(context);
    /*return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 0,
              maxHeight: MediaQuery.of(context).size.height, // or a fixed value
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  child: SearchBar(
                    // controller: controller,
                    backgroundColor: darkMode
                        ? WidgetStatePropertyAll<Color?>((TColors.dark))
                        : WidgetStatePropertyAll<Color?>((TColors.light)),
                    hintText: "Search Course",
                    hintStyle: WidgetStatePropertyAll<TextStyle?>(
                        Theme.of(context).textTheme.bodySmall),
                    padding: const WidgetStatePropertyAll<EdgeInsets>(
                        EdgeInsets.symmetric(horizontal: TSizes.md)),
                    onTap: () {
                      // controller.openView();
                    },
                    onChanged: (_) {
                      // controller.openView();
                    },
                    leading: const Icon(Iconsax.search_normal),
                    trailing: <Widget>[
                      */ /*Tooltip(
                        message: 'Change brightness mode',
                        child: IconButton(
                          isSelected: darkMode,
                          onPressed: () {
                            setState(() {
                              darkMode = !darkMode;
                            });
                          },
                          icon: const Icon(Icons.wb_sunny_outlined),
                          selectedIcon: const Icon(Icons.brightness_2_outlined),
                        ),
                      )*/ /*
                      Tooltip(
                        message: 'Filter your search',
                        child: IconButton(
                          isSelected: darkMode,
                          onPressed: () {
                            // setState(() {
                            //   darkMode = !darkMode;
                            // });
                          },
                          icon: const Icon(Iconsax.filter),
                          // selectedIcon: const Icon(Icons.brightness_2_outlined),
                        ),
                      )
                    ],
                  ),
                ),
                */ /*Courses Category Chip Row*/ /*
                _courseCategoryList(),
                */ /*In Progress Text*/ /*
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                  child: TSectionHeading(
                    title: "In Progress",
                    showActionButton: true,
                    buttonTitle: "View All",
                    // onPressed: () {},
                    textColor: TColors.primaryColor,
                  ),
                ),

                */ /*In Progress Items Row*/ /*
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: TSizes.defaultSpace / 2),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          width: 200,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          decoration: BoxDecoration(
                            // color: TColors.primaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(
                              color: TColors.primaryColor,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Flexible(
                                flex: 1,
                                child: Text(
                                  "Python for Beginners",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              // SizedBox(width: 10.0),
                              CircularPercentIndicator(
                                radius: 20.0,
                                animation: true,
                                animationDuration: 500,
                                lineWidth: 5.0,
                                percent: 0.4,
                                center: new Text(
                                  "40%",
                                  style: new TextStyle(
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 12.0),
                                ),
                                circularStrokeCap: CircularStrokeCap.round,
                                // backgroundColor: Colors.white70,
                                progressColor: TColors.primaryColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: TSizes.spaceBtwSections / 2),
                */ /*Category Wise Name*/ /*
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: TSizes.defaultSpace),
                  child: TSectionHeading(
                    title: selectedCategory ?? "All Courses",
                    showActionButton: true,
                    buttonTitle: "View All",
                    // onPressed: () {},
                    textColor: TColors.primaryColor,
                  ),
                ),
                */ /*Category Wise Courses Load in onSelect*/ /*
                */ /*Render course list if a category is selected*/ /*
                Expanded(
                  child: Consumer<CourseListProvider>(
                    builder: (context, provider, child) {
                      if (provider.isLoading) {
                        return Center(
                          child: SpinKitCircle(color: TColors.primaryColor),
                        );
                      }
                      if (provider.courses.isEmpty) {
                        return Center(
                          child: Text(
                              "No courses available for the selected category."),
                        );
                      }
                      print(provider.courses.length);
                      return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: provider.courses.length,
                        itemBuilder: (context, index) {
                          final course = provider.courses[index];
                          return GestureDetector(
                            onTap: () {},
                            child: Container(
                              // color: Colors.white,
                              decoration: BoxDecoration(
                                color: TColors.primaryColor.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
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
                                subtitle: Text(
                                  course.courseDescription,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                leading: course.imgPath != null
                                    ? Image.network(course.imgPath!)
                                    : const Icon(Icons.book,
                                        color: TColors.primaryColor),
                                trailing: const Icon(Icons.arrow_forward_ios,
                                    color: TColors.primaryColor),
                                onTap: () {
                                  // Handle course item click
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );*/
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Search Bar
            Padding(
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
            ),

            // Courses Category Chip Row
            _courseCategoryList(),

            // In Progress Text
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
              child: TSectionHeading(
                title: "In Progress",
                showActionButton: true,
                buttonTitle: "View All",
                textColor: TColors.primaryColor,
              ),
            ),

            // In Progress Items Row
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.defaultSpace / 2),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      width: 200,
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                          color: TColors.primaryColor,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Text(
                              "Python for Beginners",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: darkMode ? Colors.white : Colors.black,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          CircularPercentIndicator(
                            radius: 20.0,
                            animation: true,
                            animationDuration: 500,
                            lineWidth: 5.0,
                            percent: 0.4,
                            center: Text(
                              "40%",
                              style: TextStyle(fontSize: 12.0),
                            ),
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: TColors.primaryColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: TSizes.spaceBtwSections / 2),

            // Category Wise Name
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
              child: TSectionHeading(
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
                      SizedBox(height: 5.0),
                      Row(
                        children: [
                          Text(
                            "Total Enrolled: ",
                            style: TextStyle(),
                          ),
                          Text(
                            "12068",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: TColors.secondaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  /*leading: course.imgPath != null
                      ? Image.network(course.imgPath!)
                      : const Icon(Iconsax.book, color: TColors.primaryColor),*/
                  trailing: const Icon(Iconsax.arrow_circle_right,
                      size: 24, color: TColors.primaryColor),
                  onTap: () {
                    // Handle course item click
                    print(course.id);
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
