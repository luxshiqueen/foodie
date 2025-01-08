import 'package:flutter/material.dart';

const Color kBackgroundColor = Colors.black;
const Color kButtonColor = Colors.orange;
const TextStyle kHeadingStyle =
    TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold);
const TextStyle kInputTextStyle = TextStyle(color: Colors.white);
const InputDecoration kInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white10,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  hintStyle: TextStyle(color: Colors.grey),
);
