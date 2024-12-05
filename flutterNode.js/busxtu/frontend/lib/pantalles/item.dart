import 'package:flutter/material.dart';

class Item {

  final String titol;
  final String imatgeUrl;
  final Function(BuildContext) accio;

  Item(this.titol, this.imatgeUrl, this.accio);

}