import 'package:flutter/material.dart';
import 'package:reus_deportiu/widgets/departments_widget.dart';

class Departments extends StatefulWidget {
  const Departments({Key? key}) : super(key: key);

  State<Departments> createState() => _DepartmentsState();
}

class _DepartmentsState extends State<Departments> {

  Widget build(BuildContext context) {
    return const DepartmentsWidget();
  }
}