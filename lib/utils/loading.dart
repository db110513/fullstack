import 'package:flutter/material.dart';

Widget loading(
    BuildContext context,
    Widget child,
    ImageChunkEvent? loadingProgress,
  ) {
  if (loadingProgress == null) return child;
  return Center(
    child: CircularProgressIndicator(
      color: Colors.white,
      value: loadingProgress.expectedTotalBytes != null
          ? loadingProgress.cumulativeBytesLoaded /
              loadingProgress.expectedTotalBytes!
          : null,
    ),
  );
}
