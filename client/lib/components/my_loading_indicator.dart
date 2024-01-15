import 'package:flutter/material.dart';
import 'package:shopping_list/constants/colors.dart';

class MyLoadingIndicator extends StatelessWidget {
  const MyLoadingIndicator({
    this.inverted = false,
    super.key,
  });

  final bool inverted;

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          CircularProgressIndicator(
            color: inverted ? kSecondaryColor : kQuaternaryColor,
            strokeWidth: 8,
          ),
          CircularProgressIndicator(
            color: inverted ? kTernaryColor : kPrimaryColor,
          ),
        ],
      );
}
