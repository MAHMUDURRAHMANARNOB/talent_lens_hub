import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:iconsax/iconsax.dart';
import 'package:talent_lens_hub/common/widgets/custom_shapes/containers/searchContainer.dart';
import 'package:talent_lens_hub/utils/constants/colors.dart';
import 'package:talent_lens_hub/utils/constants/sizes.dart';

import '../../../common/widgets/texts/section_heading.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/text_strings.dart';
import '../../../utils/helpers/helper_function.dart';

class JobScreen extends StatefulWidget {
  const JobScreen({super.key});

  @override
  State<JobScreen> createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> {
  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunction.isDarkMode(context);
    // bool darkMode = false;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              /*Header Text*/
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                // padding: const EdgeInsets.all(8.0),
                child: Text(TTexts.jobPageTitle,
                    style: Theme.of(context).textTheme.displaySmall),
              ),
              const SizedBox(height: TSizes.spaceBtwSections / 2),

              /*Search Box*/
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                child: SearchBar(
                  // controller: controller,
                  backgroundColor: darkMode
                      ? WidgetStatePropertyAll<Color?>((TColors.dark))
                      : WidgetStatePropertyAll<Color?>((TColors.light)),
                  hintText: "Enter your job title/skills",
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
                    /*Tooltip(
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
                    )*/
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
              const SizedBox(height: TSizes.spaceBtwSections / 2),
              /*Row(
                children: [
                  TSearchContainer(
                    text: "Enter Job title / skills",
                    showBackground: true,
                    showBorder: true,
                    icon: Iconsax.search_normal,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Iconsax.filter),
                  ),
                ],
              ),*/

              /*Category chip*/

              /*Recommended Jobs */
              Container(
                // color: TColors.primaryColor.withOpacity(0.1),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      TColors.yellowAccent,
                      TColors.tealAccent,
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                      TSizes.defaultSpace, 0.0, 0.0, TSizes.defaultSpace),
                  child: Column(
                    children: [
                      TSectionHeading(
                        title: "Recommended for you",
                        showActionButton: true,
                        buttonTitle: "View all",
                        onPressed: () {},
                        textColor: TColors.primaryColor,
                      ),
                      SizedBox(height: TSizes.spaceBtwItems / 2),
                      // job recommended scrolling container
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            /*main containers*/
                            Container(
                              // height: 240,
                              width: 290,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                    TSizes.borderRadiusLg),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Inner layer
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        8.0, 8.0, 8.0, 0.0),
                                    child: Container(
                                      // height: 180,
                                      width: 270,
                                      decoration: BoxDecoration(
                                        color: TColors.secondaryColor
                                            .withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(
                                            TSizes.borderRadiusLg),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Deadline & Bookmark Row
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                /*Deadline*/
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0)),
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text("20 May, 2024",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall),
                                                ),
                                                /*BookMark*/
                                                IconButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.white),
                                                  onPressed: () {},
                                                  icon: Icon(
                                                    Iconsax.bookmark,
                                                    size: 18,
                                                  ),
                                                )
                                              ],
                                            ),
                                            // Comapny name , job title , logo
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    //   company name,
                                                    Text("Shonod",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleMedium),
                                                    // Job Title
                                                    SizedBox(
                                                      width: 160,
                                                      child: Text(
                                                        "Automation QA Engineer (Mid level)",
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleLarge
                                                            ?.copyWith(
                                                                fontSize: 24),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                // Company Logo
                                                ClipOval(
                                                  child: Image.asset(
                                                    TImages.darkAppIcon,
                                                    width: 40,
                                                    height: 40,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                                height:
                                                    TSizes.spaceBtwItems / 2),

                                            //   Experience level
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 2.0),
                                              decoration: BoxDecoration(
                                                  color: Colors.transparent,
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0)),
                                              child: Text(
                                                "2 years",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14.0, vertical: 5.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("৳ 20,000/ month",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium),
                                            Text(
                                              "   Dhaka",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                      color: TColors.darkGrey),
                                            ),
                                          ],
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.black,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                          ),
                                          onPressed: () {},
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12.0),
                                            child: Text(
                                              "Details",
                                              /*style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                        color:
                                                            TColors.light)*/
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: TSizes.spaceBtwItems),
                            Container(
                              // height: 240,
                              width: 290,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                    TSizes.borderRadiusLg),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Inner layer
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        8.0, 8.0, 8.0, 0.0),
                                    child: Container(
                                      // height: 180,
                                      width: 270,
                                      decoration: BoxDecoration(
                                        color: TColors.secondaryColor
                                            .withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(
                                            TSizes.borderRadiusLg),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Deadline & Bookmark Row
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                /*Deadline*/
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0)),
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text("20 May, 2024",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall),
                                                ),
                                                /*BookMark*/
                                                IconButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.white),
                                                  onPressed: () {},
                                                  icon: Icon(
                                                    Iconsax.bookmark,
                                                    size: 18,
                                                  ),
                                                )
                                              ],
                                            ),
                                            // Comapny name , job title , logo
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    //   company name,
                                                    Text("Shonod",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleMedium),
                                                    // Job Title
                                                    SizedBox(
                                                      width: 160,
                                                      child: Text(
                                                        "Automation QA Engineer (Mid level)",
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleLarge
                                                            ?.copyWith(
                                                                fontSize: 24),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                // Company Logo
                                                ClipOval(
                                                  child: Image.asset(
                                                    TImages.darkAppIcon,
                                                    width: 40,
                                                    height: 40,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                                height:
                                                    TSizes.spaceBtwItems / 2),

                                            //   Experience level
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 2.0),
                                              decoration: BoxDecoration(
                                                  color: Colors.transparent,
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0)),
                                              child: Text(
                                                "2 years",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14.0, vertical: 5.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("৳ 20,000/ month",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium),
                                            Text(
                                              "   Dhaka",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                      color: TColors.darkGrey),
                                            ),
                                          ],
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.black,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                          ),
                                          onPressed: () {},
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12.0),
                                            child: Text(
                                              "Details",
                                              /*style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                        color:
                                                            TColors.light)*/
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /*Most recent Jobs */
            ],
          ),
        ),
      ),
    );
  }
}
