import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../courses/courses_page.dart';

class ShimmerCard extends StatelessWidget {
  const ShimmerCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        // Shimmer
        Shimmer.fromColors(
      child: Container(
        margin: EdgeInsets.all(8),
        child: Container(
          width: 292,
          height: 236,
          child: Card(
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
        ),
      ),
      baseColor: Theme.of(context).colorScheme.onPrimaryContainer,
      highlightColor: Theme.of(context).colorScheme.inversePrimary,
    );
  }
}

class AdminFullPageShimmer extends StatelessWidget {
  final int count ;
   AdminFullPageShimmer({Key? key, required this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Wrap(
              alignment: WrapAlignment.center,
              runSpacing: 30,
              children: List.generate(count, (index) => ShimmerCard()),
              
              
            ),
          ),
        ),
      ],
    );
  }
}
