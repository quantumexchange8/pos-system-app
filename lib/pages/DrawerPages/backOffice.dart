import 'package:flutter/material.dart';

class BackOffice extends StatelessWidget {
  const BackOffice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text('Link to website')),
        ],
      ),
    );
  }
}