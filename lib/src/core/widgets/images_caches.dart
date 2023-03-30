import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:simple_key/src/core/widgets/loading_indicator.dart';

class ImageCaches extends StatelessWidget {
  const ImageCaches({
    super.key,
    required this.imageUrl,
    this.width = 300,
  });

  final String imageUrl;
  final double width;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      errorWidget: (context, url, error) => const Icon(Icons.error),
      placeholder: (BuildContext context, String url) => const Spinner(),
      maxWidthDiskCache: 500,
      maxHeightDiskCache: 500,
      fit: BoxFit.cover,
      width: width,
    );
  }
}
