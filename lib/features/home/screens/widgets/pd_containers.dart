import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_function.dart';

class PDContainer extends StatelessWidget {
  const PDContainer({
    super.key,
    required this.image,
    required this.title,
  });

  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    return Container(
      padding: EdgeInsets.all(TSizes.md),
      decoration: BoxDecoration(
        color: dark ? TColors.dark : TColors.light,
        borderRadius: BorderRadius.circular(TSizes.borderRadiusXXL),
      ),
      child: Column(
        children: [
          Image.asset(
            image,
            height: 100,
            width: 100,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
