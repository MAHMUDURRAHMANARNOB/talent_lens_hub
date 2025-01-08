import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:talent_lens_hub/features/authentication/providers/UserStatesProvider.dart';

import '../../common/widgets/custom_shapes/containers/circular_container.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../authentication/providers/auth_provider.dart';
import '../authentication/screens/login/login.dart';
import '../subscriptions/screens/SubscriptionPlansScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserStatesProvider userStatesProvider = UserStatesProvider();

  late int userId;
  late String name;
  late String email;
  late String number;

  Future<void> _refresh() async {
    // userId = Provider.of<AuthProvider>(context).user!.id;
    // userName = Provider.of<AuthProvider>(context).user!.name;
    // final userId = Provider.of<AuthProvider>(context, listen: false).user?.id;
    await userStatesProvider.getUserStates(userId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    userId = authProvider.user!.id;
    name = authProvider.user!.name!;
    email = authProvider.user!.email!;
    number = authProvider.user!.mobile!;
    userStatesProvider.getUserStates(userId!);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserStatesProvider>().getUserStates(userId);
    });

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -150,
            right: -250,
            child: TCircularContainer(
              backgroundColor: TColors.secondaryColor.withOpacity(0.1),
            ),
          ),
          Positioned(
            bottom: -150,
            left: -250,
            child: TCircularContainer(
              backgroundColor: TColors.primaryColor.withOpacity(0.1),
            ),
          ),
          SafeArea(
            child: RefreshIndicator(
              onRefresh: _refresh,
              color: Colors.white,
              backgroundColor: TColors.primaryColor,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // TOP PART
                    Column(
                      children: [
                        Image.asset(
                          "assets/images/user_image.png",
                          height: 200,
                          // width: 100,
                        ),
                        SizedBox(height: TSizes.sm / 2),
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: TSizes.sm / 2),
                        Text(
                          email,
                          style: TextStyle(),
                        ),
                        SizedBox(height: TSizes.sm / 2),
                        Text(
                          number,
                          style: TextStyle(),
                        ),
                        SizedBox(height: TSizes.sm / 2),
                        /*ElevatedButton(
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text("Edit Profile"),
                          ),
                        ),*/
                      ],
                    ),

                    //   Tokens and other stuffs
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      width: double.infinity,
                      child: Text(
                        "Tokens",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: TColors.primaryColor,
                        ),
                      ),
                    ),
                    Consumer<UserStatesProvider>(
                        builder: (context, tokenProvider, child) {
                      final comments =
                          tokenProvider.userStats!.availableComments ?? 0;
                      final tickets =
                          tokenProvider.userStats!.availableTickets ?? 0;
                      final courses =
                          tokenProvider.userStats!.availableCourses ?? 0;
                      final enrolledCourses =
                          tokenProvider.userStats!.enrolledCourses ?? 0;
                      if (tokenProvider.userStats == null) {
                        // Show loader while data is being fetched
                        return Center(
                          child: SpinKitChasingDots(
                            color: TColors.primaryColor,
                            size: 20,
                          ),
                        );
                      }
                      /*if (tokenProvider.userStats!.availableTickets == null) {
                        // Show message if no data is found
                        return Center(
                          child: Text(
                            "No data available",
                            style: TextStyle(
                              color: TColors.primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }*/
                      // Display the data if available
                      return Container(
                        margin: EdgeInsets.all(10.0),
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            color: TColors.primaryColor.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(color: TColors.primaryColor)),
                        child: Column(
                          children: [
                            //   Homework Token
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.airplane_ticket,
                                        color: TColors.primaryColor,
                                      ),
                                    ),
                                    SizedBox(
                                      width: TSizes.sm,
                                    ),
                                    Text("Tickets"),
                                  ],
                                ),
                                Text(
                                  tickets.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: TColors.primaryColor,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                            Divider(
                              color: TColors.primaryColor,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.star,
                                        color: TColors.primaryColor,
                                      ),
                                    ),
                                    SizedBox(
                                      width: TSizes.sm,
                                    ),
                                    Text("Comments"),
                                  ],
                                ),
                                Text(
                                  comments.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: TColors.primaryColor,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                            Divider(
                              color: TColors.primaryColor,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.book,
                                        color: TColors.primaryColor,
                                      ),
                                    ),
                                    SizedBox(
                                      width: TSizes.sm,
                                    ),
                                    Text("Courses Token"),
                                  ],
                                ),
                                Text(
                                  courses.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: TColors.primaryColor,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                            Divider(
                              color: TColors.primaryColor,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.school_rounded,
                                        color: TColors.primaryColor,
                                      ),
                                    ),
                                    SizedBox(
                                      width: TSizes.sm,
                                    ),
                                    Text("Enrolled Courses"),
                                  ],
                                ),
                                Text(
                                  enrolledCourses.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: TColors.primaryColor,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),

                    //   Subscription Details
                    /*Container(
                        margin: EdgeInsets.all(10.0),
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        width: double.infinity,
                        child: Text(
                          "Subscription Details",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: TColors.primaryColor,
                          ),
                        )),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 10.0, right: 10.0, bottom: 10.0),
                      padding: const EdgeInsets.all(
                        10.0,
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: TColors.primaryColor.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(color: TColors.primaryColor)),
                      child: Column(
                        children: [
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'Active Package: ',
                              style: DefaultTextStyle.of(context).style,
                              children: const <TextSpan>[
                                TextSpan(
                                    text: 'Mastermind Pro',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: TColors.primaryColor,
                                      fontSize: 20,
                                    )),
                              ],
                            ),
                          ),
                          Divider(
                            color: TColors.primaryColor,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Purchased Date:"),
                              Text("28-Apr-2024"),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Valid Till:"),
                              Text("28-Apr-2024"),
                            ],
                          ),
                        ],
                      ),
                    ),*/

                    //   Preference
                    Container(
                        margin: const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 10.0),
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        width: double.infinity,
                        child: Text(
                          "Preferences",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: TColors.primaryColor,
                          ),
                        )),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: TColors.primaryColor.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(color: TColors.primaryColor)),
                      child: Column(
                        children: [
                          //   Subscription Plan
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SubscriptionListScreen(),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Iconsax.money_3,
                                        color: TColors.primaryColor,
                                      ),
                                    ),
                                    SizedBox(
                                      width: TSizes.sm,
                                    ),
                                    Text("Subscription plans"),
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  color: TColors.primaryColor,
                                  size: 30,
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: TColors.primaryColor,
                          ),
                          /*Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(6.0),
                                    ),
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.history,
                                      color: TColors.primaryColor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: TSizes.sm,
                                  ),
                                  Text("History"),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_rounded,
                                color: TColors.primaryColor,
                                size: 30,
                              ),
                            ],
                          ),
                          Divider(
                            color: TColors.primaryColor,
                          ),*/
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Logout"),
                                    content: Text(
                                        "Are you sure you want to logout?"),
                                    actions: <Widget>[
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: TColors.primaryColor
                                              .withOpacity(0.1),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(
                                              color: TColors.primaryColor),
                                        ),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: TColors
                                              .secondaryColor
                                              .withOpacity(0.1),
                                        ),
                                        onPressed: () {
                                          // Perform logout action here
                                          // For example: navigate to login screen
                                          Navigator.of(context).pop();
                                          authProvider.logout();
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginScreen()),
                                            (route) =>
                                                false, // This removes all routes in the stack
                                          );
                                        },
                                        child: Text("Logout",
                                            style: TextStyle(
                                                color: TColors.secondaryColor)),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        // color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Iconsax.logout_1,
                                        color: TColors.error,
                                      ),
                                    ),
                                    SizedBox(
                                      width: TSizes.sm,
                                    ),
                                    Text("Logout"),
                                  ],
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
          ),
        ],
      ),
    );
  }
}
