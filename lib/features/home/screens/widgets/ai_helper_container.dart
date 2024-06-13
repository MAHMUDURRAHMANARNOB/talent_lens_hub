import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:talent_lens_hub/utils/constants/sizes.dart';

class AiHelperContainer extends StatelessWidget {
  const AiHelperContainer({
    super.key,
    required this.image,
    required this.title,
  });

  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              image,
              height: 50,
              width: 50,
            ),
            SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
