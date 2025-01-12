import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talent_lens_hub/utils/constants/colors.dart';

import '../../../authentication/providers/auth_provider.dart';
import '../Providers/CourseExamProvider.dart';

class ExamScreen extends StatefulWidget {
  final int courseId;

  const ExamScreen({Key? key, required this.courseId}) : super(key: key);

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  late int userId;
  int? selectedAnswerId;

  @override
  void initState() {
    super.initState();
    // Fetch the first question when the UI loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<CourseExamProvider>(context, listen: false);
      userId = Provider.of<AuthProvider>(context, listen: false).user!.id;
// Reset the provider's state to ensure a fresh start
      provider.resetState();
      provider.fetchQuestion(
        userId: userId.toString(),
        courseId: widget.courseId.toString(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CourseExamProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Course Exam"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: provider.isLoading
            ? const Center(
                child: CircularProgressIndicator(color: TColors.secondaryColor),
              )
            : provider.errorMessage != null
                ? Center(
                    child: Text(
                      'Error: ${provider.errorMessage}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  )
                : provider.isExamCompleted
                    ? _buildExamCompletionView(provider)
                    : provider.currentQuestion == null
                        ? const Center(
                            child: Text('No question available'),
                          )
                        : _buildQuestionView(provider),
      ),
    );
  }

  Widget _buildQuestionView(CourseExamProvider provider) {
    final question = provider.currentQuestion!;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Question: ${question.questionText}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ...question.answers!.map((answer) {
            return RadioListTile<int>(
              value: answer.id,
              groupValue: selectedAnswerId,
              activeColor: TColors.secondaryColor,
              title: Text(answer.text),
              onChanged: (value) {
                setState(() {
                  selectedAnswerId = value;
                });
              },
            );
          }).toList(),
          const Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: TColors.secondaryColor,
              elevation: 6,
              side: BorderSide(color: TColors.secondaryColor),
            ),
            onPressed: selectedAnswerId == null
                ? null // Disable button if no answer is selected
                : () {
                    provider.fetchQuestion(
                      userId: userId.toString(),
                      courseId: widget.courseId.toString(),
                      examPaperId: question.examPaperId.toString(),
                      questionId: question.questionId.toString(),
                      ansId: selectedAnswerId.toString(),
                    );
                    setState(() {
                      selectedAnswerId = null; // Reset the selected answer
                    });
                  },
            child: SizedBox(
              width: double.infinity,
              child: const Text(
                textAlign: TextAlign.center,
                'Next',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExamCompletionView(CourseExamProvider provider) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            provider.completionMessage,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text(
            "Your Score: ${provider.finalScore?.toStringAsFixed(2) ?? '0.0'}",
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          if (provider.certificateEligible)
            const Icon(Icons.verified, color: Colors.green, size: 40),
          const SizedBox(height: 32),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: TColors.primaryColor,
            ),
            onPressed: () {
              Navigator.pop(context); // Navigate back to the previous screen
            },
            child: SizedBox(
              width: double.infinity,
              child: const Text(
                textAlign: TextAlign.center,
                'Finish',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
