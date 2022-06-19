
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class BusyShimmer extends StatelessWidget {
  const BusyShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: SizedBox(
        width: 292,
        height: 212,
        child: Container(
          color: const Color.fromARGB(221, 97, 92, 92),
        ),
      ),
      baseColor: Theme.of(context).primaryColor,
      highlightColor: const Color.fromARGB(131, 255, 255, 255),
    );
  }
}
