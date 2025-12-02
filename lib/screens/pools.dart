import 'package:flutter/material.dart';
import '../widgets/pools_widget.dart';

class Pools extends StatefulWidget {
  const Pools({Key? key}) : super(key: key);

  State<Pools> createState() => _PoolsState();
}

class _PoolsState extends State<Pools> {

  Widget build(BuildContext context) {
    return const PoolsWidget();
  }
}