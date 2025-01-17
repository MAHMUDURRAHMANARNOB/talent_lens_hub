import 'dart:convert';
import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:markdown_widget/config/configs.dart';
import 'package:markdown_widget/config/markdown_generator.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:markdown_widget/markdown_widget.dart' as MW;
import 'package:speech_to_text/speech_to_text.dart';
import 'package:talent_lens_hub/features/subscriptions/screens/SubscriptionPlansScreen.dart';

import '../../../common/latexGenerator.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/helper_function.dart';
import '../../authentication/providers/auth_provider.dart';
import '../datamodel/studyToolsDataModel.dart';
import '../providers/toolsResponseProvider.dart';

class ToolsContentScreen extends StatefulWidget {
  final String? toolsName;

  const ToolsContentScreen({super.key, this.toolsName});

  @override
  State<ToolsContentScreen> createState() => _ToolsContentScreenState();
}

class _ToolsContentScreenState extends State<ToolsContentScreen> {
  List<Widget> _lessonComponents = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String dropdownClassValue = "";
  String dropdownSubjectValue = "";
  TextEditingController questionTextFieldController = TextEditingController();
  TextEditingController skillsTextFieldController = TextEditingController();
  TextEditingController interestedTopicsTextFieldController =
      TextEditingController();
  TextEditingController experienceTextFieldController = TextEditingController();
  TextEditingController jobTitleTextFieldController = TextEditingController();
  TextEditingController jobDescriptionTextFieldController =
      TextEditingController();
  TextEditingController personalSkillsTextFieldController =
      TextEditingController();
  ScrollController _scrollController = ScrollController();

  late ToolsResponseProvider toolsResponseProvider =
      Provider.of<ToolsResponseProvider>(context, listen: false);

  File? _selectedImage;
  bool _isImageSelected = false;
  bool isSelected = false;
  bool isImagePicked = false;
  bool _isReply = false;
  bool _isNewQuestion = false;

  late int userID;
  late bool isLoading = true;

  late String _question = '';
  late String _skills = '';
  late String _interestedTopic = '';
  late String _experience = '';
  late String _jobTitle = '';
  late String _jobDescription = '';
  late String _personalSkills = '';

  late SpeechToText _speech;
  bool _isListening = false;
  bool toolsFetched = false;

  @override
  void initState() {
    super.initState();

    _speech = SpeechToText();
  }

  late bool dark;

  @override
  Widget build(BuildContext context) {
    dark = THelperFunction.isDarkMode(context);
    userID = Provider.of<AuthProvider>(context, listen: false).user!.id;

    // toolsDataProvider = Provider.of<ToolsDataProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.toolsName!),
        centerTitle: true,
      ),
      floatingActionButton: Visibility(
        visible: !_isNewQuestion,
        child: !_lessonComponents.isEmpty
            ? FloatingActionButton.extended(
                onPressed: () {
                  setState(() {
                    _isNewQuestion = true;
                    _isReply = false;
                  });
                },
                label: const Text(
                  'New Question',
                  style: TextStyle(
                    color: TColors.primaryColor,
                  ),
                ),
                icon: const Icon(
                  Icons.add,
                  color: TColors.primaryColor,
                ),
                backgroundColor: dark
                    ? TColors.primaryColor.withOpacity(0.2)
                    : TColors.primaryBackground,
              )
            : Container(),
      ),
      body: SafeArea(child: MainContent()),
    );
  }

  Widget MainContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Container(
            width: double.infinity,
            // color: Colors.grey[100],
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: BouncingScrollPhysics(),
              child: _lessonComponents.isNotEmpty
                  ? Column(
                      children: _lessonComponents,
                    )
                  : Container(
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // job title
                          Visibility(
                            visible:
                                widget.toolsName == "Interview Questions" ||
                                    widget.toolsName == "Cover Letter",
                            child: Column(
                              children: [
                                TextFormField(
                                  maxLines: 1,
                                  controller: jobTitleTextFieldController,
                                  cursorColor: TColors.primaryColor,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: TColors.primaryColor,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    labelText: "Job Title",
                                    hintText: "i.e.: Software Engineer",
                                    border: OutlineInputBorder(),
                                  ),
                                  onChanged: (value) {
                                    _jobTitle = value;
                                  },
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),

                          // job description
                          Visibility(
                            visible: widget.toolsName == "Interview Questions",
                            child: Column(
                              children: [
                                TextFormField(
                                  maxLines: 4,
                                  controller: jobDescriptionTextFieldController,
                                  cursorColor: TColors.primaryColor,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: TColors.primaryColor,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    labelText:
                                        "Job Description (For better result)",
                                    hintText:
                                        "i.e: \"Keeping up with product and technical knowledge\nScheduling and performing demonstrations\nAnswering customer questions\nAttending trade shows and company meetings\"",
                                    border: OutlineInputBorder(),
                                  ),
                                  onChanged: (value) {
                                    _jobDescription = value;
                                  },
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),

                          // personal skills
                          Visibility(
                            visible: widget.toolsName == "Cover Letter",
                            child: Column(
                              children: [
                                TextFormField(
                                  maxLines: 3,
                                  controller: personalSkillsTextFieldController,
                                  cursorColor: TColors.primaryColor,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: TColors.primaryColor,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    labelText: "Personal Skills",
                                    hintText:
                                        "i.e.: Python, Problem Solving, dJango",
                                    border: OutlineInputBorder(),
                                  ),
                                  onChanged: (value) {
                                    _personalSkills = value;
                                  },
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),

                          // question
                          Visibility(
                            visible:
                                widget.toolsName != "Interview Questions" &&
                                    widget.toolsName != "Cover Letter",
                            child: Column(
                              children: [
                                TextFormField(
                                  maxLines: 3,
                                  controller: questionTextFieldController,
                                  cursorColor: TColors.primaryColor,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: TColors.primaryColor,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    labelText: "Enter your problem",
                                    border: OutlineInputBorder(),
                                  ),
                                  onChanged: (value) {
                                    _question = value;
                                  },
                                ),
                                SizedBox(height: 10.0),
                                if (_selectedImage != null)
                                  Visibility(
                                    visible: _isImageSelected,
                                    child: Stack(
                                      children: [
                                        ClipPath(
                                          child: Container(
                                            padding: const EdgeInsets.all(5.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              child: Image.file(
                                                _selectedImage!,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            height: 80,
                                            width: 80,
                                          ),
                                        ),
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: GestureDetector(
                                            onTap: _removeImage,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors
                                                    .red, // Background color of the button
                                              ),
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Icon(
                                                Icons.close,
                                                color: Colors.white,
                                                // Color of the icon
                                                size: 16.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                SizedBox(height: 10.0),
                                Visibility(
                                  visible: widget.toolsName == "Math Solution",
                                  child: TextButton.icon(
                                    onPressed: () {
                                      _showImageSourceDialog();
                                      print(isImagePicked);
                                      setState(() {
                                        isImagePicked = true;
                                      });
                                    },
                                    icon: Icon(
                                      Iconsax.gallery_add,
                                      color: TColors.secondaryColor,
                                    ),
                                    label: Text(
                                      "Add Image",
                                      style: TextStyle(
                                          color: TColors.secondaryColor),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.0),
                              ],
                            ),
                          ),

                          // career counselor
                          Visibility(
                            visible: widget.toolsName == "Career Counselor",
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: skillsTextFieldController,
                                  cursorColor: TColors.primaryColor,
                                  decoration: InputDecoration(
                                    labelText: "Skills (Optional)",
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: TColors.primaryColor,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    border: OutlineInputBorder(),
                                  ),
                                  onChanged: (value) {
                                    _skills = value;
                                  },
                                ),
                                SizedBox(height: 10.0),
                                TextFormField(
                                  controller:
                                      interestedTopicsTextFieldController,
                                  cursorColor: TColors.primaryColor,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: TColors.primaryColor,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    labelText: "Interested Topic (Optional)",
                                    border: OutlineInputBorder(),
                                  ),
                                  onChanged: (value) {
                                    _interestedTopic = value;
                                  },
                                ),
                                SizedBox(height: 10.0),
                                TextFormField(
                                  controller: experienceTextFieldController,
                                  cursorColor: TColors.primaryColor,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: TColors.primaryColor,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    labelText: "Experience (Optional)",
                                    border: OutlineInputBorder(),
                                  ),
                                  onChanged: (value) {
                                    _experience = value;
                                  },
                                ),
                                SizedBox(height: 10.0),
                              ],
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: TColors.primaryColor),
                            onPressed: () {
                              setState(() {
                                if (widget.toolsName == "Career Counselor" &&
                                    _question.isNotEmpty) {
                                  _lessonComponents.add(
                                    generateCareerCounselorResponse(
                                      context,
                                      userID,
                                      _question,
                                      _skills,
                                      _interestedTopic,
                                      _experience,
                                    ),
                                  );

                                  skillsTextFieldController.clear();
                                  interestedTopicsTextFieldController.clear();
                                  experienceTextFieldController.clear();
                                } else if (widget.toolsName ==
                                        "Math Solution" &&
                                    _question.isNotEmpty) {
                                  _lessonComponents.add(
                                    generateMathSolutionResponse(
                                      context,
                                      userID,
                                      _question,
                                    ),
                                  );
                                } else if (widget.toolsName ==
                                        "Math Solution" &&
                                    _selectedImage != null &&
                                    isImagePicked) {
                                  _lessonComponents.add(
                                    generateSolveBanglaMathImageResponse(
                                      context,
                                      _selectedImage!,
                                      userID,
                                      _question,
                                    ),
                                  );
                                } else if (widget.toolsName == "Life Coach" &&
                                    _question.isNotEmpty) {
                                  _lessonComponents.add(
                                    generateLifeCoachResponse(
                                      context,
                                      userID,
                                      _question,
                                    ),
                                  );
                                } else if (widget.toolsName ==
                                        "Mental Health" &&
                                    _question.isNotEmpty) {
                                  _lessonComponents.add(
                                    generateMentalHealthResponse(
                                      context,
                                      userID,
                                      _question,
                                    ),
                                  );
                                } else if (widget.toolsName ==
                                        "Relationship Coach" &&
                                    _question.isNotEmpty) {
                                  _lessonComponents.add(
                                    generateRelationshipCoachResponse(
                                      context,
                                      userID,
                                      _question,
                                    ),
                                  );
                                } else if (widget.toolsName == "Psychology" &&
                                    _question.isNotEmpty) {
                                  _lessonComponents.add(
                                    generatePsychologyResponse(
                                      context,
                                      userID,
                                      _question,
                                    ),
                                  );
                                } else if (widget.toolsName ==
                                        "Interview Questions" &&
                                    _jobTitle.isNotEmpty) {
                                  _lessonComponents.add(
                                    generateInterviewQuestionResponse(
                                        context,
                                        userID,
                                        _jobTitle,
                                        _jobDescription,
                                        "10"),
                                  );
                                } else if (widget.toolsName == "Cover Letter" &&
                                    _jobTitle.isNotEmpty) {
                                  _lessonComponents.add(
                                    generateCoverLetterResponse(
                                      context,
                                      userID,
                                      _jobTitle,
                                      _personalSkills,
                                    ),
                                  );
                                }

                                questionTextFieldController.clear();
                                _selectedImage = null;
                                _isImageSelected = false;
                                isImagePicked = false;
                                _isReply = false;
                                _isNewQuestion = false;
                                _question = '';
                              });
                            },
                            child: Container(
                              width: double.infinity,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: const Text(
                                "Advice Me",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          const Text(
                            "N.B: We do not store any of you personal information",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ),
        Visibility(
          visible: _isNewQuestion,
          child: newQuestionBarWidget(),
        )
      ],
    );
  }

  void _removeImage() {
    setState(() {
      _selectedImage = null;
    });
  }

  Widget newQuestionBarWidget() {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // job title
          Visibility(
            visible: widget.toolsName == "Interview Questions" ||
                widget.toolsName == "Cover Letter",
            child: Column(
              children: [
                TextFormField(
                  maxLines: 1,
                  controller: jobTitleTextFieldController,
                  cursorColor: TColors.primaryColor,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: TColors.primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    labelText: "Job Title",
                    hintText: "i.e.: Software Engineer",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _jobTitle = value;
                  },
                ),
                SizedBox(height: 10),
              ],
            ),
          ),

          // job description
          Visibility(
            visible: widget.toolsName == "Interview Questions",
            child: Column(
              children: [
                TextFormField(
                  maxLines: 4,
                  controller: jobDescriptionTextFieldController,
                  cursorColor: TColors.primaryColor,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: TColors.primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    labelText: "Job Description (For better result)",
                    hintText:
                        "i.e: \"Keeping up with product and technical knowledge\nScheduling and performing demonstrations\nAnswering customer questions\nAttending trade shows and company meetings\"",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _jobDescription = value;
                  },
                ),
                SizedBox(height: 10),
              ],
            ),
          ),

          // personal skills
          Visibility(
            visible: widget.toolsName == "Cover Letter",
            child: Column(
              children: [
                TextFormField(
                  maxLines: 3,
                  controller: personalSkillsTextFieldController,
                  cursorColor: TColors.primaryColor,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: TColors.primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    labelText: "Personal Skills",
                    hintText: "i.e.: Python, Problem Solving, dJango",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _personalSkills = value;
                  },
                ),
                SizedBox(height: 10),
              ],
            ),
          ),

          // question
          Visibility(
            visible: widget.toolsName != "Interview Questions" &&
                widget.toolsName != "Cover Letter",
            child: Column(
              children: [
                TextFormField(
                  maxLines: 3,
                  controller: questionTextFieldController,
                  cursorColor: TColors.primaryColor,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: TColors.primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    labelText: "Enter your problem",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _question = value;
                  },
                ),
                SizedBox(height: 10.0),
                if (_selectedImage != null)
                  Visibility(
                    visible: _isImageSelected,
                    child: Stack(
                      children: [
                        ClipPath(
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Image.file(
                                _selectedImage!,
                                fit: BoxFit.cover,
                              ),
                            ),
                            height: 80,
                            width: 80,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: _removeImage,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors
                                    .red, // Background color of the button
                              ),
                              padding: const EdgeInsets.all(5.0),
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                                // Color of the icon
                                size: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: 10.0),
                Visibility(
                  visible: widget.toolsName == "Math Solution",
                  child: TextButton.icon(
                    onPressed: () {
                      _showImageSourceDialog();
                      print(isImagePicked);
                      setState(() {
                        isImagePicked = true;
                      });
                    },
                    icon: Icon(
                      Iconsax.gallery_add,
                      color: TColors.secondaryColor,
                    ),
                    label: Text(
                      "Add Image",
                      style: TextStyle(color: TColors.secondaryColor),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
              ],
            ),
          ),

          // career counselor
          Visibility(
            visible: widget.toolsName == "Career Counselor",
            child: Column(
              children: [
                TextFormField(
                  controller: skillsTextFieldController,
                  cursorColor: TColors.primaryColor,
                  decoration: InputDecoration(
                    labelText: "Skills (Optional)",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: TColors.primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _skills = value;
                  },
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  controller: interestedTopicsTextFieldController,
                  cursorColor: TColors.primaryColor,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: TColors.primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    labelText: "Interested Topic (Optional)",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _interestedTopic = value;
                  },
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  controller: experienceTextFieldController,
                  cursorColor: TColors.primaryColor,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: TColors.primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    labelText: "Experience (Optional)",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _experience = value;
                  },
                ),
                SizedBox(height: 10.0),
              ],
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(backgroundColor: TColors.primaryColor),
            onPressed: () {
              setState(() {
                if (widget.toolsName == "Career Counselor" &&
                    _question.isNotEmpty) {
                  _lessonComponents.add(
                    generateCareerCounselorResponse(
                      context,
                      userID,
                      _question,
                      _skills,
                      _interestedTopic,
                      _experience,
                    ),
                  );

                  skillsTextFieldController.clear();
                  interestedTopicsTextFieldController.clear();
                  experienceTextFieldController.clear();
                } else if (widget.toolsName == "Math Solution" &&
                    _question.isNotEmpty) {
                  _lessonComponents.add(
                    generateMathSolutionResponse(
                      context,
                      userID,
                      _question,
                    ),
                  );
                } else if (widget.toolsName == "Math Solution" &&
                    _selectedImage != null &&
                    isImagePicked) {
                  _lessonComponents.add(
                    generateSolveBanglaMathImageResponse(
                      context,
                      _selectedImage!,
                      userID,
                      _question,
                    ),
                  );
                } else if (widget.toolsName == "Life Coach" &&
                    _question.isNotEmpty) {
                  _lessonComponents.add(
                    generateLifeCoachResponse(
                      context,
                      userID,
                      _question,
                    ),
                  );
                } else if (widget.toolsName == "Mental Health" &&
                    _question.isNotEmpty) {
                  _lessonComponents.add(
                    generateMentalHealthResponse(
                      context,
                      userID,
                      _question,
                    ),
                  );
                } else if (widget.toolsName == "Relationship Coach" &&
                    _question.isNotEmpty) {
                  _lessonComponents.add(
                    generateRelationshipCoachResponse(
                      context,
                      userID,
                      _question,
                    ),
                  );
                } else if (widget.toolsName == "Psychology" &&
                    _question.isNotEmpty) {
                  _lessonComponents.add(
                    generatePsychologyResponse(
                      context,
                      userID,
                      _question,
                    ),
                  );
                } else if (widget.toolsName == "Interview Questions" &&
                    _jobTitle.isNotEmpty) {
                  _lessonComponents.add(
                    generateInterviewQuestionResponse(
                        context, userID, _jobTitle, _jobDescription, "10"),
                  );
                } else if (widget.toolsName == "Cover Letter" &&
                    _jobTitle.isNotEmpty) {
                  _lessonComponents.add(
                    generateCoverLetterResponse(
                      context,
                      userID,
                      _jobTitle,
                      _personalSkills,
                    ),
                  );
                }

                questionTextFieldController.clear();
                _selectedImage = null;
                _isImageSelected = false;
                _isReply = false;
                _isNewQuestion = false;
                _question = '';
                _jobDescription = '';
                _jobTitle = '';
                _skills = '';
                _interestedTopic = '';
                _experience = '';
                _personalSkills = '';
              });
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: const Text(
                "Advice Me",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const Text(
            "N.B: We do not store any of you personal information",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _listen() async {
    if (!_isListening) {
      print("Listening if: $_isListening");
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        print("Listening if available: $_isListening");
        setState(() {
          _isListening = true;
        });

        print("Listening if: $_isListening");
        _speech.listen(
          onResult: (val) => setState(() {
            // _text = val.recognizedWords;
            questionTextFieldController.text = val.recognizedWords;
            _question = val.recognizedWords;
            _isListening = false;
          }),
        );
      } else {
        setState(() {
          _isListening = false;
        });
      }
    } else {
      setState(() {
        _isListening = false;
        print("Listening else: $_isListening");
      });
      _speech.stop();
    }
  }

  Future<File?> _pickImage(BuildContext context, ImageSource source) async {
    final picker = ImagePicker();
    XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      _cropImage(pickedFile.path);
      setState(() {
        _isImageSelected = true;
      });

      print("file picked ${pickedFile.path}");
      return File(pickedFile.path);
    } else {
      print("nothing picked");
      return null;
    }
  }

  Future<void> _showImageSourceDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Choose Image Source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: TColors.primaryColor.withOpacity(0.1)),
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                    _pickImage(context, ImageSource.gallery);
                  },
                  child: Text(
                    'Pick from Gallery',
                    style: TextStyle(color: TColors.primaryColor),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: TColors.primaryColor.withOpacity(0.1)),
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                    _pickImage(context, ImageSource.camera);
                  },
                  child: Text(
                    'Capture from Camera',
                    style: TextStyle(color: TColors.primaryColor),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _cropImage(String imagePath) async {
    print("File is here $imagePath");
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imagePath,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9,
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: TColors.primaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );

    if (croppedFile != null) {
      // Do something with the cropped image (e.g., display, upload, etc.)
      // You can use croppedFile.path to get the path of the cropped image.
      setState(() {
        _selectedImage = File(croppedFile.path);
      });
    }
  }

  Widget generateMathSolutionResponse(
    BuildContext context,
    int userid,
    String problemText,
  ) {
    bool _isPressed = false;
    final toolsResponseProvider =
        Provider.of<ToolsResponseProvider>(context, listen: false);
    return FutureBuilder<void>(
      future:
          toolsResponseProvider.fetchMathSolutionResponse(userid, problemText),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 5.0),
                  child: Image.asset(
                    "assets/images/animations/loader_tlh.gif",
                    width: 40,
                    height: 40,
                  ),
                ),
                SizedBox(
                  child: Shimmer.fromColors(
                    baseColor: TColors.primaryColor,
                    highlightColor: Colors.white,
                    child: const Text(
                      'Preparing...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ); // Loading state
        } else if (snapshot.hasError) {
          return Container(
            margin: const EdgeInsets.all(5.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: TColors.primaryColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "Sorry: ${toolsResponseProvider.toolsResponse!.message ?? "Server error"}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          if (toolsResponseProvider.toolsResponse != null &&
              toolsResponseProvider.toolsResponse!.errorCode == 200) {
            final response = toolsResponseProvider.toolsResponse;
            final lessonAnswerEncoded = response!.answer;
            final lessonAnswer =
                utf8.decode(lessonAnswerEncoded!.runes.toList());

            // final ticketId = response.ticketId!;
            return Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                // color: TColors.primaryColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /*Top Part*/
                  /*Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$selectedClass ${selectedSubject != "null" ? selectedSubject : ""}",
                          softWrap: true,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "$question",
                          softWrap: true,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: TColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),*/
                  Container(
                    width: double.infinity,
                    // margin: const EdgeInsets.all(10.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: dark
                          ? TColors.black
                          : TColors.primaryColor.withOpacity(0.2),
                      border: Border.all(
                          color: TColors.primaryColor.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: MW.MarkdownWidget(
                      data: lessonAnswer,
                      shrinkWrap: true,
                      selectable: true,
                      config: MarkdownConfig.defaultConfig,
                      markdownGenerator: MarkdownGenerator(
                          generators: [latexGenerator],
                          inlineSyntaxList: [LatexSyntax()]),
                    ),
                  ),
                  /*SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                TColors.primaryColor.withOpacity(0.1),
                          ),
                          onPressed: () {
                            setState(() {
                              _isReply = true;
                              _isNewQuestion = false;
                              // _selectedticketId = ticketId!;
                            });
                          },
                          child: Text(
                            "Reply",
                            style: TextStyle(
                              color: TColors.primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(width: 5.0),
                      ],
                    ),
                  ),*/
                ],
              ),
            );
          } else {
            return Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: TColors.primaryColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "Sorry: ${toolsResponseProvider.toolsResponse!.message}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: TColors.primaryColor),
                      onPressed: () {
                        /*Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PackagesScreen()),
                        );*/
                      },
                      child: const Text(
                        "Buy Subscription",
                        style: TextStyle(
                          color: TColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        }
      },
    );
  }

  Widget generateSolveBanglaMathImageResponse(
    BuildContext context,
    File questionImage,
    int userid,
    String question,
  ) {
    final Future<void> responseFuture =
        toolsResponseProvider.fetchMathImageSolutionResponse(
      questionImage,
      userid,
      question,
    );
    return FutureBuilder<void>(
      future: responseFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          /*return const SpinKitThreeInOut(
            color: TColors.primaryColor,
          ); */
          return Container(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 5.0),
                  child: Image.asset(
                    "assets/images/animations/loader_tlh.gif",
                    width: 40,
                    height: 40,
                  ),
                ),
                SizedBox(
                  child: Shimmer.fromColors(
                    baseColor: TColors.primaryColor,
                    highlightColor: Colors.white,
                    child: const Text(
                      'Preparing...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ); // Loading state
        } else if (snapshot.hasError) {
          return Container(
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: TColors.grey,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  toolsResponseProvider.solveBanglaMathDataModel != null &&
                          toolsResponseProvider
                                  .solveBanglaMathDataModel!.message !=
                              null
                      ? Text(
                          "Sorry: ${toolsResponseProvider.solveBanglaMathDataModel!.message}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : const Text(
                          "Sorry: You ran out of your Homework-tokens or your subscription is Expired. "),
                  toolsResponseProvider.solveBanglaMathDataModel != null &&
                          toolsResponseProvider
                                  .solveBanglaMathDataModel!.errorCode ==
                              201
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: TColors.primaryBackground),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SubscriptionListScreen()),
                            );
                          },
                          child: const Text(
                            "Buy Subscription",
                            style: TextStyle(
                              color: TColors.primaryColor,
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          );
        } else {
          if (toolsResponseProvider.solveBanglaMathDataModel != null &&
              toolsResponseProvider.solveBanglaMathDataModel!.errorCode ==
                  200) {
            final response = toolsResponseProvider.solveBanglaMathDataModel;
            final lessonAnswer = response!.answer;
            /*final lessonAnswer =
                utf8.decode(lessonAnswerEncoded!.runes.toList());*/
            final ticketId = response.ticketId!;

            return Container(
              // Your 'T' case UI code
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: TColors.primaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /*Top Part*/

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: const EdgeInsets.all(5.0),
                    width: double.infinity,
                    height: 100,
                    child: Image.file(
                      questionImage,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Text("$question"),
                  ),
                  MW.MarkdownWidget(
                    data: lessonAnswer!,
                    shrinkWrap: true,
                    selectable: true,
                    // config: MarkdownConfig.darkConfig,
                    markdownGenerator: MarkdownGenerator(
                        generators: [latexGenerator],
                        inlineSyntaxList: [LatexSyntax()]),
                  ),
                ],
              ),
            );
          } else {
            return Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: TColors.primaryBackground,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "Sorry: ${toolsResponseProvider.toolsResponse!.message}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: TColors.primaryBackground),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const SubscriptionListScreen()),
                        );
                      },
                      child: const Text(
                        "Buy Subscription",
                        style: TextStyle(
                          color: TColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        }
      },
    );
  }

  Widget generateCareerCounselorResponse(
    BuildContext context,
    int userid,
    String problemText,
    String skillText,
    String interstTopic,
    String experinceText,
  ) {
    bool _isPressed = false;
    final toolsResponseProvider =
        Provider.of<ToolsResponseProvider>(context, listen: false);
    return FutureBuilder<void>(
      future: toolsResponseProvider.fetchCareerCounselorResponse(
          userid, problemText, skillText, interstTopic, experinceText),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 5.0),
                  child: Image.asset(
                    "assets/images/animations/loader_tlh.gif",
                    width: 40,
                    height: 40,
                  ),
                ),
                SizedBox(
                  child: Shimmer.fromColors(
                    baseColor: TColors.primaryColor,
                    highlightColor: Colors.white,
                    child: const Text(
                      'Preparing...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ); // Loading state
        } else if (snapshot.hasError) {
          return Container(
            margin: const EdgeInsets.all(5.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: TColors.primaryColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "Sorry: ${toolsResponseProvider.toolsResponse!.message ?? "Server error"}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          if (toolsResponseProvider.toolsResponse != null &&
              toolsResponseProvider.toolsResponse!.errorCode == 200) {
            final response = toolsResponseProvider.toolsResponse;
            final lessonAnswerEncoded = response!.answer;
            final lessonAnswer =
                utf8.decode(lessonAnswerEncoded!.runes.toList());

            // final ticketId = response.ticketId!;
            return Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                // color: TColors.primaryColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /*Top Part*/
                  /*Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$selectedClass ${selectedSubject != "null" ? selectedSubject : ""}",
                          softWrap: true,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "$question",
                          softWrap: true,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: TColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),*/
                  Container(
                    width: double.infinity,
                    // margin: const EdgeInsets.all(10.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: dark
                          ? TColors.black
                          : TColors.primaryColor.withOpacity(0.2),
                      border: Border.all(
                          color: TColors.primaryColor.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: MW.MarkdownWidget(
                      data: lessonAnswer,
                      shrinkWrap: true,
                      selectable: true,
                      config: MarkdownConfig.defaultConfig,
                      markdownGenerator: MarkdownGenerator(
                          generators: [latexGenerator],
                          inlineSyntaxList: [LatexSyntax()]),
                    ),
                  ),
                  /*SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                TColors.primaryColor.withOpacity(0.1),
                          ),
                          onPressed: () {
                            setState(() {
                              _isReply = true;
                              _isNewQuestion = false;
                              // _selectedticketId = ticketId!;
                            });
                          },
                          child: Text(
                            "Reply",
                            style: TextStyle(
                              color: TColors.primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(width: 5.0),
                      ],
                    ),
                  ),*/
                ],
              ),
            );
          } else {
            return Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: TColors.primaryColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "Sorry: ${toolsResponseProvider.toolsResponse!.message}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: TColors.primaryColor),
                      onPressed: () {
                        /*Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PackagesScreen()),
                        );*/
                      },
                      child: const Text(
                        "Buy Subscription",
                        style: TextStyle(
                          color: TColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        }
      },
    );
  }

  Widget generateLifeCoachResponse(
    BuildContext context,
    int userid,
    String problemText,
  ) {
    bool _isPressed = false;
    final toolsResponseProvider =
        Provider.of<ToolsResponseProvider>(context, listen: false);
    return FutureBuilder<void>(
      future: toolsResponseProvider.fetchLifeCoachResponse(userid, problemText),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 5.0),
                  child: Image.asset(
                    "assets/images/animations/loader_tlh.gif",
                    width: 40,
                    height: 40,
                  ),
                ),
                SizedBox(
                  child: Shimmer.fromColors(
                    baseColor: TColors.primaryColor,
                    highlightColor: Colors.white,
                    child: const Text(
                      'Preparing...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ); // Loading state
        } else if (snapshot.hasError) {
          return Container(
            margin: const EdgeInsets.all(5.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: TColors.primaryColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "Sorry: ${toolsResponseProvider.toolsResponse!.message ?? "Server error"}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          if (toolsResponseProvider.toolsResponse != null &&
              toolsResponseProvider.toolsResponse!.errorCode == 200) {
            final response = toolsResponseProvider.toolsResponse;
            final lessonAnswerEncoded = response!.answer;
            final lessonAnswer =
                utf8.decode(lessonAnswerEncoded!.runes.toList());

            // final ticketId = response.ticketId!;
            return Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                // color: TColors.primaryColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /*Top Part*/
                  /*Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$selectedClass ${selectedSubject != "null" ? selectedSubject : ""}",
                          softWrap: true,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "$question",
                          softWrap: true,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: TColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),*/
                  Container(
                    width: double.infinity,
                    // margin: const EdgeInsets.all(10.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: dark
                          ? TColors.black
                          : TColors.primaryColor.withOpacity(0.2),
                      border: Border.all(
                          color: TColors.primaryColor.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: MW.MarkdownWidget(
                      data: lessonAnswer,
                      shrinkWrap: true,
                      selectable: true,
                      config: MarkdownConfig.defaultConfig,
                      markdownGenerator: MarkdownGenerator(
                          generators: [latexGenerator],
                          inlineSyntaxList: [LatexSyntax()]),
                    ),
                  ),
                  /*SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                TColors.primaryColor.withOpacity(0.1),
                          ),
                          onPressed: () {
                            setState(() {
                              _isReply = true;
                              _isNewQuestion = false;
                              // _selectedticketId = ticketId!;
                            });
                          },
                          child: Text(
                            "Reply",
                            style: TextStyle(
                              color: TColors.primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(width: 5.0),
                      ],
                    ),
                  ),*/
                ],
              ),
            );
          } else {
            return Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: TColors.primaryColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "Sorry: ${toolsResponseProvider.toolsResponse!.message}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: TColors.primaryColor),
                      onPressed: () {
                        /*Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PackagesScreen()),
                        );*/
                      },
                      child: const Text(
                        "Buy Subscription",
                        style: TextStyle(
                          color: TColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        }
      },
    );
  }

  Widget generateMentalHealthResponse(
    BuildContext context,
    int userid,
    String problemText,
  ) {
    bool _isPressed = false;
    final toolsResponseProvider =
        Provider.of<ToolsResponseProvider>(context, listen: false);
    return FutureBuilder<void>(
      future:
          toolsResponseProvider.fetchMentalHealthResponse(userid, problemText),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 5.0),
                  child: Image.asset(
                    "assets/images/animations/loader_tlh.gif",
                    width: 40,
                    height: 40,
                  ),
                ),
                SizedBox(
                  child: Shimmer.fromColors(
                    baseColor: TColors.primaryColor,
                    highlightColor: Colors.white,
                    child: const Text(
                      'Preparing...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ); // Loading state
        } else if (snapshot.hasError) {
          return Container(
            margin: const EdgeInsets.all(5.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: TColors.primaryColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "Sorry: ${toolsResponseProvider.toolsResponse!.message ?? "Server error"}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          if (toolsResponseProvider.toolsResponse != null &&
              toolsResponseProvider.toolsResponse!.errorCode == 200) {
            final response = toolsResponseProvider.toolsResponse;
            final lessonAnswerEncoded = response!.answer;
            final lessonAnswer =
                utf8.decode(lessonAnswerEncoded!.runes.toList());

            // final ticketId = response.ticketId!;
            return Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                // color: TColors.primaryColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /*Top Part*/
                  /*Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$selectedClass ${selectedSubject != "null" ? selectedSubject : ""}",
                          softWrap: true,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "$question",
                          softWrap: true,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: TColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),*/
                  Container(
                    width: double.infinity,
                    // margin: const EdgeInsets.all(10.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: dark
                          ? TColors.black
                          : TColors.primaryColor.withOpacity(0.2),
                      border: Border.all(
                          color: TColors.primaryColor.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: MW.MarkdownWidget(
                      data: lessonAnswer,
                      shrinkWrap: true,
                      selectable: true,
                      config: MarkdownConfig.defaultConfig,
                      markdownGenerator: MarkdownGenerator(
                          generators: [latexGenerator],
                          inlineSyntaxList: [LatexSyntax()]),
                    ),
                  ),
                  /*SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                TColors.primaryColor.withOpacity(0.1),
                          ),
                          onPressed: () {
                            setState(() {
                              _isReply = true;
                              _isNewQuestion = false;
                              // _selectedticketId = ticketId!;
                            });
                          },
                          child: Text(
                            "Reply",
                            style: TextStyle(
                              color: TColors.primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(width: 5.0),
                      ],
                    ),
                  ),*/
                ],
              ),
            );
          } else {
            return Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: TColors.primaryColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "Sorry: ${toolsResponseProvider.toolsResponse!.message}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: TColors.primaryColor),
                      onPressed: () {
                        /*Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PackagesScreen()),
                        );*/
                      },
                      child: const Text(
                        "Buy Subscription",
                        style: TextStyle(
                          color: TColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        }
      },
    );
  }

  Widget generateRelationshipCoachResponse(
    BuildContext context,
    int userid,
    String problemText,
  ) {
    bool _isPressed = false;
    final toolsResponseProvider =
        Provider.of<ToolsResponseProvider>(context, listen: false);
    return FutureBuilder<void>(
      future: toolsResponseProvider.fetchRelationshipCoachResponse(
          userid, problemText),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 5.0),
                  child: Image.asset(
                    "assets/images/animations/loader_tlh.gif",
                    width: 40,
                    height: 40,
                  ),
                ),
                SizedBox(
                  child: Shimmer.fromColors(
                    baseColor: TColors.primaryColor,
                    highlightColor: Colors.white,
                    child: const Text(
                      'Preparing...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ); // Loading state
        } else if (snapshot.hasError) {
          return Container(
            margin: const EdgeInsets.all(5.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: TColors.primaryColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "Sorry: ${toolsResponseProvider.toolsResponse!.message ?? "Server error"}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          if (toolsResponseProvider.toolsResponse != null &&
              toolsResponseProvider.toolsResponse!.errorCode == 200) {
            final response = toolsResponseProvider.toolsResponse;
            final lessonAnswerEncoded = response!.answer;
            final lessonAnswer =
                utf8.decode(lessonAnswerEncoded!.runes.toList());

            // final ticketId = response.ticketId!;
            return Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                // color: TColors.primaryColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /*Top Part*/
                  /*Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$selectedClass ${selectedSubject != "null" ? selectedSubject : ""}",
                          softWrap: true,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "$question",
                          softWrap: true,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: TColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),*/
                  Container(
                    width: double.infinity,
                    // margin: const EdgeInsets.all(10.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: dark
                          ? TColors.black
                          : TColors.primaryColor.withOpacity(0.2),
                      border: Border.all(
                          color: TColors.primaryColor.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: MW.MarkdownWidget(
                      data: lessonAnswer,
                      shrinkWrap: true,
                      selectable: true,
                      config: MarkdownConfig.defaultConfig,
                      markdownGenerator: MarkdownGenerator(
                          generators: [latexGenerator],
                          inlineSyntaxList: [LatexSyntax()]),
                    ),
                  ),
                  /*SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                TColors.primaryColor.withOpacity(0.1),
                          ),
                          onPressed: () {
                            setState(() {
                              _isReply = true;
                              _isNewQuestion = false;
                              // _selectedticketId = ticketId!;
                            });
                          },
                          child: Text(
                            "Reply",
                            style: TextStyle(
                              color: TColors.primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(width: 5.0),
                      ],
                    ),
                  ),*/
                ],
              ),
            );
          } else {
            return Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: TColors.primaryColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "Sorry: ${toolsResponseProvider.toolsResponse!.message}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: TColors.primaryColor),
                      onPressed: () {
                        /*Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PackagesScreen()),
                        );*/
                      },
                      child: const Text(
                        "Buy Subscription",
                        style: TextStyle(
                          color: TColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        }
      },
    );
  }

  Widget generatePsychologyResponse(
    BuildContext context,
    int userid,
    String problemText,
  ) {
    bool _isPressed = false;
    final toolsResponseProvider =
        Provider.of<ToolsResponseProvider>(context, listen: false);
    return FutureBuilder<void>(
      future:
          toolsResponseProvider.fetchPsychologyResponse(userid, problemText),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 5.0),
                  child: Image.asset(
                    "assets/images/animations/loader_tlh.gif",
                    width: 40,
                    height: 40,
                  ),
                ),
                SizedBox(
                  child: Shimmer.fromColors(
                    baseColor: TColors.primaryColor,
                    highlightColor: Colors.white,
                    child: const Text(
                      'Preparing...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ); // Loading state
        } else if (snapshot.hasError) {
          return Container(
            margin: const EdgeInsets.all(5.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: TColors.primaryColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "Sorry: ${toolsResponseProvider.toolsResponse!.message ?? "Server error"}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          if (toolsResponseProvider.toolsResponse != null &&
              toolsResponseProvider.toolsResponse!.errorCode == 200) {
            final response = toolsResponseProvider.toolsResponse;
            final lessonAnswerEncoded = response!.answer;
            final lessonAnswer =
                utf8.decode(lessonAnswerEncoded!.runes.toList());

            // final ticketId = response.ticketId!;
            return Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                // color: TColors.primaryColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /*Top Part*/
                  /*Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$selectedClass ${selectedSubject != "null" ? selectedSubject : ""}",
                          softWrap: true,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "$question",
                          softWrap: true,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: TColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),*/
                  Container(
                    width: double.infinity,
                    // margin: const EdgeInsets.all(10.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: dark
                          ? TColors.black
                          : TColors.primaryColor.withOpacity(0.2),
                      border: Border.all(
                          color: TColors.primaryColor.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: MW.MarkdownWidget(
                      data: lessonAnswer,
                      shrinkWrap: true,
                      selectable: true,
                      config: MarkdownConfig.defaultConfig,
                      markdownGenerator: MarkdownGenerator(
                          generators: [latexGenerator],
                          inlineSyntaxList: [LatexSyntax()]),
                    ),
                  ),
                  /*SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                TColors.primaryColor.withOpacity(0.1),
                          ),
                          onPressed: () {
                            setState(() {
                              _isReply = true;
                              _isNewQuestion = false;
                              // _selectedticketId = ticketId!;
                            });
                          },
                          child: Text(
                            "Reply",
                            style: TextStyle(
                              color: TColors.primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(width: 5.0),
                      ],
                    ),
                  ),*/
                ],
              ),
            );
          } else {
            return Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: TColors.primaryColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "Sorry: ${toolsResponseProvider.toolsResponse!.message}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: TColors.primaryColor),
                      onPressed: () {
                        /*Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PackagesScreen()),
                        );*/
                      },
                      child: const Text(
                        "Buy Subscription",
                        style: TextStyle(
                          color: TColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        }
      },
    );
  }

  Widget generateInterviewQuestionResponse(
    BuildContext context,
    int userId,
    String jobTitle,
    String jobDescription,
    String noOfQuestions,
  ) {
    bool _isPressed = false;
    final toolsResponseProvider =
        Provider.of<ToolsResponseProvider>(context, listen: false);
    return FutureBuilder<void>(
      future: toolsResponseProvider.fetchInterviewQuestionResponse(
          userId, jobTitle, jobDescription, noOfQuestions),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 5.0),
                  child: Image.asset(
                    "assets/images/animations/loader_tlh.gif",
                    width: 40,
                    height: 40,
                  ),
                ),
                SizedBox(
                  child: Shimmer.fromColors(
                    baseColor: TColors.primaryColor,
                    highlightColor: Colors.white,
                    child: const Text(
                      'Preparing...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ); // Loading state
        } else if (snapshot.hasError) {
          return Container(
            margin: const EdgeInsets.all(5.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: TColors.primaryColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "Sorry: ${toolsResponseProvider.interviewQuestionDataModel!.message ?? "Server error"}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          if (toolsResponseProvider.interviewQuestionDataModel != null &&
              toolsResponseProvider.interviewQuestionDataModel!.errorCode ==
                  200) {
            final response = toolsResponseProvider.interviewQuestionDataModel;
            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: response?.interviewQuestions.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: TColors.success.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12.0),
                        child: /*Text(
                          response!.interviewQuestions[index].question,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),*/
                            MW.MarkdownWidget(
                          data: response!.interviewQuestions[index].question,
                          shrinkWrap: true,
                          selectable: true,
                          config: MarkdownConfig.defaultConfig,
                          markdownGenerator: MarkdownGenerator(
                              generators: [latexGenerator],
                              inlineSyntaxList: [LatexSyntax()]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          response.interviewQuestions[index].answer,
                          // overflow: TextOverflow.ellipsis,
                          // maxLines: 3,
                          style: const TextStyle(
                              // fontSize: 18.0,
                              // fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: TColors.primaryColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "Sorry: ${toolsResponseProvider.interviewQuestionDataModel!.message}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: TColors.primaryColor),
                      onPressed: () {
                        /*Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PackagesScreen()),
                        );*/
                      },
                      child: const Text(
                        "Buy Subscription",
                        style: TextStyle(
                          color: TColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        }
      },
    );
  }

  Widget generateCoverLetterResponse(
    BuildContext context,
    int userId,
    String jobTitle,
    String personalSkills,
  ) {
    bool _isPressed = false;
    final toolsResponseProvider =
        Provider.of<ToolsResponseProvider>(context, listen: false);
    return FutureBuilder<void>(
      future: toolsResponseProvider.fetchCoverLetterResponse(
          userId, jobTitle, personalSkills),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 5.0),
                  child: Image.asset(
                    "assets/images/animations/loader_tlh.gif",
                    width: 40,
                    height: 40,
                  ),
                ),
                SizedBox(
                  child: Shimmer.fromColors(
                    baseColor: TColors.primaryColor,
                    highlightColor: Colors.white,
                    child: const Text(
                      'Preparing...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ); // Loading state
        } else if (snapshot.hasError) {
          return Container(
            margin: const EdgeInsets.all(5.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: TColors.primaryColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "Sorry: ${toolsResponseProvider.coverLetterResponseDataModel!.message ?? "Server error"}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          if (toolsResponseProvider.coverLetterResponseDataModel != null &&
              toolsResponseProvider.coverLetterResponseDataModel!.errorCode ==
                  200) {
            final response = toolsResponseProvider.coverLetterResponseDataModel;
            final coverLetterEncoded = response!.coverLetter;
            final lessonAnswer = utf8.decode(coverLetterEncoded.runes.toList());
            return Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                // color: TColors.primaryColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /*Top Part*/
                  Text(
                    jobTitle,
                    style: TextStyle(
                      color: TColors.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  MW.MarkdownWidget(
                    data: lessonAnswer,
                    shrinkWrap: true,
                    selectable: true,
                    config: MarkdownConfig.defaultConfig,
                    markdownGenerator: MarkdownGenerator(
                        generators: [latexGenerator],
                        inlineSyntaxList: [LatexSyntax()]),
                  ),
                ],
              ),
            );
          } else {
            return Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: TColors.primaryColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "Sorry: ${toolsResponseProvider.coverLetterResponseDataModel!.message}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: TColors.primaryColor),
                      onPressed: () {
                        /*Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PackagesScreen()),
                        );*/
                      },
                      child: const Text(
                        "Buy Subscription",
                        style: TextStyle(
                          color: TColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        }
      },
    );
  }
}
