import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:talent_lens_hub/features/subscriptions/screens/InvoiceScreen.dart';
import 'package:talent_lens_hub/utils/constants/colors.dart';
import '../datamodels/subscriptionPlansDataModel.dart';
import '../providers/subscriptionPlanProvider.dart';

class SubscriptionListScreen extends StatelessWidget {
  const SubscriptionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SubscriptionProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscription Plans'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<SubscriptionPlan>>(
        future: provider.fetchSubscriptions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No subscription plans available.'),
            );
          } else {
            final subscriptions = snapshot.data!;
            return ListView.builder(
              itemCount: subscriptions.length,
              itemBuilder: (context, index) {
                final plan = subscriptions[index];
                return Visibility(
                  visible: plan.isActive == "Y",
                  child: Container(
                    decoration: BoxDecoration(
                      // color: TColors.success.withOpacity(0.2),
                      border: Border.all(color: TColors.primaryColor),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    margin: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/icons/light_icon.png",
                                height: 50,
                                width: 50,
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    plan.name,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Column(
                                          children: [
                                            Text(
                                              "৳ ${plan.price.toString()}",
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        " / year",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: TColors.darkerGrey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Iconsax.ticket,
                                    color: TColors.primaryColor,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Tickets",
                                    style: TextStyle(),
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.all(5.0),
                                padding:
                                    EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.0),
                                  color: TColors.primaryColor,
                                ),
                                child: Text(
                                  plan.noOfTickets.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Iconsax.document_code_2,
                                    color: TColors.primaryColor,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Comments",
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.all(5.0),
                                padding:
                                    EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.0),
                                  color: TColors.primaryColor,
                                ),
                                child: Text(
                                  plan.noOfComments.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Iconsax.code,
                                    color: TColors.primaryColor,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Courses",
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.all(5.0),
                                padding:
                                    EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.0),
                                  color: TColors.primaryColor,
                                ),
                                child: Text(
                                  plan.noOfCourse.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.0),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InvoiceScreen(
                                  packageID: plan.id,
                                  packageName: plan.name,
                                  packageValue: plan.price,
                                  discountValue: plan.discountAmt,
                                  payableAmount: plan.price,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 12.0),
                            decoration: BoxDecoration(
                              color: TColors.primaryColor,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(12.0),
                                bottomLeft: Radius.circular(12.0),
                              ),
                            ),
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                "Proceed to Payment",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
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
      ),
    );
  }
}
