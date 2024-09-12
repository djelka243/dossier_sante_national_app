
import 'package:flutter/material.dart';

class VerificationId extends StatefulWidget {
  const VerificationId({Key? key}) : super(key: key);

  @override
  State<VerificationId> createState() => _VerificationIdState();
}

class _VerificationIdState extends State<VerificationId> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Page de verification'),),
    );
  }
}
