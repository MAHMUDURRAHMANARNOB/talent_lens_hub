import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconsax/iconsax.dart';
import 'package:markdown_widget/config/configs.dart';
import 'package:markdown_widget/widget/markdown.dart';
import 'package:provider/provider.dart';
import 'package:talent_lens_hub/features/courses/Provider/VideoQuestionResponseProvider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_function.dart';

class VideoPlayerBoard extends StatefulWidget {
  final String videoUrl;
  final String videoTitle;
  final String isVideo;
  final int videoId;

  const VideoPlayerBoard(
      {super.key,
      required this.videoUrl,
      required this.videoTitle,
      required this.isVideo,
      required this.videoId});

  @override
  State<VideoPlayerBoard> createState() => _VideoPlayerBoardState();
}

class _VideoPlayerBoardState extends State<VideoPlayerBoard> {
  List<Widget> _lessonComponents = [];
  ScrollController _scrollController = ScrollController();
  late YoutubePlayerController _controller;
  TextEditingController questionTextFieldController = TextEditingController();

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  VideoQuestionResponseProvider videoQuestionResponseProvider =
      VideoQuestionResponseProvider();

  @override
  void initState() {
    // TODO: implement initState

    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.videoUrl)!,
      flags: YoutubePlayerFlags(
        showLiveFullscreenButton: false,
        useHybridComposition: true,
        autoPlay: true,
        mute: false,
        isLive: false,
      ),
    );
    super.initState();
  }

  late String sessionIdNew = "";
  late String _question = '';

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  late var dark;

  @override
  Widget build(BuildContext context) {
    dark = THelperFunction.isDarkMode(context);

    final userId = /*Provider.of<AuthProvider>(context).user?.id ?? 1*/ 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Video Lesson Board",
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
            // color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*Video*/
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  YoutubePlayer(
                    controller: _controller,
                    showVideoProgressIndicator: true,
                    // onReady: () => debugPrint("Ready"),
                    bottomActions: const [
                      CurrentPosition(),
                      ProgressBar(
                        isExpanded: true,
                        colors: ProgressBarColors(
                          playedColor: TColors.primaryColor,
                          handleColor: TColors.primaryColor,
                        ),
                      ),
                      // PlaybackSpeedButton(),
                      RemainingDuration(),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      widget.videoTitle,
                      style: TextStyle(
                        // color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  physics: BouncingScrollPhysics(),
                  child: _lessonComponents.isNotEmpty
                      ? Column(
                          children: _lessonComponents,
                        )
                      : Center(
                          child: Container(
                            decoration: BoxDecoration(
                              // color: TColors.white,
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(color: TColors.primaryColor),
                            ),
                            margin: EdgeInsets.all(8),
                            padding: EdgeInsets.all(16),
                            child: const Column(
                              children: [
                                Text(
                                  "Feel Free to Ask Anything About this Video",
                                  style: TextStyle(
                                    // color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Icon(
                                  Iconsax.arrow_down,
                                  color: TColors.primaryColor,
                                  size: 50,
                                ),
                              ],
                            ),
                          ),
                        ),
                ),
              ),
            ),

            /*Ask Question*/
            Visibility(
              // visible: _askQuestionActive,
              child: Container(
                color: Colors.transparent,
                // margin: EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    /*Question Box*/
                    Expanded(
                      child: TextField(
                        controller: questionTextFieldController,
                        maxLines: 3,
                        minLines: 1,
                        cursorColor: TColors.primaryColor,
                        decoration: const InputDecoration(
                          hintText: 'Ask anything about this video',
                          hintStyle: TextStyle(color: TColors.darkGrey),
                          border: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16.0)),
                            borderSide: BorderSide(
                              color: TColors.primaryColor,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          _question = value;
                        },
                      ),
                    ),
                    SizedBox(width: 2),
                    /*Send Button*/
                    IconButton.filledTonal(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: TColors.white,
                      ),
                      onPressed: () {
                        // Add your logic to send the message
                        setState(() {
                          questionTextFieldController.clear();
                          _lessonComponents.add(
                            _generateAnswerResponse(
                              _question,
                              widget.videoId,
                              userId,
                            ),
                          );
                        });
                      },
                      icon: const Icon(
                        Iconsax.direct_right,
                        color: TColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _generateAnswerResponse(
    String question,
    int videoId,
    int userid,
  ) {
    bool _isPressed = false;
    print("Pressed");

    return FutureBuilder<void>(
      future: videoQuestionResponseProvider.getVideoQuestionResponse(
          question, videoId, userid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SpinKitThreeInOut(
            color: TColors.primaryColor,
          ); // Loading state
        } else if (snapshot.hasError) {
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
                    "Sorry: ${videoQuestionResponseProvider.errorMessage ?? "Server error"}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          if (videoQuestionResponseProvider.videoQuestionResponse != null &&
              videoQuestionResponseProvider.videoQuestionResponse!.errorCode ==
                  200) {
            final response =
                videoQuestionResponseProvider.videoQuestionResponse!;
            final lessonAnswer = response.answer;
            /*sessionIdNew =
                ieltsLessonReplyProvider.ieltsCourseListResponse!.sessionId;
            print(sessionIdNew);*/

            // final ticketId = response.ticketId!;
            return Container(
              width: double.infinity,
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Part
                  Container(
                    width: double.infinity,
                    child: Text(
                      "Question: $question",
                      softWrap: true,
                      style: TextStyle(
                        color: ThemeData.dark() == ThemeData.dark()
                            ? Colors.lightBlue
                            : TColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    width: double.infinity,
                    // margin: const EdgeInsets.all(10.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: dark
                          ? TColors.primaryColor.withOpacity(0.5)
                          : TColors.light,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: MarkdownWidget(
                      data: lessonAnswer,
                      shrinkWrap: true,
                      selectable: true,
                      config: MarkdownConfig.darkConfig,
                    ),
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
                      "Sorry: ${videoQuestionResponseProvider.videoQuestionResponse!.message}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: TColors.primaryBackground),
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
