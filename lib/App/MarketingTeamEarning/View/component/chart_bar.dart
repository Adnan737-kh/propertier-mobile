import 'package:flutter/material.dart';
import 'package:propertier/constant/colors.dart';

class Chart extends StatelessWidget {
  const Chart({
    super.key,
  });

  double get maxTotalExpense {
    double maxTotalExpense = 0;

    for (final bucket in [10, 100, 20, 80, 10, 100, 70]) {
      if (bucket > maxTotalExpense) {
        maxTotalExpense = bucket.toDouble();
      }
    }

    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (final bucket in [
                30,
                40,
                100,
                10,
                35,
                35,
                40
              ]) // alternative to map()
                ChartBar(
                  color: AppColor.lightBlueColor,
                  fill: bucket == 0 ? 0 : bucket / maxTotalExpense,
                )
            ],
          ),
        ),
        // const SizedBox(height: 12),
        // Row(
        //   children: [10, 100, 20, 80] // for ... in
        //       .map(
        //         (bucket) => Expanded(
        //           child: Padding(
        //             padding: const EdgeInsets.symmetric(horizontal: 4),
        //             child: Icon(
        //               Icons.abc,
        //               color: isDarkMode
        //                   ? Theme.of(context).colorScheme.secondary
        //                   : Theme.of(context)
        //                       .colorScheme
        //                       .primary
        //                       .withOpacity(0.7),
        //             ),
        //           ),
        //         ),
        //       )
        // .toList(),
        // )
      ],
    );
  }
}

class ChartBar extends StatelessWidget {
  const ChartBar({
    super.key,
    required this.color,
    required this.fill,
  });
  final Color color;
  final double fill;

  @override
  Widget build(BuildContext context) {
    // final isDarkMode =
    // MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            FractionallySizedBox(
              widthFactor: 0.35,
              heightFactor: 1, // 0 <> 1
              child: DecoratedBox(
                decoration: BoxDecoration(
                  // shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xffCCCFDB),
                ),
              ),
            ),
            FractionallySizedBox(
              widthFactor: 0.35,
              heightFactor: fill, // 0 <> 1
              child: DecoratedBox(
                decoration: BoxDecoration(
                  // shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8),
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
