import 'package:flutter/material.dart';

void main() {
  const String s = String.fromEnvironment("API_KEY");

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
