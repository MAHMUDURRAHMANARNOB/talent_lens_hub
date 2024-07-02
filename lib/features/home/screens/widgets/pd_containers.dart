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
    required this.bgColor,
  });

  final String image;
  final String title;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.all(TSizes.md),
      // width: double.infinity - TSizes.md,
      height: 80,
      decoration: BoxDecoration(
        color: /*dark ? TColors.dark : TColors.light*/ bgColor,
        borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: Colors.white),
            ),
          ),
          Image.asset(
            image,
            height: 100,
            width: 100,
          ),
        ],
      ),
    );
  }
}
