import 'package:flutter/material.dart';
import 'package:talent_lens_hub/features/courses/CourseExam/Screens/ExamScreen.dart';
import 'package:talent_lens_hub/utils/constants/colors.dart';

class CourseExamInstructionScreen extends StatefulWidget {
  final String courseName;
  final int courseId;

  const CourseExamInstructionScreen(
      {super.key, required this.courseName, required this.courseId});

  @override
  State<CourseExamInstructionScreen> createState() =>
      _CourseExamInstructionScreenState();
}

class _CourseExamInstructionScreenState
    extends State<CourseExamInstructionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Text(
                  "Exam for: ${widget.courseName}",
                  style: TextStyle(
                    color: TColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: TColors.primaryColor),
                            borderRadius: BorderRadius.circular(12.0)),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                color: TColors.primaryColor,
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              child: Icon(
                                Icons.question_answer,
                                color: Colors.white,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total Questions",
                                ),
                                Text(
                                  "30",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: TColors.primaryColor),
                            borderRadius: BorderRadius.circular(12.0)),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                color: TColors.secondaryColor,
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              child: Icon(
                                Icons.timer,
                                color: Colors.white,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Exam Duration",
                                ),
                                Text(
                                  "30 Minutes",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExamScreen(
                          courseId: widget.courseId,
                        ),
                      ),
                    );
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Start Exam",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Instructions",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: TColors.secondaryColor,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: Column(
                    children: [
                      Text(
                        "You have a maximum of 5 attempts to complete the exam, and to be eligible to download your certificate, you must achieve at least 50% of the total marks.",
                        style: TextStyle(color: TColors.primaryColor),
                      ),
                      SizedBox(height: 10.0),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '1. Internet Connectivity: ',
                              style: TextStyle(color: TColors.secondaryColor),
                            ),
                            TextSpan(
                              text:
                                  'Ensure a stable internet connection for the duration of the examination.',
                              style: TextStyle(color: TColors.black),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '2. Power Supply: ',
                              style: TextStyle(color: TColors.secondaryColor),
                            ),
                            TextSpan(
                              text:
                                  'Ensure your mobile or laptop is fully charged. Arrange for a power bank for mobiles or a UPS/Inverter for laptops/desktops to guarantee uninterrupted power supply.',
                              style: TextStyle(color: TColors.black),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '3. Data Requirements: ',
                              style: TextStyle(color: TColors.secondaryColor),
                            ),
                            TextSpan(
                              text:
                                  'Confirm that your mobile/laptop has sufficient data within the Fair Usage Policy (FUP) or your internet plan.',
                              style: TextStyle(color: TColors.black),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '4. Applications Management: ',
                              style: TextStyle(color: TColors.secondaryColor),
                            ),
                            TextSpan(
                              text:
                                  'Close all applications running in the background before initiating the online examination.',
                              style: TextStyle(color: TColors.black),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '5. Background apps Usage: ',
                              style: TextStyle(color: TColors.secondaryColor),
                            ),
                            TextSpan(
                              text:
                                  'Once the exam begins, refrain from switching to any other applications to avoid potential malpractice implications, which may lead to the termination of your exam.',
                              style: TextStyle(color: TColors.black),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.0),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Additional Notes : ',
                              style: TextStyle(color: TColors.secondaryColor),
                            ),
                            TextSpan(
                              text:
                                  'We recommend using web browsers such as Mozilla and Chrome on desktops/laptops/tabs/smartphones. Do not use the back button on the keyboard or the close button/icon to navigate back to the previous page or close the screen.',
                              style: TextStyle(color: TColors.black),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "Thank you for your cooperation. Best of luck with your examination!",
                        style: TextStyle(
                            color: TColors.secondaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
