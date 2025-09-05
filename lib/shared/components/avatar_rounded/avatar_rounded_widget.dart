import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../helpers/app_assets.dart';
import '../../helpers/consts.dart';

class AvatarRoundedWidget extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;

  const AvatarRoundedWidget(
      {Key? key, this.image = imageDefault, this.height = 90, this.width = 90})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(100.0),
        child: CachedNetworkImage(
            height: height,
            width: width,
            fit: BoxFit.cover,
            imageUrl: image.isEmpty ? imageDefault : image,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress),
            errorWidget: (context, url, error) => CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage(AppAssets.noImage))));
  }
}
