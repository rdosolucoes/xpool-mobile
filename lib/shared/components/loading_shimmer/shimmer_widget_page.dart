import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../helpers/custom_colors.dart';
import '../custom_widget/custom_widget.dart';

class ShimmerWidgetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Widget buildMovieShimmer() => ListTile(
          contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          leading: CustomWidget.circular(height: 64, width: 64),
          title: Align(
            alignment: Alignment.topLeft,
            child: CustomWidget.rectangular(
              height: 16,
              width: MediaQuery.of(context).size.width * 0.3,
            ),
          ),
          subtitle: CustomWidget.rectangular(height: 14),
        );

    return Container(
        height: size.height,
        child: ListView.builder(
          padding: EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 5,
          ),
          itemCount: 15,
          itemBuilder: (context, index) {
            return Shimmer.fromColors(
              baseColor: CustomColors.clearBlue,
              highlightColor: Colors.white,
              child: Container(
                  //padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: buildMovieShimmer()),
            );
          },
        ));
  }
}
