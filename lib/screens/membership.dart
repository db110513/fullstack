import 'package:flutter/material.dart';
import '../widgets/membership_widget.dart';

class Membership extends StatefulWidget {
  const Membership({Key? key}) : super(key: key);

  State<Membership> createState() => _MembershipState();
}

class _MembershipState extends State<Membership> {

  Widget build(BuildContext context) {
    return MembershipWidget();
  }
}