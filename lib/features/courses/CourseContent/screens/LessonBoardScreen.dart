import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconsax/iconsax.dart';
import 'package:markdown_widget/config/configs.dart';
import 'package:markdown_widget/widget/markdown.dart';
import 'package:talent_lens_hub/features/courses/Provider/LessonContentProvider.dart';

import '../../../../utils/constants/colors.dart';
import '../../Provider/LessonVideosProvider.dart';
import 'VideoPlayerBoard.dart';

class LessonBoardScreen extends StatefulWidget {
  final String lessonTitle;
  final int lessonId;

  const LessonBoardScreen(
      {super.key, required this.lessonTitle, required this.lessonId});

  @override
  State<LessonBoardScreen> createState() => _LessonBoardScreenState();
}

class _LessonBoardScreenState extends State<LessonBoardScreen>
    with SingleTickerProviderStateMixin {
  LessonContentProvider lessonContentProvider = LessonContentProvider();
  LessonVideosProvider lessonVideosProvider = LessonVideosProvider();
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  Widget _buildTabBar() {
    return TabBar(
      dividerColor: Colors.transparent,
      controller: _tabController,
      indicatorColor: TColors.primaryColor,
      labelColor: TColors.primaryColor,
      splashFactory: NoSplash.splashFactory,
      unselectedLabelColor: TColors.darkGrey,
      tabs: const [
        Tab(text: 'Lesson'),
        Tab(text: 'Videos'),
      ],
    );
  }

  Widget _buildTabBarView() {
    return Expanded(
      child: TabBarView(
        controller: _tabController,
        children: [
          // _buildAnswerSheet(),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height, // Define height here
            child: _lessonContent(),
          ),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height, // Define height here
            child: _videobody(widget.lessonId),
          ),
        ],
      ),
    );
  }

  final config = MarkdownConfig.defaultConfig;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.lessonTitle),
      ),
      body: _body(widget.lessonId),
    );
  }

  Widget _body(int lessonId) {
    return FutureBuilder<void>(
      future: lessonContentProvider.getLessonAnswer(lessonId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: SpinKitThreeInOut(
              color: TColors.primaryColor,
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (lessonContentProvider.errorMessage != null) {
          return Center(child: Text(lessonContentProvider.errorMessage!));
        } else {
          final lessoncontent =
              lessonContentProvider.lessonContentDataModel?.textAns;
          final lessonAnsId = lessonContentProvider.lessonContentDataModel?.id;
          final videoLessonList =
              lessonContentProvider.lessonContentDataModel?.videoSource;

          /*_lessonComponents.add(
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: MarkdownWidget(
                data: ieltsCourseLessonProvider
                    .ieltsCourseLessonResponse!.lessonContent
                    .toString(),
                config: config,
              ),
            ),
          );*/
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    _buildTabBar(),
                    _buildTabBarView(),
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Widget _lessonContent() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10.0),
      child: /*MarkdownWidget(
        data:
            lessonContentProvider.lessonContentDataModel!.textAns.toString() ??
                "",
        config: config,
      ),*/
          SingleChildScrollView(
        child: Html(
          data:
              lessonContentProvider.lessonContentDataModel!.textAns.toString(),
        ),
      ),

      // After the Markdown widget, display the other lesson components
    );
  }

  Widget _videobody(int lessonId) {
    return FutureBuilder<void>(
      future: lessonVideosProvider.fetchVideos(lessonId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: SpinKitThreeInOut(
              color: TColors.primaryColor,
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (lessonContentProvider.errorMessage != null) {
          return Center(child: Text(lessonContentProvider.errorMessage!));
        } else {
          final lessoncontent =
              lessonContentProvider.lessonContentDataModel?.textAns;
          final lessonAnsId = lessonContentProvider.lessonContentDataModel?.id;
          final videoLessonList =
              lessonContentProvider.lessonContentDataModel?.videoSource;

          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: lessonVideosProvider.lessonVideosDataModel!.length,
            itemBuilder: (context, index) {
              final video = lessonVideosProvider.lessonVideosDataModel![index];

              return GestureDetector(
                onTap: () {
                  // Fluttertoast.showToast(msg: video.lessonId.toString());
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VideoPlayerBoard(
                            videoUrl: video.videoUrl,
                            videoTitle: video.videoTitle,
                            isVideo: "Y",
                            videoId: video.id)),
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: TColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/images/dashboard_images/youtube.png",
                        width: 34,
                        height: 34,
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              video.videoTitle,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 1,
                                ),
                                Text(
                                  "Duration: ${video.videoDuration} minutes",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
