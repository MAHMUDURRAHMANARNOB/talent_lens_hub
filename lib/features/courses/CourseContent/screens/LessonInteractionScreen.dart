import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:markdown_widget/widget/markdown.dart' as MW;
import 'package:provider/provider.dart';
import 'package:talent_lens_hub/features/courses/Provider/LessonQuestionAnswerProvider.dart';
import '../../../../utils/constants/colors.dart';
import '../../../authentication/providers/auth_provider.dart';

class LessonInteractionScreen extends StatefulWidget {
  final String lessonId;
  final String lessonContent;

  const LessonInteractionScreen(
      {super.key, required this.lessonId, required this.lessonContent});

  @override
  State<LessonInteractionScreen> createState() =>
      _LessonInteractionScreenState();
}

class _LessonInteractionScreenState extends State<LessonInteractionScreen> {
  ScrollController _scrollController = ScrollController();
  List<Widget> _lessonComponents = [];
  late String _questionText;
  TextEditingController _questionTextFieldController = TextEditingController();
  late int userId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _lessonComponents.add(
      Html(
        data: widget.lessonContent.toString(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    userId = Provider.of<AuthProvider>(context, listen: false).user!.id;
    return Scaffold(
      appBar: AppBar(
        title: Text("Interactive Section"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: _lessonComponents,
                  ),
                ),
              ),
              // Ask Question
              Container(
                color: TColors.white,
                padding: const EdgeInsets.fromLTRB(5.0, 8.0, 5.0, 8.0),
                child: Row(
                  children: [
                    /*Image Picker Button*/

                    /*Question Box*/
                    Expanded(
                      child: TextField(
                        controller: _questionTextFieldController,
                        maxLines: 3,
                        minLines: 1,
                        cursorColor: TColors.primaryColor,
                        decoration: const InputDecoration(
                          hintText: 'Type your message...',
                          border: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(40.0)),
                            borderSide: BorderSide(
                              color: TColors.primaryColor,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          _questionText = value;
                        },
                      ),
                    ),
                    /*Send Button*/
                    IconButton.filledTonal(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: TColors.white),
                      onPressed: () {
                        _scrollController.animateTo(
                            _scrollController.position.maxScrollExtent,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeOut);
                        Widget ansQuesComponent = generateAskQuesResponse(
                            widget.lessonId, _questionText);
                        setState(() {
                          _lessonComponents.add(ansQuesComponent);
                          _questionTextFieldController.clear();
                          _questionText = '';
                        });
                      },
                      icon: const Icon(
                        Icons.send_rounded,
                        color: TColors.primaryColor,
                      ),
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

  Widget generateAskQuesResponse(String lessonAnsId, String question) {
    bool _isPressed = false;

    final askQueProvider =
        Provider.of<LessonQuestionAnswerProvider>(context, listen: false);
    return FutureBuilder<void>(
      future: askQueProvider.fetchLessonQuestionAnswer(
          question: question, lessonAnswerId: lessonAnsId, userId: userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SpinKitThreeInOut(
            color: TColors.primaryColor,
          ); // Loading state
        } else if (snapshot.hasError) {
          return Text('ErrorSnapshotFutureBuilder: ${snapshot.error}');
        } else {
          final answer = askQueProvider.responseData?.answer ?? "";

          return Container(
            // Your 'T' case UI code
            margin: const EdgeInsets.all(5.0),
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              color: TColors.white,
              border: Border.all(color: TColors.primaryColor),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*Top Part*/

                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: Text(
                    "Question: ${question!.toString()}",
                    softWrap: true,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: TColors.primaryColor),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: Text(
                    "Answer:",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: TColors.secondaryColor),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: MW.MarkdownWidget(
                    selectable: true,
                    data: answer.toString(),
                    shrinkWrap: true,
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
