import 'package:flutter/material.dart';

class FailedAuthentication extends StatelessWidget {
  const FailedAuthentication({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Auth Failed"),
        ),
        body: Column(
            children:[]
        )
    );
  }
}