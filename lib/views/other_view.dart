import 'package:flutter/material.dart';

class OtherView extends StatelessWidget {
  final String text;
  const OtherView({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(text),
      ),
    );
  }
}
