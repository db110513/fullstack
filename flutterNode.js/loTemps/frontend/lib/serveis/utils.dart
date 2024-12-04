import 'package:flutter/material.dart';

class Utils {

  static void neteja(
      TextEditingController nomUsuariController,
      TextEditingController contrassenyaController) {
    nomUsuariController.clear();
    contrassenyaController.clear();
  }
}
