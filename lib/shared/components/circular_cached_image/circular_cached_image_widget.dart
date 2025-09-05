import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CircularCachedNetworkImage extends StatelessWidget {
  final String imageURL;
  final double size;
  final Color borderColor;
  final BoxFit fit;
  final double borderWidth;

  const CircularCachedNetworkImage({
    required this.imageURL,
    required this.size,
    required this.borderColor,
    this.fit = BoxFit.cover,
    this.borderWidth = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: borderColor,
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: EdgeInsets.all(borderWidth),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white, // inner circle color
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(300.0)),
            child: CachedNetworkImage(
              imageUrl: imageURL,
              fit: fit,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        ),
      ),
    );
  }
}
