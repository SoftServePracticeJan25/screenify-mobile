import 'package:flutter/material.dart';

void main() {
  const String s = String.fromEnvironment("TEST");

  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(s),
        ),
      ),
    ),
  );
}
