import 'package:flutter/material.dart';

import '../constant/colors.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColor.buttonColor,
      ),
    );
  }
}
